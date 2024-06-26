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
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    lazy var bikeStackView: HFStackView = {
        let stackView = HFStackView()
        stackView.axis = .horizontal
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
        let view11 = PersonalElementView()
        view11.tag = 11
        let view12 = PersonalElementView()
        view12.tag = 12
        let view13 = PersonalElementView()
        view13.tag = 13
        self.batteryStackView.addArrangedSubview(view11)
        self.batteryStackView.addArrangedSubview(view12)
        self.batteryStackView.addArrangedSubview(view13)

        self.stackView.addArrangedSubview(self.batteryStackView)
        let view21 = PersonalElementView()
        view21.tag = 21
        let view22 = PersonalElementView()
        view22.tag = 22
        self.bikeStackView.addArrangedSubview(view21)
        self.bikeStackView.addArrangedSubview(view22)
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
