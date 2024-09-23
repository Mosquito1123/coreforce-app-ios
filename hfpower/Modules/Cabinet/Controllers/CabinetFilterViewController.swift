//
//  CabinetFilterViewController.swift
//  hfpower
//
//  Created by EDY on 2024/7/5.
//

import UIKit

class CabinetFilterViewController: UIViewController {
    
    // MARK: - Accessor
    var sureAction:((_ sender:UIButton,_ typeItem:CabinetFilterItem?,_ powerItem:CabinetFilterItem?)->Void)?
    var closeAction:ButtonActionBlock?
    var typeItem:CabinetFilterItem?
    var powerItem:CabinetFilterItem?
    var items = [CabinetFilter](){
        didSet{
            self.collectionView.reloadData()
        }
    }
    // MARK: - Subviews
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(hex:0x1D2129FF)
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var closeButton:UIButton = {
        let button = UIButton(type:.custom)
        button.setImage(UIImage(named: "filter_close")?.resized(toSize: CGSize(width: 20, height: 20)), for: .normal)
        button.addTarget(self, action: #selector(close(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var sureButton:UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 343, height: 40)
        button.tintAdjustmentMode = .automatic
        button.setBackgroundImage(UIColor(hex:0x447AFEFF).toImage(), for: .normal)
        button.setBackgroundImage(UIColor(hex:0x447AFEFF).withAlphaComponent(0.5).toImage(), for: .highlighted)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitle("确定", for: .normal)
        button.setTitle("确定", for: .highlighted)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(sureButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var collectionView: UICollectionView = {
        // 初始化 UICollectionViewFlowLayout
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumInteritemSpacing = 10 // 列间距
        collectionViewLayout.minimumLineSpacing = 16 // 行间距
        let itemWidth = (UIScreen.main.bounds.size.width - 16 - 30 - 16) / 4
        collectionViewLayout.itemSize = CGSize(width: itemWidth, height: 36)
        collectionViewLayout.headerReferenceSize = CGSize(width: (UIScreen.main.bounds.size.width - 16 - 16), height: 44)
        
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        collectionViewLayout.scrollDirection = .vertical
        
        // 初始化 UICollectionView
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
        // 注册 UICollectionView 的 cell
        collectionView.register(CabinetFilterViewCell.self, forCellWithReuseIdentifier: CabinetFilterViewCell.cellIdentifier())
        collectionView.register(CabinetFilterHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CabinetFilterHeaderReusableView.viewIdentifier())
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavbar()
        setupSubviews()
        setupLayout()
        loadData()
        
    }
    func loadData(){
        let code = CityCodeManager.shared.cityCode ?? "370200"

        var params = [String: Any]()
        params["cityCode"] = code.replacingLastTwoCharactersWithZeroes()

        self.getData(largeTypeUrl, param: params, isLoading:false) { responseObject in
            if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],
               let list = body["list"] as? [[String:Any]]{
                let items = (HFBatteryTypeList.mj_objectArray(withKeyValuesArray: list) as? [HFBatteryTypeList]) ?? []
//                self.items = items
                var temp  = [CabinetFilterItem]()
                temp.append(CabinetFilterItem(id: 0, title: "全部", content: nil, selected: true))
                temp.append(contentsOf: items.map { CabinetFilterItem(id: $0.id.intValue, title: $0.name, content: $0.id.stringValue, selected: false)})
                let typeTemp = temp.map { item in
                    var cItem = item
                    cItem.selected = item.id == self.typeItem?.id
                    return cItem
                }
                let powerTemp = [CabinetFilterItem(id: 0, title: "全部", content: nil, selected: true),CabinetFilterItem(id: 1, title: ">90%", content: "1", selected: false)].map { item in
                    var cItem = item
                    cItem.selected = item.id == self.powerItem?.id
                    return cItem
                }
                    
                self.items = [
                    CabinetFilter(id: 0, title: "电池型号",type:.type, filterItems: typeTemp),
                    CabinetFilter(id: 1, title: "电池电量",type: .power,filterItems: powerTemp),
//                    CabinetFilter(id: 2, title: "电柜", filterItems: [CabinetFilterItem(id: 0, title: "全部", content: "", selected: true),CabinetFilterItem(id: 1, title: "可租赁", content: "", selected: false),CabinetFilterItem(id: 2, title: "可寄存", content: "", selected: false),CabinetFilterItem(id: 3, title: "24h", content: "", selected: false)]),
                ]

            }
        } error: { error in
            self.showError(withStatus: error.localizedDescription)
        }

    }
    
}

// MARK: - Setup
private extension CabinetFilterViewController {
    
    private func setupNavbar() {
        self.title = "筛选"
        self.titleLabel.text = self.title
    }
    
    private func setupSubviews() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.closeButton)
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.sureButton)
        self.view.bringSubviewToFront(self.sureButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 13),
            titleLabel.bottomAnchor.constraint(equalTo: self.collectionView.topAnchor, constant: -13),
            
            closeButton.widthAnchor.constraint(equalToConstant: 27),
            closeButton.heightAnchor.constraint(equalToConstant: 27),
            closeButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 11),
            closeButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -13),
            
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -80)
            
            
        ])
        NSLayoutConstraint.activate([
            sureButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 16),
            sureButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -16),
            sureButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -27),
            sureButton.heightAnchor.constraint(equalToConstant: 40)
            
            
        ])
    }
}

// MARK: - Public
extension CabinetFilterViewController {
    
}
extension CabinetFilterViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.items.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items[section].filterItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CabinetFilterViewCell.cellIdentifier(), for: indexPath) as? CabinetFilterViewCell else {return CabinetFilterViewCell()}
        cell.model = self.items[indexPath.section].filterItems?[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CabinetFilterHeaderReusableView.viewIdentifier(), for: indexPath) as? CabinetFilterHeaderReusableView else {return CabinetFilterHeaderReusableView()}
        view.element = self.items[indexPath.section]
        return view
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard var cabinetFilterItems = self.items[indexPath.section].filterItems else {
            return
        }
        
        var updatedIndexPaths: [IndexPath] = []
        
        for (i, var item) in cabinetFilterItems.enumerated() {
            if i == indexPath.item && !(item.selected ?? false) {
                item.selected = true
                updatedIndexPaths.append(IndexPath(row: i, section: indexPath.section))
            } else if i != indexPath.item && (item.selected ?? false) {
                item.selected = false
                updatedIndexPaths.append(IndexPath(row: i, section: indexPath.section))
            }
            cabinetFilterItems[i] = item
        }
        
        self.items[indexPath.section].filterItems = cabinetFilterItems
        
        collectionView.performBatchUpdates({
            collectionView.reloadItems(at: updatedIndexPaths)
        }, completion: nil)
        
        
    }
    
    
}
// MARK: - Request
private extension CabinetFilterViewController {
    
}

// MARK: - Action
@objc private extension CabinetFilterViewController {
    @objc func close(_ sender:UIButton){
        self.closeAction?(sender)
    }
    @objc func sureButtonTapped(_ sender:UIButton){
        let typeItem = self.items.first { filter in
            return filter.type == .type
        }?.filterItems?.first(where: { item in
            return item.selected == true
        })
        let powerItem = self.items.first { filter in
            return filter.type == .power
        }?.filterItems?.first(where: { item in
            return item.selected == true
        })
        self.sureAction?(sender,typeItem,powerItem)
    }
}

// MARK: - Private
private extension CabinetFilterViewController {
    
}
