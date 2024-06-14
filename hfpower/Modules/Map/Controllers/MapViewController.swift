//
//  MapViewController.swift
//  hfpower
//
//  Created by EDY on 2024/5/30.
//

import UIKit
import MapKit
class MapViewController: UIViewController,MKMapViewDelegate {
    
    // MARK: - Accessor
    let manager = CLLocationManager()
    private var debounce:Debounce?
    // MARK: - Subviews
    lazy var mapView:HFMapView = {
        let map = HFMapView()
        map.overrideUserInterfaceStyle = .light
        map.showsUserLocation = true
        map.showsCompass = false
        map.userTrackingMode = .followWithHeading
        map.register(CenterAnnotationView.self, forAnnotationViewWithReuseIdentifier: String(describing: CenterAnnotationView.self))
        map.register(CabinetAnnotationView.self, forAnnotationViewWithReuseIdentifier: String(describing: CabinetAnnotationView.self))
        
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize debounce with a 0.5 second interval
        debounce = Debounce(interval: 0.6)
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
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
        mapView.delegate = self
        // 添加一个初始标记
        let centerAnnotation = CenterAnnotation(coordinate: mapView.centerCoordinate, title: "Center", subtitle: "")
        
        mapView.addAnnotation(centerAnnotation)
        mapView.regionCallBack = { region in
            self.debounce?.call {
                self.loadCabinetListData(region.center)
            }
        }
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
extension MapViewController:CLLocationManagerDelegate{
    func loadCabinetListData(_ center:CLLocationCoordinate2D){
        if let _ = self.mapView.userLocation.location{
            NetworkService<BusinessAPI,CabinetListResponse>().request(.cabinetList(tempStorageSw: nil, cityCode: CityCodeManager.shared.cityCode, lon: center.longitude, lat:center.latitude)) { result in
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
                    debugPrint(error)
                    
                }
            }
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            render(location)
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                if let _ = error{
                    
                }else{
                    CityCodeManager.shared.placemark = placemarks?.first
                    CityCodeManager.shared.cityName = placemarks?.first?.locality
                    
                    let code =  CityCodeHelper().getCodeByName(placemarks?.first?.locality ?? "")
                    CityCodeManager.shared.cityCode = code
                }
            }
        }
    }
    func moveMap(){
        let cityName = CityCodeManager.shared.cityName
        if let placemark = CityCodeManager.shared.placemark,placemark.locality == cityName,let location = placemark.location{
            self.render(location)
            return
        }
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(cityName ?? "") { placemarks, error in
            if let _ = error {
            } else if let placemarks = placemarks, let placemark = placemarks.first {
                if let location = placemark.location{
                    self.render(location)
                }
                
            } else {
                
            }
        }
    }
    func centerMapOnLocation(location: CLLocation, regionRadius: CLLocationDistance = 10000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    func render(_ location: CLLocation) {
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        DispatchQueue.main.async {
            self.mapView.setRegion(region, animated: true)
        }
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
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: String(describing: CenterAnnotationView.self))
            
            // 设置自定义图标
            annotationView?.canShowCallout = true
            
            return annotationView
        }else if annotation is CabinetAnnotation{
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: String(describing: CabinetAnnotationView.self))
            annotationView?.annotation = annotation
            // 设置自定义图标
            annotationView?.canShowCallout = true
            
            return annotationView
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
