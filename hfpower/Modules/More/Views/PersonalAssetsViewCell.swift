//
//  PersonalAssetsViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/6/24.
//

import UIKit

class PersonalAssetsViewCell: PersonalContentViewCell {
    
    // MARK: - Accessor
    var packageCardBlock:((UITapGestureRecognizer)->Void)?
    var depositBlock:((UITapGestureRecognizer)->Void)?
    var couponBlock:((UITapGestureRecognizer)->Void)?

    // MARK: - Subviews
    lazy var assetsStackView: HFStackView = {
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
    
    override class func cell(with tableView: UITableView) -> PersonalAssetsViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? PersonalAssetsViewCell { return cell }
        return PersonalAssetsViewCell(style: .default, reuseIdentifier: identifier)
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Setup
private extension PersonalAssetsViewCell {
    
    private func setupSubviews() {
        let view10 = PersonalIconView()
        view10.iconImageView.image = UIImage(named: "assets")
        view10.tag = 10
        let view11 = PersonalElementView()
        view11.tag = 11
        view11.isUserInteractionEnabled = true
        let tap11 = UITapGestureRecognizer(target: self, action: #selector(packageCard(_:)))
        view11.addGestureRecognizer(tap11)
        let view12 = PersonalElementView()
        view12.tag = 12
        view12.isUserInteractionEnabled = true
        let tap12 = UITapGestureRecognizer(target: self, action: #selector(deposit(_:)))
        view12.addGestureRecognizer(tap12)
        let view13 = PersonalElementView()
        view13.tag = 13
        view13.isUserInteractionEnabled = true
        let tap13 = UITapGestureRecognizer(target: self, action: #selector(coupon(_:)))
        view13.addGestureRecognizer(tap13)
        self.assetsStackView.addArrangedSubview(view10)
        self.assetsStackView.addArrangedSubview(view11)
        self.assetsStackView.addArrangedSubview(view12)
        self.assetsStackView.addArrangedSubview(view13)
        self.stackView.addArrangedSubview(self.assetsStackView)

    }
    
    private func setupLayout() {
        
    }
    
}

// MARK: - Public
extension PersonalAssetsViewCell {
    
}

// MARK: - Action
@objc private extension PersonalAssetsViewCell {
    
    @objc func packageCard(_ sender:UITapGestureRecognizer){
        self.packageCardBlock?(sender)
    }
    
    @objc func deposit(_ sender:UITapGestureRecognizer){
        self.depositBlock?(sender)
    }
    
    @objc func coupon(_ sender:UITapGestureRecognizer){
        self.couponBlock?(sender)
    }
}

// MARK: - Private
private extension PersonalAssetsViewCell {
    
}
