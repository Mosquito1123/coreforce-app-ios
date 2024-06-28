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
    lazy var batteryRentalView: PersonalRentalView = {
        let rentalView = PersonalRentalView()
        rentalView.titleLabel.text = "骑行无忧，单电续航超百公里！！"
        rentalView.titleLabel.textColor = UIColor(named: "12B858")
        rentalView.backgroundColor = UIColor(named: "39D97C 10")
        rentalView.sureButton.setBackgroundImage(UIColor(named: "39D97C")?.toImage(), for: .normal)
        rentalView.sureButton.setBackgroundImage(UIColor(named: "39D97C")?.withAlphaComponent(0.5).toImage(), for: .highlighted)
        rentalView.sureButton.setTitle("扫码租电", for: .normal)
        rentalView.sureButton.setTitle("扫码租电", for: .highlighted)

        rentalView.translatesAutoresizingMaskIntoConstraints = false
        return rentalView
    }()
    lazy var bikeRentalView: PersonalRentalView = {
        let rentalView = PersonalRentalView()
        rentalView.translatesAutoresizingMaskIntoConstraints = false
        return rentalView
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
        self.stackView.addArrangedSubview(self.batteryRentalView)
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
        self.stackView.addArrangedSubview(self.bikeRentalView)
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
class PersonalRentalView:UIView{
    var sureAction:ButtonActionBlock?
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "核蜂动力向每一位骑士致敬！！"
        label.textColor = UIColor(named: "447AFE")
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var sureButton:UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 82, height: 31)
        button.tintAdjustmentMode = .automatic
        button.setBackgroundImage(UIColor(named: "447AFE")?.toImage(), for: .normal)
        button.setBackgroundImage(UIColor(named: "447AFE")?.withAlphaComponent(0.5).toImage(), for: .highlighted)
        button.setImage(UIImage(named: "ic_arrow_right"), for: .normal)
        button.setImage(UIImage(named: "ic_arrow_right"), for: .highlighted)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.setTitle("扫码租车", for: .normal)
        button.setTitle("扫码租车", for: .highlighted)
        button.layer.cornerRadius = 15.5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(sureButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupLayout()
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    private func setupSubviews() {
        self.backgroundColor = UIColor(named: "447AFE 10")
        self.layer.cornerRadius = 12
        self.addSubview(titleLabel)
        self.addSubview(sureButton)
    }
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 12),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.sureButton.leadingAnchor, constant: -12),
            titleLabel.centerYAnchor.constraint(equalTo: self.sureButton.centerYAnchor),
            self.sureButton.topAnchor.constraint(equalTo: self.topAnchor,constant: 8),
            self.sureButton.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -8),
            self.sureButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10),
            self.sureButton.widthAnchor.constraint(equalToConstant: 82),
            self.sureButton.heightAnchor.constraint(equalToConstant: 31),

        
        ])
    }
    @objc func sureButtonTapped(_ sender:UIButton){
        self.sureAction?(sender)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.sureButton.setImagePosition(type: .imageRight, Space: 6)
    }
}
