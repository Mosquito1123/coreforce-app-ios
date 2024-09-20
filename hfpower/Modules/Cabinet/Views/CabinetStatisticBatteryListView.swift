//
//  CabinetStatisticBatteryListView.swift
//  hfpower
//
//  Created by EDY on 2024/5/31.
//

import UIKit

class CabinetStatisticBatteryListView: UIView {

    // MARK: - Accessor
    var onLine:Bool = false{
        didSet{
            tableView.isHidden = !onLine
            titleLabel.isHidden = onLine
            imageView.isHidden = onLine

        }
    }
    var batteryLevels: [CGFloat] = [0.82, 0.5, 0.1]{
        didSet{
            self.tableView.reloadData()
        }
    }
    // MARK: - Subviews
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = false

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
    lazy var imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.image = UIImage(named: "cabinet_offline")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "电柜离线"
        label.numberOfLines = 0
        label.isHidden = true
        label.textColor = UIColor(hex:0x969FBBFF)
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hex:0xF7F8FBFF)
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
        addSubview(titleLabel)
        addSubview(imageView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor,constant: 10),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -10),
        ])
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor,constant: -7),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
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
