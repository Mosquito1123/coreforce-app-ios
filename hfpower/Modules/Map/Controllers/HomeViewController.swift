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
        let initialLocation = CLLocation(latitude: 37.7749, longitude: -122.4194) // 旧金山的经纬度
        let regionRadius: CLLocationDistance = 1000 // 设置显示范围的半径（米）
        let coordinateRegion = MKCoordinateRegion(center: initialLocation.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        
        // 添加一个标注
        let annotation = MKPointAnnotation()
        annotation.coordinate = initialLocation.coordinate
        annotation.title = "San Francisco"
        annotation.subtitle = "California"
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
