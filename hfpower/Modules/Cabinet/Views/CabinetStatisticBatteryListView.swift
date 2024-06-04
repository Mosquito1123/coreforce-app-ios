//
//  CabinetStatisticBatteryListView.swift
//  hfpower
//
//  Created by EDY on 2024/5/31.
//

import UIKit

class CabinetStatisticBatteryListView: UIView {

    // MARK: - Accessor
    var batteryLevels: [CGFloat] = [0.82, 0.5, 0.1]{
        didSet{
            self.tableView.reloadData()
        }
    }
    // MARK: - Subviews
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.register(BatteryTableViewCell.self, forCellReuseIdentifier: BatteryTableViewCell.cellIdentifier())
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundView = UIView()
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "F7F8FB")
        self.layer.cornerRadius = 4
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Setup
private extension CabinetStatisticBatteryListView {
    
    private func setupSubviews() {
        addSubview(tableView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor,constant: 10),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10),
        ])
    }
    
}

// MARK: - Public
extension CabinetStatisticBatteryListView :UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return batteryLevels.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BatteryTableViewCell.cellIdentifier(), for: indexPath) as? BatteryTableViewCell else {return BatteryTableViewCell()}
        cell.batteryLevel = batteryLevels[indexPath.row]
        
        return cell
    }
    
    
}

// MARK: - Action
@objc private extension CabinetStatisticBatteryListView {
    
}

// MARK: - Private
private extension CabinetStatisticBatteryListView {
    
}
