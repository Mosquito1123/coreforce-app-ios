//
//  BikeDetailViewController.swift
//  hfpower
//
//  Created by EDY on 2024/8/15.
//

import UIKit
import IGListKit

class BikeDetailViewController: BaseViewController,ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return data
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        switch object {
        case is BikeStatus:
            return BikeStatusSectionController()
        case is BikeInfo:
            return BikeInfoSectionController()
        case is BikeRemainingTerm:
            return BikeRemainingTermSectionController()
        case is BikeAgent:
            return BikeAgentSectionController()
        case is BikeAction:
            return BikeActionSectionController()
        case is BikeSite:
            return BikeSiteSectionController()
        default:
            return ContactInfoSectionController()
            
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        let backgroundView = UIView(frame: self.view.bounds)
        
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
            BikeStatus(id:0, value: "", status: 0, address: "李沧区青山路700号"),
            BikeInfo(id: 1, items:[
                BikeInfoItem(id: 0,title: "电车编号",content: "TQ1234456"),
                BikeInfoItem(id: 1,title: "车架编号",content: "QYN34445232"),
            ]),
            BikeRemainingTerm(id: 2, title: "剩余租期",content: "28天17小时"),
            BikeAgent(id: 3, title: "代理商名称",content: "青岛片区"),
            BikeAction(id: 4, items: [
                BikeActionItem(id: 0, name: "退租", icon: "device_rent_out"),
                BikeActionItem(id: 1, name: "续费", icon: "device_renewal"),
            ]),
            BikeSite(id: 5, sites: [
                BikeSiteItem(),
                BikeSiteItem(),
                BikeSiteItem(),
                BikeSiteItem()
            ]),
            ContactInfo(id: 6, name: "", phoneNumber: "400-6789-509")
            
        ]
    }
}

// MARK: - Setup
private extension BikeDetailViewController {
    
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
extension BikeDetailViewController {
    
}

// MARK: - Request
private extension BikeDetailViewController {
    
}

// MARK: - Action
@objc private extension BikeDetailViewController {
    
}

// MARK: - Private
private extension BikeDetailViewController {
    
}


class BikeStatusSectionController: ListSectionController {
    private var bikeStatus: BikeStatus!

    override init() {
        super.init()
        inset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
    }
    override func numberOfItems() -> Int {
        return 1
    }
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 300)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: BikeStatusViewCell.self, for: self, at: index) else {return UICollectionViewCell()}
        // 配置图片和状态
        return cell
    }
    override func didUpdate(to object: Any) {
        bikeStatus = object as? BikeStatus
    }
}
class BikeInfoSectionController: ListSectionController {
    private var bikeInfo: BikeInfo!

    override func numberOfItems() -> Int {
        return bikeInfo.items.count
    }
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 54)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: BikeInfoViewCell.self, for: self, at: index) as? BikeInfoViewCell else {return BikeInfoViewCell()}
        // 配置图片和状态
        // 判断第一个和最后一个cell并设置圆角
        if index == 0 {
            cell.cornerType = .first
        } else if index == bikeInfo.items.count - 1 {
            cell.cornerType = .last
        }
        cell.element = bikeInfo.items[index]
        return cell
    }

    override func didUpdate(to object: Any) {
        bikeInfo = object as? BikeInfo
    }
}
class BikeRemainingTermSectionController: ListSectionController {
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)

    }
    private var bikeRemainingTerm: BikeRemainingTerm!

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 54)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: BikeRemainingTermViewCell.self, for: self, at: index) as? BikeRemainingTermViewCell else {return UICollectionViewCell()}
        // 配置图片和状态
        cell.element = bikeRemainingTerm
        return cell
    }
    override func didUpdate(to object: Any) {
        bikeRemainingTerm = object as? BikeRemainingTerm
    }
}
class BikeAgentSectionController: ListSectionController {
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 12, left: 0, bottom: 8, right: 0)

    }
    private var bikeAgent: BikeAgent!

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 54)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: BikeAgentViewCell.self, for: self, at: index) as? BikeAgentViewCell else {return BikeAgentViewCell()}
        cell.element = bikeAgent
        // 配置图片和状态
        return cell
    }
    override func didUpdate(to object: Any) {
        bikeAgent = object as? BikeAgent
    }
}
class BikeActionSectionController: ListSectionController {
    private var bikeAction: BikeAction!

    override init() {
        super.init()
        inset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        minimumLineSpacing = 12
        minimumInteritemSpacing = 15
    }
    override func numberOfItems() -> Int {
        return bikeAction.items.count
    }
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: ((collectionContext?.containerSize.width ?? 0) - 24 - 15)/2, height: 64)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: BikeActionViewCell.self, for: self, at: index) as? BikeActionViewCell else {return UICollectionViewCell()}
        // 配置图片和状态
        cell.element = bikeAction.items[index]
        return cell
    }
    override func didSelectItem(at index: Int) {
        
    }
    override func didUpdate(to object: Any) {
        bikeAction = object as? BikeAction
    }
}
class BikeSiteSectionController: ListSectionController {
    private var bikeSite: BikeSite!

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 54)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: BikeSiteViewCell.self, for: self, at: index) else {return UICollectionViewCell()}
        // 配置图片和状态
        return cell
    }
    override func didUpdate(to object: Any) {
        bikeSite = object as? BikeSite
    }
}
class ContactInfoSectionController: ListSectionController {
    private var contactInfo: ContactInfo!

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 92)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: ContactInfoViewCell.self, for: self, at: index) else {return UICollectionViewCell()}
        // 配置图片和状态
        return cell
    }
    override func didUpdate(to object: Any) {
        contactInfo = object as? ContactInfo
    }
}
