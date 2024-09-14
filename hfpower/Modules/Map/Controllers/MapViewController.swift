//
//  MapViewController.swift
//  hfpower
//
//  Created by EDY on 2024/5/30.
//

import UIKit
import MapKit
import FloatingPanel
class MapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate, BatteryRentalViewControllerDelegate, BatteryReplacementViewControllerDelegate, BikeRentalViewControllerDelegate {
    func rentBike(number: String?) {
        
    }
    
    func batteryReplacement(id: Int?, number: String?) {
        
    }
    
    func rentBattery(number: String?) {
        
    }
    
    func cabinetRentBattery(number: String?) {
        self.postData(cabinetScanRentUrl, param: ["cabinetNumber":number ?? ""], isLoading: true) { responseObject in
            if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],let list = body["list"]{
                if let typeList = HFBatteryRentalTypeInfo.mj_objectArray(withKeyValuesArray: list) as? [HFBatteryRentalTypeInfo]{
                  let batteryRentalChooseTypeViewController = BatteryRentalChooseTypeViewController()
                    batteryRentalChooseTypeViewController.items = typeList
                    self.navigationController?.pushViewController(batteryRentalChooseTypeViewController, animated: true)
                }
            }
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
        }
    }
    
    
    // MARK: - Accessor
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        // 在这里可以进行其他的配置
        manager.delegate = self
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        manager.requestWhenInUseAuthorization()
        
        
        return manager
    }()
    var didSelectBlock:((_ mapView: MKMapView, _ view: MKAnnotationView)->Void)?
    var didDeselectBlock:((_ mapView: MKMapView, _ view: MKAnnotationView)->Void)?
    
    let fpc = FloatingPanelController()
    
    // MARK: - Subviews
    lazy var mapView:MKMapView = {
        let map = MKMapView()
        map.overrideUserInterfaceStyle = .light
        map.showsUserLocation = true
        map.userTrackingMode = .follow
        map.pointOfInterestFilter = .includingAll
        map.showsCompass = false
        map.register(CenterAnnotationView.self, forAnnotationViewWithReuseIdentifier: String(describing: CenterAnnotationView.self))
        map.register(CabinetAnnotationView.self, forAnnotationViewWithReuseIdentifier: String(describing: CabinetAnnotationView.self))
        
        map.translatesAutoresizingMaskIntoConstraints = false
        map.delegate = self
        return map
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize debounce with a 0.5 second interval
        
        
        
        setupNavbar()
        setupSubviews()
        setupLayout()
        checkLocationAuthorizationStatus()
        
    }
    // 检查权限状态并做相应处理
    func checkLocationAuthorizationStatus() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            // 已经有权限，直接开始更新位置
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        case .notDetermined:
            // 用户还没有选择是否授权，请求授权
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            // 用户拒绝了授权或访问受限，提醒用户去设置里开启
            showLocationServicesDeniedAlert()
        @unknown default:
            break
        }
    }
    
    // 提示用户权限被拒绝或受限
    func showLocationServicesDeniedAlert() {
        let alert = UIAlertController(title: "定位服务已关闭",
                                      message: "请在设置中启用定位服务。",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func updateCabinetList(coordinate: CLLocationCoordinate2D){
        let code = CityCodeManager.shared.cityCode ?? "370200"
        var params = [String: Any]()
        let orderInfo = HFKeyedArchiverTool.batteryDepositOrderInfo()
        if orderInfo.id != nil {
            params = ["tempStorageSw": true]
        }
        params["cityCode"] = code.replacingLastTwoCharactersWithZeroes()
        params["lat"] = coordinate.latitude
        params["lon"] = coordinate.longitude
        self.getData(cabinetListUrl, param: params, isLoading: false) { responseObject in
            if let body = (responseObject as? [String: Any])?["body"] as? [String: Any],let pageResult = body["pageResult"] as? [String: Any],
               let dataList = pageResult["dataList"] as? [[String: Any]]{
                let cabinetArray = (HFCabinet.mj_objectArray(withKeyValuesArray: dataList) as? [HFCabinet]) ?? []
                
                var tempAnnotations =  self.mapView.annotations
                tempAnnotations.removeAll { annotation in
                    if annotation is CenterAnnotation{
                        return true
                    }else if annotation is MKUserLocation {
                        return true
                    }else{
                        return false
                    }
                }
                let finalAnnotations = tempAnnotations
                self.mapView.removeAnnotations(finalAnnotations)
                
                let annotations =  cabinetArray.map({ cabinet in
                    
                    let a = CabinetAnnotation(coordinate: CLLocationCoordinate2D(latitude: cabinet.bdLat?.doubleValue ?? 0, longitude: cabinet.bdLon?.doubleValue ?? 0), title: nil, subtitle: nil)
                    a.cabinet = cabinet
                    return a
                })
                self.mapView.addAnnotations(annotations)
                
                
            }
            
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
        }
    }
    func firstLoadData(){
        let userlocation = mapView.userLocation
        self.centerMapOnUserLocation(userLocation: userlocation)
        if CLLocationCoordinate2DIsValid(userlocation.coordinate){
            if let location = userlocation.location {
                
                let geocoder = CLGeocoder()
                geocoder.reverseGeocodeLocation(location) { placemarks, error in
                    if let _ = error{
                        
                    }else{
                        CityCodeManager.shared.placemark = placemarks?.first
                        CityCodeManager.shared.cityName = placemarks?.first?.locality
                        
                        let code =  CityCodeHelper().getCodeByName(placemarks?.first?.locality ?? "")
                        CityCodeManager.shared.cityCode = code
                        NotificationCenter.default.post(name: .cityChanged, object: nil)
                        self.cabinetList()
                        
                    }
                }
            }
            
        }
    }
    var previousRegion: MKCoordinateRegion?
    
    //    func startObserving(){
    //        NotificationCenter.default.addObserver(self, selector: #selector(handleLocationState(_:)), name: Notification.Name("location"), object: nil)
    //
    //    }
    //    deinit{
    //        NotificationCenter.default.removeObserver(self)
    //    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func showFloatingPanel(_ contentVC:UIViewController){
        fpc.delegate = self
        fpc.isRemovalInteractionEnabled = true
        fpc.contentInsetAdjustmentBehavior = .always
        fpc.surfaceView.appearance = {
            let appearance = SurfaceAppearance()
            appearance.cornerRadius = 15.0
            return appearance
        }()
        fpc.set(contentViewController: contentVC)
        fpc.contentMode = .fitToBounds
        guard let controller = UIViewController.ex_presentController() else { fatalError("Any window not found") }
        
        controller.view.addSubview(fpc.view)
        fpc.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fpc.view.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor),
            fpc.view.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor),
            fpc.view.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor),
            fpc.view.topAnchor.constraint(equalTo: controller.view.topAnchor),
            
        ])
        
        fpc.show(animated: true)
    }
    func hideFloatingPanel(_ contentVC:UIViewController){
        fpc.hide(animated: true)
    }
    func cabinetList(){
        if let _ = self.mapView.userLocation.location{
            self.locationManager.stopUpdatingLocation()
            let code = CityCodeManager.shared.cityCode ?? "370200"
            var params = [String: Any]()
            let orderInfo = HFKeyedArchiverTool.batteryDepositOrderInfo()
            if orderInfo.id != nil {
                params = ["tempStorageSw": true]
            }
            params["cityCode"] = code.replacingLastTwoCharactersWithZeroes()
            self.getData(cabinetListUrl, param: params, isLoading: false) { responseObject in
                if let body = (responseObject as? [String: Any])?["body"] as? [String: Any],let pageResult = body["pageResult"] as? [String: Any],
                   let dataList = pageResult["dataList"] as? [[String: Any]]{
                    let cabinetArray = (HFCabinet.mj_objectArray(withKeyValuesArray: dataList) as? [HFCabinet]) ?? []
                    var tempAnnotations =  self.mapView.annotations
                    tempAnnotations.removeAll { annotation in
                        if annotation is CenterAnnotation{
                            return true
                        }else if annotation is MKUserLocation {
                            return true
                        }else{
                            return false
                        }
                    }
                    let finalAnnotations = tempAnnotations
                    self.mapView.removeAnnotations(finalAnnotations)
                    
                    let annotations =  cabinetArray.map({ cabinet in
                        
                        let a = CabinetAnnotation(coordinate: CLLocationCoordinate2D(latitude: cabinet.bdLat?.doubleValue ?? 0, longitude: cabinet.bdLon?.doubleValue ?? 0), title: nil, subtitle: nil)
                        a.cabinet = cabinet
                        return a
                    })
                    self.mapView.addAnnotations(annotations)
                    
                    
                }
                
            } error: { error in
                self.showError(withStatus: error.localizedDescription)
            }
            
            
            
        }
        
    }
}
extension MapViewController:FloatingPanelControllerDelegate{
    func floatingPanel(_ fpc: FloatingPanelController, shouldAllowToScroll scrollView: UIScrollView, in state: FloatingPanelState) -> Bool {
        return state == .half
    }
    func floatingPanelDidChangeState(_ fpc: FloatingPanelController) {
        if fpc.state == .full {
            // 当 FloatingPanel 滑动到全屏时，执行跳转
            let cabinetDetailVC = CabinetDetailViewController()
            cabinetDetailVC.id = (fpc.contentViewController as? CabinetPanelViewController)?.annotation?.cabinet?.id
            cabinetDetailVC.number = (fpc.contentViewController as? CabinetPanelViewController)?.annotation?.cabinet?.number
            // 自定义跳转动画
            let transition = CATransition()
            transition.duration = 0.5  // 动画持续时间
            transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)  // 动画缓动效果
            transition.type = .fade  // 动画类型，moveIn 是一种平滑滑动效果
            transition.subtype = .fromRight  // 动画方向，从右向左滑动
            
            // 将自定义过渡动画添加到导航控制器的视图层
            self.navigationController?.view.layer.add(transition, forKey: kCATransition)
            
            self.navigationController?.pushViewController(cabinetDetailVC, animated: false)
            fpc.move(to: .half, animated: false)
        }
    }
    func floatingPanel(_ fpc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
        return RemovablePanelLayout()
    }
}
// MARK: - Setup
private extension MapViewController {
    
