//
//  FirstContentCabinetListHeaderView.swift
//  hfpower
//
//  Created by EDY on 2024/10/15.
//

import UIKit
import MKDropdownMenu
class FirstContentCabinetListHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Accessor
    var componentsBlock:((_ distance:String?,_ largeTypeId:String?,_ powerLevel:String?)->Void)?
    var components:[CabinetFilter] = [
        
        CabinetFilter(id: 0, title: "距离最近", icon: "distance", type: .distance,filterItems:
                        [
                            CabinetFilterItem(id: 0, title: "全部", content: nil, selected: true),
                            CabinetFilterItem(id: 1, title: "1km", content: "1000", selected: false),
                        ]),
        CabinetFilter(id: 1, title: "电池类型", icon: "type", type: .type,filterItems: [
            CabinetFilterItem(id: 0, title: "全部", content: nil, selected: true),
        ]),
        CabinetFilter(id: 2, title: "电池电量", icon: "power", type: .power,filterItems: [
            CabinetFilterItem(id: 0, title: "全部", content: nil, selected: true),
            CabinetFilterItem(id: 1, title: ">90%", content: "1", selected: false),
        ]),
        
    ]{
        didSet{
            self.filterView.reloadAllComponents()
        }
    }
    // MARK: - Subviews
    lazy var locationView:CabinetLocationView = {
        let view = CabinetLocationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var filterView:MKDropdownMenu = {
        let view = MKDropdownMenu()
        view.backgroundColor = UIColor(hex:0xF7F7F7FF)
        view.componentSeparatorColor = UIColor(hex:0xF7F7F7FF)
        view.rowSeparatorColor = UIColor.white
        view.selectedComponentBackgroundColor = UIColor.white
        view.dropdownBackgroundColor = UIColor.white
        view.dropdownShowsBorder = false
        view.dropdownShowsTopRowSeparator = false
        view.dropdownShowsBottomRowSeparator = false
        view.disclosureIndicatorImage = UIImage(named: "icon_arrow_down")
        view.dataSource = self
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // MARK: - Lifecycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupSubviews()
        setupLayout()
    }
    // MARK: - Static
    class func viewIdentifier() -> String {
        return String(describing: self)
    }
    
    class func headerView(with tableView: UITableView) -> FirstContentCabinetListHeaderView {
        let identifier = viewIdentifier()
        if let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? FirstContentCabinetListHeaderView { return cell }
        return FirstContentCabinetListHeaderView(reuseIdentifier: identifier)
    }
}
extension FirstContentCabinetListHeaderView: MKDropdownMenuDataSource, MKDropdownMenuDelegate {
    func numberOfComponents(in dropdownMenu: MKDropdownMenu) -> Int {
        return components.count
    }
    func dropdownMenu(_ dropdownMenu: MKDropdownMenu, numberOfRowsInComponent component: Int) -> Int {
        let items = self.components[component].filterItems ?? []
        return items.count
    }
    func dropdownMenu(_ dropdownMenu: MKDropdownMenu, shouldUseFullRowWidthForComponent component: Int) -> Bool {
        return true
    }
    func dropdownMenu(_ dropdownMenu: MKDropdownMenu, attributedTitleForComponent component: Int) -> NSAttributedString? {
        let componentTitle = self.components[component].title ?? ""
        return NSAttributedString(string: componentTitle, attributes: [NSAttributedString.Key.foregroundColor:UIColor(hex:0x666666FF),NSAttributedString.Key.font:UIFont.systemFont(ofSize: 13)])
    }
    func dropdownMenu(_ dropdownMenu: MKDropdownMenu, attributedTitleForSelectedComponent component: Int) -> NSAttributedString? {
        let componentTitle = self.components[component].title ?? ""
        return NSAttributedString(string: componentTitle, attributes: [NSAttributedString.Key.foregroundColor:UIColor(hex:0x1D2129FF),NSAttributedString.Key.font:UIFont.systemFont(ofSize: 13, weight: .medium)])
    }
    func dropdownMenu(_ dropdownMenu: MKDropdownMenu, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let rowTitle = self.components[component].filterItems?[row].title ?? ""
        let selected = self.components[component].filterItems?[row].selected ?? false
        return NSAttributedString(string: rowTitle, attributes: [NSAttributedString.Key.foregroundColor:selected ? UIColor(hex:0x165DFFFF):UIColor(hex:0x1D2129FF),NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14)])
    }
    func dropdownMenu(_ dropdownMenu: MKDropdownMenu, accessoryViewForRow row: Int, forComponent component: Int) -> UIView? {
        let selected = self.components[component].filterItems?[row].selected ?? false
        return selected ? UIImageView(image: UIImage(named: "icon_accessory_selected")) : nil
    }
    func dropdownMenu(_ dropdownMenu: MKDropdownMenu, didSelectRow row: Int, inComponent component: Int) {
        self.components[component].filterItems = self.components[component].filterItems?.map { option in
            var newOption = option
            newOption.selected = false
            return newOption
        }
        
        // 设置当前选中的选项为 true
        self.components[component].filterItems?[row].selected = true
        dropdownMenu.reloadComponent(component)
        //        dropdownMenu.closeAllComponents(animated: true)
        let distanceItem = self.components.first { filter in
            return filter.type == .distance
        }?.filterItems?.first(where: { item in
            return item.selected == true
        })
        let typeItem = self.components.first { filter in
            return filter.type == .type
        }?.filterItems?.first(where: { item in
            return item.selected == true
        })
        let powerItem = self.components.first { filter in
            return filter.type == .power
        }?.filterItems?.first(where: { item in
            return item.selected == true
        })
        self.componentsBlock?(distanceItem?.content,typeItem?.content,powerItem?.content)
        
    }
}
// MARK: - Setup
private extension FirstContentCabinetListHeaderView {
    
    private func setupSubviews() {
        self.contentView.backgroundColor = UIColor(hex:0xF7F7F7FF)
        self.contentView.addSubview(locationView)
        self.contentView.addSubview(filterView)
        self.locationView.location = ""
    }
    
    private func setupLayout() {
        // locationView 约束
        NSLayoutConstraint.activate([
            locationView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            locationView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            locationView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            locationView.heightAnchor.constraint(equalToConstant: 44) // 假设 locationView 高度为 44
        ])
        
        // filterView 约束
        NSLayoutConstraint.activate([
            filterView.topAnchor.constraint(equalTo: locationView.bottomAnchor),
            filterView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            filterView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            filterView.heightAnchor.constraint(equalToConstant: 44), // 假设 filterView 高度为 44
            filterView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
}

// MARK: - Public
extension FirstContentCabinetListHeaderView {
    
}

// MARK: - Action
@objc private extension FirstContentCabinetListHeaderView {
    
}

// MARK: - Private
private extension FirstContentCabinetListHeaderView {
    
}
