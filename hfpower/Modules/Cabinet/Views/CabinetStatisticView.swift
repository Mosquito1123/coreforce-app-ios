//
//  CabinetStatisticView.swift
//  hfpower
//
//  Created by EDY on 2024/5/31.
//

import UIKit

class CabinetStatisticView: UIView {

    // MARK: - Accessor
    var giftAction:ButtonActionBlock?
    var listTop:NSLayoutConstraint!
    var tableTop:NSLayoutConstraint!

    var showTop:Bool = false{
        didSet{
            iconImageView.isHidden = !showTop
            titleLabel.isHidden = !showTop
            giftIconButton.isHidden = !showTop
            giftButton.isHidden = !showTop
            listTop.constant = showTop ? 42:10
            tableTop.constant = showTop ? 42:10
            self.layoutIfNeeded()

        }
    }
    // MARK: - Subviews
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "cabinet_battery_detail")
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.isHidden = true
        return iconImageView
    }()
    lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = UIColor(named: "1D2129")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    lazy var giftIconButton: UIButton = {
        let button = UIButton(type:.custom)
        button.setImage(UIImage(named: "gift_icon"), for: .normal)
        button.setImage(UIImage(named: "gift_icon"), for: .highlighted)
        button.addTarget(self, action: #selector(giftButtonAction(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    lazy var giftButton: UIButton = {
        let button = UIButton(type:.custom)
        button.setImage(UIImage(named: "gift_right_icon"), for: .normal)
        button.setImage(UIImage(named: "gift_right_icon"), for: .highlighted)
        button.setTitleColor(UIColor(named: "C96518"), for: .normal)
        button.setTitleColor(UIColor(named: "C96518"), for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12,weight: .medium)
        button.addTarget(self, action: #selector(giftButtonAction(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
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
    override func layoutSubviews() {
        super.layoutSubviews()
        self.giftButton.setImagePosition(type: .imageRight, Space: 6)
    }

}

// MARK: - Setup
private extension CabinetStatisticView {
    
    private func setupSubviews() {
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(giftButton)
        addSubview(giftIconButton)
        addSubview(batteryListView)
        summaryTableView.items = [["48V","0","0"],["60V","0","0"]]
        addSubview(summaryTableView)
    }
    
    private func setupLayout() {
        listTop = batteryListView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10)
        tableTop = summaryTableView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10)
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            iconImageView.topAnchor.constraint(equalTo: self.topAnchor,constant: 17),
            iconImageView.widthAnchor.constraint(equalToConstant: 12),
            iconImageView.heightAnchor.constraint(equalToConstant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: self.iconImageView.trailingAnchor,constant: 7),
            titleLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            giftButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -12),
            giftButton.topAnchor.constraint(equalTo: self.topAnchor,constant: 17),
            giftIconButton.widthAnchor.constraint(equalToConstant: 12),
            giftIconButton.heightAnchor.constraint(equalToConstant: 12),
            giftIconButton.trailingAnchor.constraint(equalTo: self.giftButton.leadingAnchor,constant: -4),
            giftIconButton.centerYAnchor.constraint(equalTo: giftButton.centerYAnchor),
            batteryListView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            listTop,
            batteryListView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10),
            batteryListView.widthAnchor.constraint(equalToConstant: 50),
            summaryTableView.leadingAnchor.constraint(equalTo: batteryListView.trailingAnchor),
            tableTop,
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
    @objc func giftButtonAction(_ sender:UIButton){
        self.giftAction?(sender)
    }
}

// MARK: - Private
private extension CabinetStatisticView {
    
}
