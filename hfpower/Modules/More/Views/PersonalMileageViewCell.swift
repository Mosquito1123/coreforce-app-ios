//
//  PersonalMileageViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/6/24.
//

import UIKit

class PersonalMileageViewCell: PersonalContentViewCell {
    
    // MARK: - Accessor
    var extra:[String:Any]?{
        didSet{
            if let view11 = mileageStackView.arrangedSubviews[1] as? PersonalElementView{
                view11.titleLabel.text = "\(String(describing: extra?["todayMileage"] ?? "0"))km"
                view11.subTitleLabel.text = "今日里程"
            }
            if let view12 = mileageStackView.arrangedSubviews[2] as? PersonalElementView{
                view12.titleLabel.text = "\(String(describing: extra?["allMileage"] ?? "0"))km"
                view12.subTitleLabel.text = "历史里程"
            }
            if let view13 = mileageStackView.arrangedSubviews[3] as? PersonalElementView{
                view13.titleLabel.text = "\(String(describing: extra?["carbon"]  ?? "0"))kg"
                view13.subTitleLabel.text = "节能减排"
            }
        }
    }
    // MARK: - Subviews
    lazy var mileageStackView: HFStackView = {
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
    
    override class func cell(with tableView: UITableView) -> PersonalMileageViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? PersonalMileageViewCell { return cell }
        return PersonalMileageViewCell(style: .default, reuseIdentifier: identifier)
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
private extension PersonalMileageViewCell {
    
    private func setupSubviews() {
        let view10 = PersonalIconView()
        view10.iconImageView.image = UIImage(named: "mileage")
        view10.tag = 10
        let view11 = PersonalElementView()
        view11.tag = 11
        let view12 = PersonalElementView()
        view12.tag = 12
        let view13 = PersonalElementView()
        view13.tag = 13
        self.mileageStackView.addArrangedSubview(view10)
        self.mileageStackView.addArrangedSubview(view11)
        self.mileageStackView.addArrangedSubview(view12)
        self.mileageStackView.addArrangedSubview(view13)
        self.stackView.addArrangedSubview(self.mileageStackView)
    }
    
    private func setupLayout() {
        
    }
    
}

// MARK: - Public
extension PersonalMileageViewCell {
    
}

// MARK: - Action
@objc private extension PersonalMileageViewCell {
    
}

// MARK: - Private
private extension PersonalMileageViewCell {
    
}
