//
//  MapViewController.swift
//  hfpower
//
//  Created by EDY on 2024/5/30.
//

import UIKit
import MapKit
class MapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    
    // MARK: - Accessor
    let locationManager = CLLocationManager()

    
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
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
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
        // 动画效果
        UIView.animate(withDuration: 0.3,
                       animations: {
            view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }, completion: { _ in
            
        })
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        // 当取消选择时将标注恢复原样
        UIView.animate(withDuration: 0.2) {
            view.transform = CGAffineTransform.identity
        }
    }
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        
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
        imageView.center =  CGPoint(x: mapView.center.x, y: mapView.center.y - imageView.frame.midY + 2.5)
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
