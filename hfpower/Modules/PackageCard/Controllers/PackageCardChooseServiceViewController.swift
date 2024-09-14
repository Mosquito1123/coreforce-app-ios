//
//  PackageCardChooseServiceViewController.swift
//  hfpower
//
//  Created by EDY on 2024/7/10.
//

import UIKit

class PackageCardChooseServiceViewController: BaseTableViewController<PackageCardChooseServiceViewCell,PackageCardChooseService> {
    
    // MARK: - Accessor
    var titleAction:ButtonActionBlock?
    // MARK: - Subviews
    lazy var titleButton:UIButton = {
        let button = UIButton(type: .custom)
        button.tintAdjustmentMode = .automatic
        button.setBackgroundImage(UIColor.white.toImage(), for: .normal)
        button.setBackgroundImage(UIColor.white.withAlphaComponent(0.5).toImage(), for: .highlighted)
        button.setTitleColor(UIColor(rgba: 0x333333FF), for: .normal)
        button.setTitleColor(UIColor(rgba: 0x333333FF), for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17,weight: .semibold)
        button.setTitle(CityCodeManager.shared.cityName, for: .normal)
        button.setTitle(CityCodeManager.shared.cityName, for: .highlighted)
        button.setImage(UIImage(named: "search_list_icon_location"), for: .normal)
        button.setImage(UIImage(named: "search_list_icon_location"), for: .highlighted)
        button.addTarget(self, action: #selector(titleButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // 懒加载的 TableView
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSubviews()
        setupLayout()
        self.items = [
            PackageCardChooseService(id: 0,title: "换电套餐",content: "不限次数，随取随换，全年至高可省1800",type: 0),
//            PackageCardChooseService(id: 1,title: "租车套餐",content: "各种车型，任你挑选",type: 1),
        ]
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleButton.setImagePosition(type: .imageLeft, Space: 6)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let chooseBatteryTypeViewController =  ChooseBatteryTypeViewController()
            self.navigationController?.pushViewController(chooseBatteryTypeViewController, animated: true)
        }
        
    }
    
}

// MARK: - Setup
private extension PackageCardChooseServiceViewController {
    
    private func setupNavbar() {
        self.navigationItem.titleView = titleButton
    }
   
    private func setupSubviews() {
        self.view.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        self.tableView.backgroundColor = .white
        let headerView = PackageCardChooseServiceViewCell.TableHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        self.tableView.tableHeaderView = headerView
        self.view.addSubview(self.tableView)
        
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
}

// MARK: - Public
extension PackageCardChooseServiceViewController{
    
    
}

// MARK: - Request
private extension PackageCardChooseServiceViewController {
    
}

// MARK: - Action
@objc private extension PackageCardChooseServiceViewController {
    @objc func titleButtonTapped(_ sender:UIButton){
        self.titleAction?(sender)
    }
}

// MARK: - Private
private extension PackageCardChooseServiceViewController {
    
}
