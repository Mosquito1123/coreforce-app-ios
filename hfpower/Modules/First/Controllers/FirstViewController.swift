//
//  FirstViewController.swift
//  hfpower
//
//  Created by EDY on 2024/10/14.
//

import UIKit
import FSPagerView
import FloatingPanel
import Kingfisher
class FirstViewController: UIViewController,FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return banners.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: String(describing: FSPagerViewCell.self), at: index)
        let banner = banners[index]
        let accessToken = HFKeyedArchiverTool.account().accessToken
        let icon = banner.photo
        let iconURLString = "\(rootRequest)/app/api/normal/read/photo?access_token=\(accessToken)&photo=\(icon)&requestNo=\(Int.requestNo)&createTime=\(Date().currentTimeString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed) ?? "")"
        cell.imageView?.kf.setImage(with: URL(string: iconURLString),placeholder:UIImage(named: "banner_default"))
        
        return cell
    }
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
    }
    
    
    
    // MARK: - Accessor
    var banners = [HFActivityListModel]()
    let fpc = FloatingPanelController()
    let firstContent = FirstContentViewController()
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
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()

    }
    func loadData(){
        let code = CityCodeManager.shared.cityCode ?? "370200"

        var xparams = [String: Any]()
        xparams["cityCode"] = code.replacingLastTwoCharactersWithZeroes()
        self.getData(activityBannerListUrl, param: xparams, isLoading: false) { responseObject in
            guard let body = (responseObject as? [String:Any])?["body"] as? [String: Any],
                  let inviteList = body["inviteList"] as? [[String: Any]] else {
                return
            }
            let modelList = HFActivityListModel.mj_objectArray(withKeyValuesArray: inviteList) as? [HFActivityListModel] ?? []
            self.banners = modelList
            self.pagerView.reloadData()
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
        }

    }
    
}

// MARK: - Setup
private extension FirstViewController {
    
    private func setupNavbar() {
        
    }
   
    private func setupSubviews() {
        self.view.backgroundColor = UIColor(hex: 0xF7F7F7FF)
        self.view.addSubview(self.pagerView)
        fpc.delegate = self
        fpc.contentInsetAdjustmentBehavior = .always
        fpc.set(contentViewController: self.firstContent)
        fpc.surfaceView.grabberHandle.isHidden = true
        fpc.surfaceView.appearance = {
            let appearance = SurfaceAppearance()
            appearance.cornerRadius = 15.0
            return appearance
        }()
        fpc.track(scrollView: self.firstContent.tableView)
        fpc.addPanel(toParent: self)
    }
   

    private func setupLayout() {
        NSLayoutConstraint.activate([
            pagerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pagerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pagerView.topAnchor.constraint(equalTo: view.topAnchor),
            pagerView.heightAnchor.constraint(equalToConstant: 240),
        ])
    }
}

// MARK: - Public
extension FirstViewController:FloatingPanelControllerDelegate{
    func floatingPanel(_ fpc: FloatingPanelController, shouldAllowToScroll scrollView: UIScrollView, in state: FloatingPanelState) -> Bool {
        return state == .half || state == .full
    }
    
    func floatingPanel(_ fpc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout {
        return FirstContentPanelLayout()
    }
    // FloatingPanelControllerDelegate 方法
       func floatingPanelDidChangeState(_ fpc: FloatingPanelController) {
           switch fpc.state {
           case .full:
               // 在 full 状态下去掉圆角和阴影
               fpc.surfaceView.appearance = {
                   let appearance = SurfaceAppearance()
                   appearance.cornerRadius = 0.0
                   appearance.shadows = []
                   return appearance
               }()
           case .half:
               fpc.surfaceView.appearance = {
                   let appearance = SurfaceAppearance()
                   appearance.cornerRadius = 15.0
                   let shadow = SurfaceAppearance.Shadow()
                   appearance.shadows = [shadow]
                   return appearance
               }()
               // 在 half 状态下恢复圆角和阴影
           default:
               break
           }
       }
   
}

// MARK: - Request
private extension FirstViewController {
    
}

// MARK: - Action
@objc private extension FirstViewController {
    
}

// MARK: - Private
private extension FirstViewController {
    
}
class FirstContentPanelLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .half
    let anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] = [
        .full: FloatingPanelLayoutAnchor(absoluteInset: 10, edge: .top, referenceGuide: .safeArea),
        .half: FloatingPanelLayoutAnchor(absoluteInset: 224, edge: .top, referenceGuide: .superview)
    ]
    
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        return 0.0
    }
}
