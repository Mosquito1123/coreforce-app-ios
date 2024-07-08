//
//  MapViewController.swift
//  hfpower
//
//  Created by EDY on 2024/5/30.
//

import UIKit
import MapKit
import FloatingPanel
class MapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    
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
    lazy var mapView:HFMapView = {
        let map = HFMapView()
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
        
        locationManager.startUpdatingLocation()

        setupNavbar()
        setupSubviews()
        setupLayout()
        
    }
    func firstLoadData(){
        let userlocation = mapView.userLocation
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
                        
                        self.loadCabinetListData()
                        
                    }
                }
            }
            
        }
    }
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
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
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
    func loadCabinetListData(){
        if let _ = self.mapView.userLocation.location{
            self.locationManager.stopUpdatingLocation()
            NetworkService<BusinessAPI,CabinetListResponse>().request(.cabinetList(tempStorageSw: nil, cityCode: CityCodeManager.shared.cityCode, lon: mapView.centerCoordinate.longitude, lat:mapView.centerCoordinate.latitude)) { result in
                switch result{
                case .success(let response):
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
                    
                    if let annotations =  response?.list?.map({ cabinet in
                        let a = CabinetAnnotation(coordinate: CLLocationCoordinate2D(latitude: cabinet.bdLat?.doubleValue ?? 0, longitude: cabinet.bdLon?.doubleValue ?? 0), title: nil, subtitle: nil)
                        a.cabinet = cabinet
                        return a
                    }){
                        self.mapView.addAnnotations(annotations)
                        
                    }
                case .failure(let error):
                    self.showError(withStatus: error.localizedDescription)
                    
                }
            }
        }
        
    }
}
extension MapViewController:FloatingPanelControllerDelegate{
    func floatingPanel(_ fpc: FloatingPanelController, shouldAllowToScroll scrollView: UIScrollView, in state: FloatingPanelState) -> Bool {
        return state == .half
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
        if let location = locations.last {
            print("用户位置已更新: \(location.coordinate)")
            // 在这里可以执行需要用户位置的逻辑
            // 例如，设置地图的中心点为用户位置
            firstLoadData()
            
        }
    }
    // 处理授权状态变化
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            mapView.userTrackingMode = .follow
            locationManager.startUpdatingLocation()
            
        }else if status == .authorizedAlways {
            mapView.userTrackingMode = .follow
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
            contentVC.scanAction = { sender in
                let scanVC = HFScanViewController()
                let nav = UINavigationController(rootViewController: scanVC)
                nav.modalPresentationStyle = .fullScreen
                nav.modalTransitionStyle = .coverVertical
                self.present(nav, animated: true)
            }
            contentVC.detailAction = { sender in
         
                let cabinetDetailVC = CabinetDetailViewController()
                cabinetDetailVC.cabinetAnnotation = annotation
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
        // 更新标记位置为地图中心
        
        let centerAnnotation = CenterAnnotation(coordinate: mapView.centerCoordinate, title: "Center", subtitle: "")
        
        mapView.addAnnotation(centerAnnotation)
        
        
        if let imageView = mapView.subviews.first(where: { v in
            return v is UIImageView
        }){
            imageView.removeFromSuperview()
        }
        self.mapView.regionCallBack?(mapView.region)
        // 加载数据
        
        
        
        
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
    @objc func handleLocationState(_ notification:Notification){
        self.loadCabinetListData()
    }
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
        
        .half: FloatingPanelLayoutAnchor(absoluteInset: 364.0, edge: .bottom, referenceGuide: .safeArea)
    ]
    
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        return 0.0
    }
}