    private func setupNavbar() {
        
    }
    
    private func setupSubviews() {
        self.view.addSubview(mapView)
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.white.withAlphaComponent(0).cgColor]
        gradientLayer.frame  = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 134)
        // 将形状图层设置为视图的 mask 属性
        mapView.layer.addSublayer(gradientLayer)
        
        
        // 设置地图的代理
        
        
        
        
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
}

// MARK: - Public
extension MapViewController{
    // 处理位置更新
    
    // 中心地图到用户位置
    func centerMapOnUserLocation(userLocation: MKUserLocation) {
        if let location = userLocation.location{
            let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                      latitudinalMeters: 1000,
                                                      longitudinalMeters: 1000)
            mapView.setRegion(coordinateRegion, animated: true)
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let _ = locations.last {
            // 在这里可以执行需要用户位置的逻辑
            // 例如，设置地图的中心点为用户位置
            firstLoadData()
            
        }
    }
    // 当权限状态发生改变时调用
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
    }
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        
        
    }
    func mapView(_ mapView: MKMapView, didChange mode: MKUserTrackingMode, animated: Bool) {
        
    }
    func mapView(_ mapView: MKMapView, didFailToLocateUserWithError error: Error) {
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        self.didSelectBlock?(mapView,view)
        
        // 动画效果
        if let annotation = view.annotation as? CabinetAnnotation{
            UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: [], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                    view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                }
                
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                    view.transform = .identity
                }
            }, completion: { _ in
                // 动画完成后的操作
            })
            
            guard let sourceCoordinate = mapView.userLocation.location?.coordinate else {return} // 起点
            let destinationCoordinate = annotation.coordinate
            
            calculateCyclingTime(from: sourceCoordinate, to: destinationCoordinate) { response, error in
                guard let response = response, let route = response.routes.first else {
                    print("Error calculating directions: \(String(describing: error))")
                    return
                }
                
                let walkingTimeInSeconds = route.expectedTravelTime
                let cyclingTimeInSeconds = walkingTimeInSeconds / 4.5 // 假设电动车速度是步行的 4.5 倍
                
                // 时间格式化
                let cyclingTimeFormatted = String.formatTime(seconds: cyclingTimeInSeconds)
                print("Estimated cycling time: \(cyclingTimeFormatted)")
                
                // 距离格式化
                let distanceFormatted = String.formatDistance(meters: route.distance)
                print("Distance: \(distanceFormatted)")
                
                // 移除之前的路径
                let overlays = self.mapView.overlays
                self.mapView.removeOverlays(overlays)
                
                // 添加新路径
                self.mapView.addOverlay(route.polyline)
                let expandedMapRect = route.polyline.boundingMapRect.expanded(byFactor: 1.5) // Expand by 20%
                
                self.mapView.setVisibleMapRect(expandedMapRect, animated: true)
            }
            fpc.delegate = self
            fpc.isRemovalInteractionEnabled = true
            fpc.contentInsetAdjustmentBehavior = .always
            fpc.surfaceView.appearance = {
                let appearance = SurfaceAppearance()
                appearance.cornerRadius = 15.0
                return appearance
            }()
            let contentVC = CabinetPanelViewController()
            contentVC.giftAction = { sender in
                let chooseBatteryTypeViewController =  ChooseBatteryTypeViewController()
                self.navigationController?.pushViewController(chooseBatteryTypeViewController, animated: true)
            }
            contentVC.scanAction = { sender in
                HFScanTool.shared.showScanController(from: self)
                
            }
            contentVC.detailAction = { sender in
                
                let cabinetDetailVC = CabinetDetailViewController()
                cabinetDetailVC.id = annotation.cabinet?.id
                cabinetDetailVC.number = annotation.cabinet?.number
                self.navigationController?.pushViewController(cabinetDetailVC, animated: true)
            }
            contentVC.navigateAction = { sender in
                self.mapNavigation(lat: annotation.coordinate.latitude, lng: annotation.coordinate.longitude, address: annotation.cabinet?.number, currentController: self)
            }
            contentVC.dropDownAction = { sender in
                self.fpc.hide(animated: true)
            }
            contentVC.mapController = self
            contentVC.annotation = annotation
            fpc.set(contentViewController: contentVC)
            guard let controller = UIViewController.ex_presentController() else { fatalError("Any window not found") }
            
            controller.view.addSubview(fpc.view)
            fpc.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                fpc.view.bottomAnchor.constraint(equalTo: controller.view.safeAreaLayoutGuide.bottomAnchor),
                fpc.view.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor),
                fpc.view.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor),
                fpc.view.topAnchor.constraint(equalTo: controller.view.topAnchor),
                
            ])
            
            fpc.show(animated: true)
        }
        
        
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        self.didDeselectBlock?(mapView,view)
        if view.annotation is CabinetAnnotation{
            
            // 当取消选择时将标注恢复原样
            
        }
    }
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = .cyan
            renderer.lineWidth = 4.0
            renderer.lineDashPattern = [0, 10] // 调整箭头的显示间隔
            
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    func calculateCyclingTime(from sourceCoordinate: CLLocationCoordinate2D, to destinationCoordinate: CLLocationCoordinate2D, completion: @escaping (MKDirections.Response?, Error?) -> Void) {
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        let request = MKDirections.Request()
        request.source = sourceMapItem
        request.destination = destinationMapItem
        request.transportType = .walking // 使用 walking 来模拟骑行时间
        
        let directions = MKDirections(request: request)
        directions.calculate(completionHandler: completion)
    }
    
    func mapViewDidStopLocatingUser(_ mapView: MKMapView) {
        
        
    }
    
    func moveMap(){
        self.mapView.userTrackingMode = .none
        let cityName = CityCodeManager.shared.cityName
        if let placemark = CityCodeManager.shared.placemark,placemark.locality == cityName,let _ = placemark.location{
            self.mapView.userTrackingMode = .follow
            return
        }
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(cityName ?? "") { placemarks, error in
            if let _ = error {
            } else if let placemarks = placemarks, let placemark = placemarks.first {
                if let location = placemark.location{
                    self.centerMapOnLocation(location: location)
                }
                
            } else {
                
            }
        }
    }
    func centerMapOnLocation(location: CLLocation, regionRadius: CLLocationDistance = 10000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
}
extension MapViewController {
    // 监听地图区域变化
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        for annotationView in views {
            if annotationView is CenterAnnotationView{
                UIView.animateKeyframes(withDuration: 0.3, delay: 0, options: [], animations: {
                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                        annotationView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                    }
                    
                    UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                        annotationView.transform = .identity
                    }
                }, completion: { _ in
                    // 动画完成后的操作
                    
                })
            }
            
        }
        
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let currentRegion = mapView.region
        
        // 检查新的区域和上一个区域是否相似
        if let previousRegion = previousRegion,
           abs(previousRegion.center.latitude - currentRegion.center.latitude) < 0.0001,
           abs(previousRegion.center.longitude - currentRegion.center.longitude) < 0.0001,
           abs(previousRegion.span.latitudeDelta - currentRegion.span.latitudeDelta) < 0.0001,
           abs(previousRegion.span.longitudeDelta - currentRegion.span.longitudeDelta) < 0.0001 {
            return
        }
        
        previousRegion = currentRegion
        // 更新标记位置为地图中心
        
        let centerAnnotation = CenterAnnotation(coordinate: mapView.centerCoordinate, title: "Center", subtitle: "")
        
        mapView.addAnnotation(centerAnnotation)
        
        
        if let imageView = mapView.subviews.first(where: { v in
            return v is UIImageView
        }){
            imageView.removeFromSuperview()
        }
        //        self.mapView.regionCallBack?(mapView.region)
        // 加载数据
        updateCabinetList(coordinate: mapView.centerCoordinate)
        
        
        
    }
    
    
    
    func distanceBetween(coord1: CLLocationCoordinate2D, coord2: CLLocationCoordinate2D) -> CLLocationDistance {
        let loc1 = CLLocation(latitude: coord1.latitude, longitude: coord1.longitude)
        let loc2 = CLLocation(latitude: coord2.latitude, longitude: coord2.longitude)
        return loc1.distance(from: loc2)
    }
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        let oldCenterAnnotation = mapView.annotations.first(where: { a in
            return a is CenterAnnotation
        })
        if let p = oldCenterAnnotation {
            
            mapView.removeAnnotation(p)
            
        }
        if let imageView = mapView.subviews.first(where: { v in
            return v is UIImageView
        }){
            imageView.removeFromSuperview()
        }
        let imageView = UIImageView(image: UIImage(named: "center_point"))
        mapView.addSubview(imageView)
        imageView.center =  CGPoint(x: mapView.center.x, y: mapView.center.y - imageView.frame.maxY + 2.5)
    }
    // 自定义标记外观
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is CenterAnnotation {
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: String(describing: CenterAnnotationView.self),for: annotation)
            
            // 设置自定义图标
            annotationView.canShowCallout = true
            
            return annotationView
        }else if annotation is CabinetAnnotation{
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: String(describing: CabinetAnnotationView.self),for: annotation)
            annotationView.annotation = annotation
            // 设置自定义图标
            annotationView.canShowCallout = true
            
            return annotationView
        }else if annotation is MKUserLocation{
            return nil
        }else{
            return nil
        }
        
        
    }
}

