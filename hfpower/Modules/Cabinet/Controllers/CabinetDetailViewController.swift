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

class CabinetDetailViewController: UIViewController,UIGestureRecognizerDelegate, FSPagerViewDataSource, FSPagerViewDelegate {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageUrls.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: String(describing: FSPagerViewCell.self), at: index)
        let url = imageUrls[index]
        cell.imageView?.kf.setImage(with: url,placeholder: UIImage(named: "icon_default_cabinet"))
        
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
    var cabinetAnnotation:CabinetAnnotation?{
        didSet{
            self.cabinetDetailContentController.cabinetDetailContentView.titleLabel.text = cabinetAnnotation?.cabinet?.number
            self.cabinetDetailContentController.cabinetDetailContentView.cabinetNumberView.numberLabel.text = cabinetAnnotation?.cabinet?.number
            self.cabinetDetailContentController.cabinetDetailContentView.locationLabel.text = cabinetAnnotation?.cabinet?.location
            guard let sourceCoordinate = mapController.mapView.userLocation.location?.coordinate else {return} // 起点
            guard let destinationCoordinate = cabinetAnnotation?.coordinate else {return}
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
            if let _ = cabinetAnnotation?.cabinet?.photo1, let accessToken = TokenManager.shared.accessToken,let id = cabinetAnnotation?.cabinet?.id {
                let urlString = "\(base)/app/api/cabinet/photo?access_token=\(accessToken)&id=\(id)&photo=\(1)&requestNo=\(Int.requestNo)&createTime=\(Date().currentTimeString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed) ?? "")"
                list.append(urlString)
            }
            if let _ = cabinetAnnotation?.cabinet?.photo2,let accessToken = TokenManager.shared.accessToken,let id = cabinetAnnotation?.cabinet?.id{
                let urlString = "\(base)/app/api/cabinet/photo?access_token=\(accessToken)&id=\(id)&photo=\(2)&requestNo=\(Int.requestNo)&createTime=\(Date().currentTimeString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed) ?? "")"
                list.append(urlString)

            }
            if let _ = cabinetAnnotation?.cabinet?.photo3,let accessToken = TokenManager.shared.accessToken,let id = cabinetAnnotation?.cabinet?.id{
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
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.view.backgroundColor = .white
        setupNavbar()
        setupSubviews()
        setupLayout()
        loadCabinetDetail(id: cabinetAnnotation?.cabinet?.id?.description, number: cabinetAnnotation?.cabinet?.number)
    }
    func loadCabinetDetail(id:String?,number:String?){
        if let idx = id,let numberx = number{
            NetworkService<BusinessAPI,CabinetDetailResponse>().request(.cabinet(id: idx, number: numberx)) { result in
                switch result {
                case .success(let response):
                    self.cabinetExchangeForecastDatas = response?.cabinetExchangeForecast
                case .failure(let error):
                    debugPrint(error)

                }
            }
        }
        
    }
}

// MARK: - Setup
private extension CabinetDetailViewController {
    
    private func setupNavbar() {
        
    }
    
    private func setupSubviews() {
        self.view.addSubview(pagerView)

        fpc.delegate = self
        self.cabinetDetailContentController.cabinetDetailContentView.navigateAction = { action in
            guard let annotation = self.cabinetAnnotation else {
                self.showError(withStatus: "该电柜坐标数据有误")
                return}
            self.mapNavigation(lat: annotation.coordinate.latitude, lng: annotation.coordinate.longitude, address: annotation.cabinet?.number, currentController: self)
        }
        fpc.set(contentViewController: self.cabinetDetailContentController)
        fpc.contentInsetAdjustmentBehavior = .always
        fpc.surfaceView.appearance = {
            let appearance = SurfaceAppearance()
            appearance.cornerRadius = 15.0
            return appearance
        }()
        fpc.addPanel(toParent: self)
        self.view.addSubview(self.bottomView)
        self.view.addSubview(self.cancelButton)
        self.view.bringSubviewToFront(self.cancelButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 6),
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 34),
            cancelButton.widthAnchor.constraint(equalToConstant: 24),
            cancelButton.heightAnchor.constraint(equalToConstant: 24),
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