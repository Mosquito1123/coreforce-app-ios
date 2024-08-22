//
//  BatteryDetailViewController.swift
//  hfpower
//
//  Created by EDY on 2024/8/15.
//

import UIKit
import IGListKit
class BatteryDetailViewController: BaseViewController,ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return data
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is BatteryStatus:
            return BatteryStatusSectionController()
        case is BatteryInfo:
            return BatteryInfoSectionController()
        case is BatteryRemainingTerm:
            return BatteryRemainingTermSectionController()
        case is BatteryAgent:
            return BatteryAgentSectionController()
        case is BatteryAction:
            return BatteryActionSectionController()
        case is BatterySite:
            return BatterySiteSectionController()
        default:
            return ContactInfoSectionController()
            
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        let backgroundView = UIView(frame: self.view.bounds)
        backgroundView.backgroundColor = UIColor(rgba: 0xF7F7F7FF)
        // 设置背景图
        let backgroundImageView = UIImageView(image: UIImage(named: "device_background"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 383)
        backgroundView.addSubview(backgroundImageView)
        return backgroundView
    }
    
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var data: [ListDiffable] = []{
        didSet{
            adapter.reloadData()
        }
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavbar()
        setupSubviews()
        setupLayout()
        self.navigationController?.isNavigationBarHidden = true
        setupData()

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.frame = view.bounds
        let backgroundView = UIView(frame: self.view.bounds)
        backgroundView.backgroundColor = UIColor(rgba: 0xF7F7F7FF)
        // 设置背景图
        let backgroundImageView = UIImageView(image: UIImage(named: "device_background"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 383)
        backgroundView.addSubview(backgroundImageView)
        collectionView.backgroundView = backgroundView
    }
    func setupData(){
        self.data = [
            BatteryStatus(id:0, value: "", status: 0, address: "李沧区青山路700号"),
            BatteryInfo(id: 1, items: [
                BatteryInfoItem(),
                BatteryInfoItem(),

            ]),
            BatteryRemainingTerm(id: 2, remainingTerm: ""),
            BatteryAgent(id: 3, agentName: ""),
            BatteryAction(id: 4, items: [
                BatteryActionItem(),
                BatteryActionItem(),
                BatteryActionItem(),
                BatteryActionItem()
            ]),
            BatterySite(id: 5, sites: [
                BatterySiteItem(),
                BatterySiteItem(),
                BatterySiteItem(),
                BatterySiteItem()
            ]),
            ContactInfo(id: 6, name: "", phoneNumber: "400-6789-509")
            
        ]
    }
}

// MARK: - Setup
private extension BatteryDetailViewController {
    
    private func setupNavbar() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back_arrow")?.resized(toSize: CGSize(width: 20, height: 20)), for: .normal)
        backButton.setImage(UIImage(named: "back_arrow")?.resized(toSize: CGSize(width: 20, height: 20)), for: .highlighted)
        backButton.setBackgroundImage(UIColor.white.circularImage(diameter: 28), for: .normal)  // 设置自定义图片
        backButton.setBackgroundImage(UIColor.white.circularImage(diameter: 28), for: .highlighted)  // 设置自定义图片
        backButton.setTitle("", for: .normal)  // 设置标题
        backButton.setTitleColor(.black, for: .normal)  // 设置标题颜色
        backButton.addAction(for: .touchUpInside) {
            self.navigationController?.popViewController(animated: true)
        }
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        view.bringSubviewToFront(backButton)
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 18),
            backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 6),
            backButton.widthAnchor.constraint(equalToConstant: 28),
            backButton.heightAnchor.constraint(equalToConstant: 28),
            
        ])
    }
    
    private func setupSubviews() {
        self.view.backgroundColor = UIColor(rgba: 0xF7F7F7FF)
        
        
        view.addSubview(collectionView)
        view.sendSubviewToBack(collectionView)
        
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    private func setupLayout() {
        
    }
}

// MARK: - Public
extension BatteryDetailViewController {
    
}

// MARK: - Request
private extension BatteryDetailViewController {
    
}

// MARK: - Action
@objc private extension BatteryDetailViewController {
    
}

// MARK: - Private
private extension BatteryDetailViewController {
    
}


class BatteryStatusSectionController: ListSectionController {
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
    }
    private var batteryStatus: BatteryStatus!
    
    override func numberOfItems() -> Int {
        return 1
    }
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 300)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: BatteryStatusViewCell.self, for: self, at: index) else {return UICollectionViewCell()}
        // 配置图片和状态
        return cell
    }
    override func didUpdate(to object: Any) {
        batteryStatus = object as? BatteryStatus
    }
}
class BatteryInfoSectionController: ListSectionController {
    private var batteryInfo: BatteryInfo!

    override func numberOfItems() -> Int {
        return 2
    }
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 54)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: BatteryInfoViewCell.self, for: self, at: index) else {return UICollectionViewCell()}
        // 配置图片和状态
        return cell
    }
    override func didUpdate(to object: Any) {
        batteryInfo = object as? BatteryInfo
    }
}
class BatteryRemainingTermSectionController: ListSectionController {
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 54)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: BatteryRemainingTermViewCell.self, for: self, at: index) else {return UICollectionViewCell()}
        // 配置图片和状态
        return cell
    }
}
class BatteryAgentSectionController: ListSectionController {
    override func numberOfItems() -> Int {
        return 1
    }
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 54)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: BatteryAgentViewCell.self, for: self, at: index) else {return UICollectionViewCell()}
        // 配置图片和状态
        return cell
    }
}
class BatteryActionSectionController: ListSectionController {
    override func numberOfItems() -> Int {
        return 4
    }
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        minimumLineSpacing = 12
        minimumInteritemSpacing = 15
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: ((collectionContext?.containerSize.width ?? 0) - 24 - 15)/2, height: 64)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: BatteryActionViewCell.self, for: self, at: index) else {
            return UICollectionViewCell()}
        // 配置图片和状态
        return cell
    }
    override func didSelectItem(at index: Int) {
        
    }
}
class BatterySiteSectionController: ListSectionController {
    override func numberOfItems() -> Int {
        return 1
    }
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 54)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: BatterySiteViewCell.self, for: self, at: index) else {return UICollectionViewCell()}
        // 配置图片和状态
        return cell
    }
}
