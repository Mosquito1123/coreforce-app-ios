//
//  CabinetDetailViewController.swift
//  hfpower
//
//  Created by EDY on 2024/6/20.
//

import UIKit
import FSPagerView
import FloatingPanel
import Kingfisher
import CoreLocation
class CabinetDetailViewController: UIViewController,UIGestureRecognizerDelegate, FSPagerViewDataSource, FSPagerViewDelegate {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageUrls.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: String(describing: FSPagerViewCell.self), at: index)
        let url = imageUrls[index]
        cell.imageView?.kf.setImage(with: url,placeholder: UIImage(named: "no_data"))
        
        return cell
    }
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
    }
    
    var imageUrls = [URL]()
    // MARK: - Accessor
    let base = "https://www.coreforce.cn"
    let fpc = FloatingPanelController()
    var cabinetExchangeForecastDatas:[CabinetExchangeForecast]?{
        didSet{
            self.cabinetDetailContentController.cabinetExchangeForecastDatas = cabinetExchangeForecastDatas
        }
    }
    var cabinet:CabinetSummary?{
        didSet{
            self.cabinetDetailContentController.cabinetDetailContentView.titleLabel.text = cabinet?.number
            self.cabinetDetailContentController.cabinetDetailContentView.cabinetNumberView.numberLabel.text = cabinet?.number
            self.cabinetDetailContentController.cabinetDetailContentView.locationLabel.text = cabinet?.location
            guard let sourceCoordinate = mapController.mapView.userLocation.location?.coordinate else {return} // 起点
            let destinationCoordinate = CLLocationCoordinate2D(latitude: cabinet?.bdLat?.doubleValue ?? 0, longitude: cabinet?.bdLon?.doubleValue ?? 0)
            self.mapController.calculateCyclingTime(from: sourceCoordinate, to: destinationCoordinate, completion: { response, error in
                guard let response = response, let route = response.routes.first else {
                    print("Error calculating directions: \(String(describing: error))")
                    return
                }
                
                let walkingTimeInSeconds = route.expectedTravelTime
                let cyclingTimeInSeconds = walkingTimeInSeconds / 4.5 // 假设电动车速度是步行的 4.5 倍
                
                // 时间格式化// 距离格式化
                let cyclingTimeFormatted = String.formatTime(seconds: cyclingTimeInSeconds)
                let distanceFormatted = String.formatDistance(meters: route.distance)
                self.cabinetDetailContentController.cabinetDetailContentView.rideLabel.text = "\(distanceFormatted) · 骑行\(cyclingTimeFormatted)"

                
            })
            var list = [String]()
            if let _ = cabinet?.photo1, let accessToken = TokenManager.shared.accessToken,let id = cabinet?.id {
                let urlString = "\(base)/app/api/cabinet/photo?access_token=\(accessToken)&id=\(id)&photo=\(1)&requestNo=\(Int.requestNo)&createTime=\(Date().currentTimeString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed) ?? "")"
                list.append(urlString)
            }
            if let _ = cabinet?.photo2,let accessToken = TokenManager.shared.accessToken,let id = cabinet?.id{
                let urlString = "\(base)/app/api/cabinet/photo?access_token=\(accessToken)&id=\(id)&photo=\(2)&requestNo=\(Int.requestNo)&createTime=\(Date().currentTimeString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed) ?? "")"
                list.append(urlString)

            }
            if let _ = cabinet?.photo3,let accessToken = TokenManager.shared.accessToken,let id = cabinet?.id{
                let urlString = "\(base)/app/api/cabinet/photo?access_token=\(accessToken)&id=\(id)&photo=\(3)&requestNo=\(Int.requestNo)&createTime=\(Date().currentTimeString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed) ?? "")"
                list.append(urlString)
            }
            imageUrls = list.map({ urlString in
                return URL(string: urlString) ?? URL(fileURLWithPath: "")
            })
            pagerView.reloadData()
        
        }
    }
    let cabinetDetailContentController = CabinetDetailContentViewController()
    let mapController = MapViewController()
    // MARK: - Subviews
    lazy var pagerView: FSPagerView = {
        let pagerView = FSPagerView(frame: .zero)
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.isInfinite = true
        pagerView.automaticSlidingInterval = 3.0
        pagerView.translatesAutoresizingMaskIntoConstraints = false
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: String(describing: FSPagerViewCell.self))
        return pagerView
    }()
    lazy var bottomView: CabinetDetailBottomView = {
        let view = CabinetDetailBottomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var cancelButton: UIButton = {
        let button = UIButton(type:.custom)
        button.setImage(UIImage(named: "cabinet_detail_back"), for: .normal)
        button.setImage(UIImage(named: "cabinet_detail_back"), for: .normal)
        button.tintAdjustmentMode = .automatic
        button.addTarget(self, action: #selector(cancelButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupNavbar()
        setupSubviews()
        setupLayout()
        loadCabinetDetail(id: cabinet?.id?.description, number: cabinet?.number)
    }
    func loadCabinetDetail(id:String?,number:String?){
        /*NetworkService<BusinessAPI,CabinetDetailResponse>().request(.cabinet(id: id, number: number)) { result in
            switch result {
            case .success(let response):
                self.cabinetExchangeForecastDatas = response?.cabinetExchangeForecast
            case .failure(let error):
                debugPrint(error)
            }
        }             */

        
        
    }
}

// MARK: - Setup
private extension CabinetDetailViewController {
    
    private func setupNavbar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self

        let backBarButtonItem = UIBarButtonItem(customView: cancelButton)
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        // 创建一个新的 UINavigationBarAppearance 实例
        let appearance = UINavigationBarAppearance()
        
        appearance.configureWithTransparentBackground()
        appearance.backgroundImage = UIImage()
        appearance.shadowImage = UIImage()
        // 设置背景色为白色
        // 设置标题文本属性为白色
        appearance.titleTextAttributes = [.foregroundColor: UIColor.clear,.font:UIFont.systemFont(ofSize: 18, weight: .semibold)]
        
        // 设置大标题文本属性为白色
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.compactAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
    }
    
    private func setupSubviews() {
        self.view.addSubview(pagerView)

        fpc.delegate = self
        self.cabinetDetailContentController.cabinetDetailContentView.navigateAction = { action in
            guard let lat = self.cabinet?.bdLat?.doubleValue,let lng = self.cabinet?.bdLon?.doubleValue,let number = self.cabinet?.number else {
                self.showError(withStatus: "该电柜坐标数据有误")
                return}
            self.mapNavigation(lat: lat, lng: lng, address: number, currentController: self)
        }
        fpc.set(contentViewController: self.cabinetDetailContentController)
        fpc.contentInsetAdjustmentBehavior = .always
        fpc.surfaceView.appearance = {
            let appearance = SurfaceAppearance()
            appearance.cornerRadius = 15.0
            return appearance
        }()
        fpc.addPanel(toParent: self)
        self.bottomView.scanAction = { bt in
            let scanVC = HFScanViewController()
            scanVC.resultBlock = { result in
            }
            self.navigationController?.pushViewController(scanVC, animated: true)
        }
        self.view.addSubview(self.bottomView)
        self.view.bringSubviewToFront(self.cancelButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            pagerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pagerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pagerView.topAnchor.constraint(equalTo: view.topAnchor),
            pagerView.bottomAnchor.constraint(equalTo: self.bottomView.topAnchor),
            self.bottomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.bottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.bottomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.bottomView.heightAnchor.constraint(equalToConstant: 73+34),
            
        ])
    }
}

// MARK: - Public
extension CabinetDetailViewController:FloatingPanelControllerDelegate{
    func floatingPanel(_ fpc: FloatingPanelController, shouldAllowToScroll scrollView: UIScrollView, in state: FloatingPanelState) -> Bool {
        return state == .half || state == .full
    }
    func floatingPanel(_ fpc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
        return CabinetDetailPanelLayout()
    }
}

// MARK: - Request
private extension CabinetDetailViewController {
    
}

// MARK: - Action
@objc private extension CabinetDetailViewController {
    @objc func cancelButtonTapped(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Private
private extension CabinetDetailViewController {
    
}
class CabinetDetailPanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .half
    let anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] = [
        
        .half: FloatingPanelLayoutAnchor(absoluteInset: 200, edge: .top, referenceGuide: .superview)
    ]
    
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        return 0.0
    }
}
