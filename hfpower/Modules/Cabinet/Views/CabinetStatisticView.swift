//
//  CabinetStatisticView.swift
//  hfpower
//
//  Created by EDY on 2024/5/31.
//

import UIKit

class CabinetStatisticView: UIView {

    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var batteryListView: CabinetStatisticBatteryListView = {
        let view = CabinetStatisticBatteryListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var summaryTableView:SummaryTableView = {
        let view = SummaryTableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderColor = UIColor(named: "F2F3F5")?.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 10
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Setup
private extension CabinetStatisticView {
    
    private func setupSubviews() {
        addSubview(batteryListView)
        summaryTableView.items = [["48V","0","0"],["60V","0","0"]]
        addSubview(summaryTableView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            batteryListView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            batteryListView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            batteryListView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10),
            batteryListView.widthAnchor.constraint(equalToConstant: 50),
            summaryTableView.leadingAnchor.constraint(equalTo: batteryListView.trailingAnchor),
            summaryTableView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            summaryTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10),
           
            summaryTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

        ])
    }
    
}

// MARK: - Public
extension CabinetStatisticView {
    
}

// MARK: - Action
@objc private extension CabinetStatisticView {
    
}

// MARK: - Private
private extension CabinetStatisticView {
    
}