// MARK: - Request
private extension MapViewController {
    
}

// MARK: - Action
@objc private extension MapViewController {
    @objc func panG(_ sender:UIPanGestureRecognizer){
        if sender.state == .changed{
            // 获取地图当前可见区域的中心坐标
            let centerCoordinate = mapView.centerCoordinate
            
            // 将地理坐标转换为地图视图上的点
            let centerPoint = mapView.convert(centerCoordinate, toPointTo: mapView)
            
            // 更新自定义标记的位置为地图视图上的点，并以动画方式进行
            if let oldCenterAnnotation = mapView.annotations.first(where: { a in
                return a is CenterAnnotation
            }),let customAnnotationView = mapView.view(for: oldCenterAnnotation) {
                CATransaction.begin()
                
                // 设置动画持续时间
                CATransaction.setAnimationDuration(0.3)
                
                // 设置动画类型和曲线
                CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: .easeInEaseOut))
                
                // 设置标记视图的新位置
                customAnnotationView.layer.position = centerPoint
                
                // 提交CATransaction事务
                CATransaction.commit()
            }
        }
    }
}

// MARK: - Private
private extension MapViewController {
    
}
class Debounce {
    private var workItem: DispatchWorkItem?
    private var interval: TimeInterval
    
    init(interval: TimeInterval) {
        self.interval = interval
    }
    
    func call(action: @escaping () -> Void) {
        // Cancel previous task if already scheduled
        workItem?.cancel()
        
        // Create new task
        workItem = DispatchWorkItem { action() }
        
        // Schedule new task with delay
        DispatchQueue.main.asyncAfter(deadline: .now() + interval, execute: workItem!)
    }
}

class RemovablePanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .half
    let anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] = [
        .full: FloatingPanelLayoutAnchor(absoluteInset: 93, edge: .top, referenceGuide: .safeArea),
        .half: FloatingPanelLayoutAnchor(absoluteInset: 364.0, edge: .bottom, referenceGuide: .safeArea)
    ]
    
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        return 0.0
    }
}

