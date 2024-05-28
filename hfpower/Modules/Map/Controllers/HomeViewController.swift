//
//  HomeViewController.swift
//  hfpower
//
//  Created by EDY on 2024/5/27.
//

import UIKit
import MapKit
class HomeViewController: UIViewController, CLLocationManagerDelegate,MKMapViewDelegate {
    
    // MARK: - Accessor
    let manager = CLLocationManager()

    // MARK: - Subviews
    lazy var headerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var locationChooseView:LocationChooseView = {
       let view = LocationChooseView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var searchView:SearchView = {
       let view = SearchView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var needLoginView:NeedLoginView = {
        let view = NeedLoginView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var mapView:MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        map.showsCompass = false
        map.userTrackingMode = .followWithHeading
        map.register(CenterAnnotationView.self, forAnnotationViewWithReuseIdentifier: String(describing: CenterAnnotationView.self))
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        setupNavbar()
        setupSubviews()
        setupLayout()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.white.withAlphaComponent(0).cgColor]
        gradientLayer.frame  = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 134)
        // 将形状图层设置为视图的 mask 属性
        mapView.layer.addSublayer(gradientLayer)
        
       
        // 设置地图的代理
        mapView.delegate = self
        // 添加一个初始标记
        var centerAnnotation = CenterAnnotation(coordinate: mapView.centerCoordinate, title: "Center", subtitle: "")

        mapView.addAnnotation(centerAnnotation)

    }
    
    // 监听地图区域变化
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        // 更新标记位置为地图中心

        var centerAnnotation = CenterAnnotation(coordinate: mapView.centerCoordinate, title: "Center", subtitle: "")
        var oldCenterAnnotation = mapView.annotations.first { a in
            return a is CenterAnnotation
        }
        if let p = oldCenterAnnotation {
            
            mapView.removeAnnotation(p)

        }
        mapView.addAnnotation(centerAnnotation)

        
       
    }
    
    // 自定义标记外观
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is CenterAnnotation else {
            return nil
        }
        
        let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: String(describing: CenterAnnotationView.self))
        
        // 设置自定义图标
        annotationView?.canShowCallout = true
        
        return annotationView
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
}

// MARK: - Setup
private extension HomeViewController {
    
    private func setupNavbar() {
        
    }
   
    private func setupSubviews() {
        // 设置地图的初始位置和显示范围
       
        self.view.addSubview(mapView)
        self.view.addSubview(needLoginView)
        needLoginView.loginAction = { (sender) -> Void in
            let loginVC = LoginViewController()
            
            let nav = UINavigationController(rootViewController: loginVC)
            nav.modalPresentationStyle = .fullScreen
            nav.modalTransitionStyle = .coverVertical
            self.present(nav, animated: true)
        }
        self.view.addSubview(locationChooseView)
        self.view.addSubview(searchView)
        searchView.goToNotificationBlock = { (sender) -> Void in
            let notificationVC = NotificationViewController()
            notificationVC.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(notificationVC, animated: true)
        }
       
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            
            
            
           
           
            locationChooseView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 14),
            locationChooseView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            locationChooseView.heightAnchor.constraint(equalToConstant: 44),

            searchView.leadingAnchor.constraint(equalTo: locationChooseView.trailingAnchor,constant: 12),
            searchView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            searchView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -14),
            searchView.heightAnchor.constraint(equalToConstant: 44),
            searchView.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),

            needLoginView.topAnchor.constraint(equalTo: self.locationChooseView.bottomAnchor,constant: 10),
            needLoginView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 14),
            needLoginView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -14),
            needLoginView.heightAnchor.constraint(equalToConstant:44),


        ])
        
    }
}

// MARK: - Public
extension HomeViewController {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            render(location)
        }
    }
    func render(_ location: CLLocation) {
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}

// MARK: - Request
private extension HomeViewController {
    
}

// MARK: - Action
@objc private extension HomeViewController {
    @objc func needLogin(_ sender:UIButton){
        
    }
}

// MARK: - Private
private extension HomeViewController {
    
}
