//
//  HomeViewController.swift
//  hfpower
//
//  Created by EDY on 2024/5/27.
//

import UIKit
import MapKit
class HomeViewController: UIViewController {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
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
    lazy var needLoginButton:UIButton = {
        let button = UIButton(type: .custom)
        button .setTitle("立即登录", for: .normal)
        button.setTitleColor(UIColor(named: "3171EF") ?? UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(needLogin(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    lazy var mapView:MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        map.userTrackingMode = .followWithHeading
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
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    
}

// MARK: - Setup
private extension HomeViewController {
    
    private func setupNavbar() {
        
    }
   
    private func setupSubviews() {
        // 设置地图的初始位置和显示范围
       
        self.view.addSubview(mapView)
        self.view.addSubview(needLoginButton)
        self.view.addSubview(locationChooseView)
        self.view.addSubview(searchView)
        let initialLocation = CLLocation(latitude: 36.094406, longitude: 120.369557) // 旧金山的经纬度
        let regionRadius: CLLocationDistance = 1000 // 设置显示范围的半径（米）
        let coordinateRegion = MKCoordinateRegion(center: initialLocation.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        
        // 添加一个标注
        let annotation = MKPointAnnotation()
        annotation.coordinate = initialLocation.coordinate
        annotation.title = "青岛市"
        annotation.subtitle = "山东省"
        mapView.addAnnotation(annotation)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            needLoginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            needLoginButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            
           
           
            locationChooseView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 14),
            locationChooseView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            locationChooseView.heightAnchor.constraint(equalToConstant: 44),

            searchView.leadingAnchor.constraint(equalTo: locationChooseView.trailingAnchor,constant: 12),
            searchView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            searchView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -14),
            searchView.heightAnchor.constraint(equalToConstant: 44),

            
        ])
        
    }
}

// MARK: - Public
extension HomeViewController {
    
}

// MARK: - Request
private extension HomeViewController {
    
}

// MARK: - Action
@objc private extension HomeViewController {
    @objc func needLogin(_ sender:UIButton){
        let loginVC = LoginViewController()
        
        let nav = UINavigationController(rootViewController: loginVC)
        nav.modalPresentationStyle = .fullScreen
        nav.modalTransitionStyle = .coverVertical
        self.present(nav, animated: true)
    }
}

// MARK: - Private
private extension HomeViewController {
    
}
