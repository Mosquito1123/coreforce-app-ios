//
//  PersonalDevicesViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/6/24.
//

import UIKit

class PersonalDevicesViewCell: PersonalContentViewCell {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var batteryStackView: HFStackView = {
        let stackView = HFStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    lazy var bikeStackView: HFStackView = {
        let stackView = HFStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    // MARK: - Static
    override class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    override class func cell(with tableView: UITableView) -> PersonalDevicesViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? PersonalDevicesViewCell { return cell }
        return PersonalDevicesViewCell(style: .default, reuseIdentifier: identifier)
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Setup
private extension PersonalDevicesViewCell {
    
    private func setupSubviews() {
        let view10 = PersonalIconView()
        view10.iconImageView.image = UIImage(named: "battery_5")
        view10.tag = 10
        let view11 = PersonalElementView()
        view11.tag = 11
        let view12 = PersonalElementView()
        view12.tag = 12
        let view13 = PersonalElementView()
        view13.tag = 13
        let view14 = PersonalIconView()
        view14.iconWidth.constant = 8
        view14.iconHeight.constant = 15
        view14.iconImageView.image = UIImage(named: "arrow_right")
        view14.tag = 14
        self.batteryStackView.addArrangedSubview(view10)
        self.batteryStackView.addArrangedSubview(view11)
        self.batteryStackView.addArrangedSubview(view12)
        self.batteryStackView.addArrangedSubview(view13)
        self.batteryStackView.addArrangedSubview(view14)

        self.stackView.addArrangedSubview(self.batteryStackView)
        let view20 = PersonalIconView()
        view20.iconImageView.image = UIImage(named: "motorcycle")
        view20.tag = 20
        let view21 = PersonalElementView()
        view21.tag = 21
        let view22 = PersonalElementView()
        view22.tag = 22
        let view23 = PersonalIconView()
        view23.iconWidth.constant = 8
        view23.iconHeight.constant = 15
        view23.iconImageView.image = UIImage(named: "arrow_right")
        view23.tag = 23
        self.bikeStackView.addArrangedSubview(view20)
        self.bikeStackView.addArrangedSubview(view21)
        self.bikeStackView.addArrangedSubview(view22)
        self.bikeStackView.addArrangedSubview(view23)

        self.stackView.addArrangedSubview(self.bikeStackView)
    }
    
    private func setupLayout() {
       
        
    }
    
}

// MARK: - Public
extension PersonalDevicesViewCell {
    
}

// MARK: - Action
@objc private extension PersonalDevicesViewCell {
    
}

// MARK: - Private
private extension PersonalDevicesViewCell {
    
}
