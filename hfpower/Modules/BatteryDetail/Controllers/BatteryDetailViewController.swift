//
//  BatteryDetailViewController.swift
//  hfpower
//
//  Created by EDY on 2024/8/15.
//

import UIKit
import IGListKit
import CoreLocation
import MapKit
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
        if let batteryDetail = MainManager.shared.batteryDetail {
            self.data = [
                BatteryStatus(id:0, batteryDetail: batteryDetail),
                BatteryInfo(id: 1, items: [
                    BatteryInfoItem(id: 0,title: "电池编号",content: batteryDetail.number),
                    BatteryInfoItem(id: 1,title: "电池型号",content: batteryDetail.name),

                ]),
                BatteryRemainingTerm(id: 2,title: "剩余租期", content: batteryDetail.batteryEndDate?.timeRemaining() ?? "",overdueOrExpiringSoon: batteryDetail.batteryEndDate?.overdueOrExpiringSoon() ?? false),
                BatteryAction(id: 4, items: [
                    BatteryActionItem(id: 0, name: "续费", icon: "device_renewal"),
                    BatteryActionItem(id: 1, name: "响铃", icon: "device_ring"),
                    BatteryActionItem(id: 2, name: "退租", icon: "device_rent_out"),
                    BatteryActionItem(id: 3, name: "寄存", icon: "device_post")
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
}

// MARK: - Setup
private extension BatteryDetailViewController {
    
    private func setupNavbar() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back_arrow")?.resized(toSize: CGSize(width: 18, height: 18)), for: .normal)
        backButton.setImage(UIImage(named: "back_arrow")?.resized(toSize: CGSize(width: 18, height: 18)), for: .highlighted)
        backButton.setBackgroundImage(UIColor.white.circularImage(diameter: 28), for: .normal)  // 设置自定义图片
        backButton.setBackgroundImage(UIColor.white.circularImage(diameter: 28), for: .highlighted)  // 设置自定义图片
        backButton.setTitle("", for: .normal)  // 设置标题
        backButton.setTitleColor(.black, for: .normal)  // 设置标题颜色
        backButton.addAction(for: .touchUpInside) {
            self.navigationController?.popViewController(animated: true)
        }
        backButton.translatesAutoresizingMaskIntoConstraints = false
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundImage = UIImage()
            appearance.shadowImage = UIImage()
            
            appearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.clear,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .semibold)
            ]
            
            self.navigationItem.standardAppearance = appearance
            self.navigationItem.scrollEdgeAppearance = appearance
        }
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
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 300)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: BatteryStatusViewCell.self, for: self, at: index) as? BatteryStatusViewCell else {return BatteryStatusViewCell()}
        // 配置图片和状态
        cell.batteryStatus = batteryStatus
        cell.navigateAction = { [self] in
           
            guard let lat = self.batteryStatus.batteryDetail.lastLat?.doubleValue,let lon = self.batteryStatus.batteryDetail.lastLon?.doubleValue else {
                self.viewController?.showError(withStatus: "该电池坐标数据有误")
                return}
            self.viewController?.mapNavigation(lat: lat, lng:lon, address: batteryStatus.batteryDetail.number, currentController: self.viewController)
        }
        return cell
    }
    override func didUpdate(to object: Any) {
        batteryStatus = object as? BatteryStatus
    }
}
class BatteryInfoSectionController: ListSectionController {
    private var batteryInfo: BatteryInfo!

