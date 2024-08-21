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
        return nil
    }
    
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    lazy var collectionView: ListCollectionView = {
        let layout = ListCollectionViewLayout(stickyHeaders: true, topContentInset: 0, stretchToEdge: true)
        return ListCollectionView(frame: .zero, listCollectionViewLayout: layout)
    }()
    var data: [ListDiffable] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSubviews()
        setupLayout()
        self.navigationController?.isNavigationBarHidden = true
        
    }
    func setupData(){
        self.data = [
            BikeStatus(id:0, value: "", status: 0, address: "李沧区青山路700号"),
            BikeInfo(id: 1, num:"", vin: ""),
            BikeRemainingTerm(id: 2, remainingTerm: ""),
            BikeAgent(id: 3, agentName: ""),
            BikeAction(id: 4, items: [
                BikeActionItem(),
                BikeActionItem(),
                BikeActionItem(),
                BikeActionItem()
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
        backButton.setBackgroundImage(UIColor.white.circularImage(diameter: 28), for: .highlighted)  // 设置自定义图片
        backButton.setBackgroundImage(UIColor.white.circularImage(diameter: 28), for: .highlighted)  // 设置自定义图片
        backButton.setTitle("", for: .normal)  // 设置标题
        backButton.setTitleColor(.black, for: .normal)  // 设置标题颜色
        backButton.addAction(for: .touchUpInside) {
            self.navigationController?.popViewController(animated: true)
        }
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 18),
            backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 6),
            backButton.widthAnchor.constraint(equalToConstant: 28),
            backButton.heightAnchor.constraint(equalToConstant: 28),

        ])
    }
   
    private func setupSubviews() {
        self.view.backgroundColor = UIColor(rgba: 0xF7F7F7FF)
        let backgroundView = UIView(frame: self.view.bounds)
        backgroundView.backgroundColor = UIColor(rgba: 0xF7F7F7FF)
        // 设置背景图
        let backgroundImageView = UIImageView(image: UIImage(named: "device_background"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 383)
        backgroundView.addSubview(backgroundImageView)
        collectionView.backgroundView = backgroundView
        
        view.addSubview(collectionView)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
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
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 300)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: BikeStatusViewCell.self, for: self, at: index) else {return UICollectionViewCell()}
        // 配置图片和状态
        return cell
    }
}
class BikeInfoSectionController: ListSectionController {
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 54)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: BikeInfoViewCell.self, for: self, at: index) else {return UICollectionViewCell()}
        // 配置图片和状态
        return cell
    }
}
class BikeRemainingTermSectionController: ListSectionController {
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 54)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: BikeRemainingTermViewCell.self, for: self, at: index) else {return UICollectionViewCell()}
        // 配置图片和状态
        return cell
    }
}
class BikeAgentSectionController: ListSectionController {
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 54)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: BikeAgentViewCell.self, for: self, at: index) else {return UICollectionViewCell()}
        // 配置图片和状态
        return cell
    }
}
class BikeActionSectionController: ListSectionController {
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        minimumLineSpacing = 12
        minimumInteritemSpacing = 15
    }
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: (collectionContext?.containerSize.width ?? 0 - 24 - 15)/2, height: 64)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: BikeActionViewCell.self, for: self, at: index) else {return UICollectionViewCell()}
        // 配置图片和状态
        return cell
    }
    override func didSelectItem(at index: Int) {
        
    }
}
class BikeSiteSectionController: ListSectionController {
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 54)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: BikeSiteViewCell.self, for: self, at: index) else {return UICollectionViewCell()}
        // 配置图片和状态
        return cell
    }
}
class ContactInfoSectionController: ListSectionController {
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 92)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: ContactInfoViewCell.self, for: self, at: index) else {return UICollectionViewCell()}
        // 配置图片和状态
        return cell
    }
}
