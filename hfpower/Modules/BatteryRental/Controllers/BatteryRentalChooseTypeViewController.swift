//
//  BatteryRentalChooseTypeViewController.swift
//  hfpower
//
//  Created by EDY on 2024/9/13.
//

import UIKit

class BatteryRentalChooseTypeViewController: BaseTableViewController<BatteryRentalChooseTypeViewCell,HFBatteryRentalTypeInfo> {
    
    // MARK: - Accessor
    
    // MARK: - Subviews

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cellx = cell as? BatteryRentalChooseTypeViewCell{
            cellx.sureAction = { sender in
                let batteryRentalViewController = BatteryRentalViewController()
                batteryRentalViewController.batteryType = self.items[indexPath.row]
                self.navigationController?.pushViewController(batteryRentalViewController, animated: true)
            }
            cellx.detailAction = { sender in
                let batteryTypeDetailVC = BatteryTypeDetailViewController()
                batteryTypeDetailVC.batteryType = HFBatteryTypeList.mj_object(withKeyValues: self.items[indexPath.row].mj_keyValues())
                self.navigationController?.pushViewController(batteryTypeDetailVC, animated: true)
            }
        }
    }
}

// MARK: - Setup
private extension BatteryRentalChooseTypeViewController {
    
    private func setupNavbar() {
        self.title = "可用电池型号"
    }
    
    private func setupSubviews() {
        self.view.backgroundColor = UIColor(hex:0xF6F6F6FF)
        self.tableView.backgroundColor = UIColor(hex:0xF6F6F6FF)
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
extension BatteryRentalChooseTypeViewController {
    
}

// MARK: - Request
private extension BatteryRentalChooseTypeViewController {
    
}

// MARK: - Action
@objc private extension BatteryRentalChooseTypeViewController {
    
}

// MARK: - Private
private extension BatteryRentalChooseTypeViewController {
    
}