    override func numberOfItems() -> Int {
        return batteryInfo.items.count
    }
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 54)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: BatteryInfoViewCell.self, for: self, at: index) as? BatteryInfoViewCell else {return BatteryInfoViewCell()}
        // 配置图片和状态
        // 判断第一个和最后一个cell并设置圆角
        if index == 0 {
            cell.cornerType = .first
        } else if index == batteryInfo.items.count - 1 {
            cell.cornerType = .last
        }
        cell.element = batteryInfo.items[index]
        return cell
    }
    override func didUpdate(to object: Any) {
        batteryInfo = object as? BatteryInfo
    }
}
class BatteryRemainingTermSectionController: ListSectionController {
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 12, left: 0, bottom: 8, right: 0)

    }
    private var batteryRemainingTerm: BatteryRemainingTerm!

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 111)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: BatteryRemainingTermViewCell.self, for: self, at: index) as? BatteryRemainingTermViewCell else {return UICollectionViewCell()}
        // 配置图片和状态
        cell.bottomView.getPackageCardBlock = { sender in
        }
        cell.element = batteryRemainingTerm
        return cell
    }
    override func didUpdate(to object: Any) {
        batteryRemainingTerm = object as? BatteryRemainingTerm
    }
}
class BatteryAgentSectionController: ListSectionController {
    private var batteryAgent: BatteryAgent!

    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 54)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: BatteryAgentViewCell.self, for: self, at: index) as? BatteryAgentViewCell else {return UICollectionViewCell()}
        // 配置图片和状态
        return cell
    }
    override func didUpdate(to object: Any) {
        batteryAgent = object as? BatteryAgent
    }
}
class BatteryActionSectionController: ListSectionController {
    private var batteryAction: BatteryAction!

    override func numberOfItems() -> Int {
        return batteryAction.items.count
    }
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        minimumLineSpacing = 12
        minimumInteritemSpacing = 15
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: ((collectionContext?.containerSize.width ?? 0) - 24 - 15)/2, height: 64)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: BatteryActionViewCell.self, for: self, at: index) as? BatteryActionViewCell else {
            return UICollectionViewCell()}
        // 配置图片和状态
        cell.element = batteryAction.items[index]
        return cell
    }
    override func didSelectItem(at index: Int) {
        
    }
    override func didUpdate(to object: Any) {
        batteryAction = object as? BatteryAction
    }
}
class BatterySiteSectionController: ListSectionController {
    private var batterySite: BatterySite!


    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext?.containerSize.width ?? 0, height: 54)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: BatterySiteViewCell.self, for: self, at: index) as? BatterySiteViewCell else {return BatterySiteViewCell()}
        // 配置图片和状态
        return cell
    }
    override func didUpdate(to object: Any) {
        batterySite = object as? BatterySite
    }
    override func didSelectItem(at index: Int) {
        let lat = MainManager.shared.batteryDetail?.lastLat?.doubleValue ?? 0
        let lon = MainManager.shared.batteryDetail?.lastLon?.doubleValue ?? 0

        /*NetworkService<BusinessAPI,CabinetListResponse>().request(.cabinetList(tempStorageSw: nil, cityCode: CityCodeManager.shared.cityCode, lon: nil, lat:nil)) { result in
            switch result{
            case .success(let response):
                
                let filteredArray = response?.list?.filter { $0.onLine == true && ($0.batteryCount ?? 0) > 0 } ?? [CabinetSummary]()

                var locations = [CLLocation]()
                for mapAnnotation in filteredArray {
                    let location = CLLocation(latitude: mapAnnotation.gdLat?.doubleValue ?? 0, longitude: mapAnnotation.gdLon?.doubleValue ?? 0)
                    locations.append(location)
                }

                var minDistance = CLLocationDistance.greatestFiniteMagnitude
                var nearestLocation: CLLocation?

                for loc in locations {
                    let point1 = MKMapPoint(CLLocationCoordinate2DMake(lat, lon))
                    let point2 = MKMapPoint(loc.coordinate)
                    let distance = point1.distance(to: point2)

                    if distance < minDistance {
                        minDistance = distance
                        nearestLocation = loc
                    }
                }
                self.viewController?.mapNavigation(lat: nearestLocation?.coordinate.latitude ?? 0, lng: nearestLocation?.coordinate.longitude ?? 0, address: "换电柜", currentController: self.viewController)

            case .failure(let error):
                self.viewController?.showError(withStatus: error.localizedDescription)
                
            }
        }
         */

    }
}
