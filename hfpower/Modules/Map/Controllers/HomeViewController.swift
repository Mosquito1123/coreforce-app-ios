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
    lazy var mapView:HFMapView = {
        let map = HFMapView()
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
        let centerAnnotation = CenterAnnotation(coordinate: mapView.centerCoordinate, title: "Center", subtitle: "")

        mapView.addAnnotation(centerAnnotation)

    }
    
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
private extension HomeViewController {
    
}
