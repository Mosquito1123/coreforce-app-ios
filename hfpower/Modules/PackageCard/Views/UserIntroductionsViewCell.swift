//
//  UserIntroductionsViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/7/3.
//

import UIKit

class UserIntroductionsViewCell: UITableViewCell {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var headerView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgba:0xFFF7E8FF)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var headerIconView:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "notice")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgba:0x333333FF)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var pointView1:UIView  = {
        let view = UIView()
        view.layer.cornerRadius = 2.5
        view.backgroundColor = UIColor(rgba:0xD2D2D2FF)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var pointLabel1:UILabel  = {
        let label = UILabel()
        label.text = "自取出电池后，不支持退租金；"
        label.textColor = UIColor(rgba:0x666666FF)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var pointView2:UIView  = {
        let view = UIView()
        view.layer.cornerRadius = 2.5
        view.backgroundColor = UIColor(rgba:0xD2D2D2FF)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var pointLabel2:UILabel  = {
        let label = UILabel()
        label.text = "请选择电压规格同车辆一致的电池；"
        label.textColor = UIColor(rgba:0x666666FF)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var pointView3:UIView  = {
        let view = UIView()
        view.layer.cornerRadius = 2.5
        view.backgroundColor = UIColor(rgba:0xD2D2D2FF)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var pointLabel3:UILabel  = {
        let label = UILabel()
        label.text = "因电池误选并使用及改装车辆导致的后果由用户自行承担；"
        label.textColor = UIColor(rgba:0x666666FF)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var pointView4:UIView  = {
        let view = UIView()
        view.layer.cornerRadius = 2.5
        view.backgroundColor = UIColor(rgba:0xD2D2D2FF)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var pointLabel4:UILabel  = {
        let label = UILabel()
        label.text = "若电池被盗，或者捡到核蜂动力电池，请及时联系客服。"
        label.textColor = UIColor(rgba:0x666666FF)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with tableView: UITableView) -> UserIntroductionsViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? UserIntroductionsViewCell { return cell }
        return UserIntroductionsViewCell(style: .default, reuseIdentifier: identifier)
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
    }

}

// MARK: - Setup
private extension UserIntroductionsViewCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        contentView.addSubview(containerView)
        containerView.addSubview(headerView)
        headerView.addSubview(headerIconView)
        headerView.addSubview(titleLabel)
        containerView.addSubview(pointView1)
        containerView.addSubview(pointLabel1)
        containerView.addSubview(pointView2)
        containerView.addSubview(pointLabel2)
        containerView.addSubview(pointView3)
        containerView.addSubview(pointLabel3)
        containerView.addSubview(pointView4)
        containerView.addSubview(pointLabel4)


    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 6),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -6),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14)
        ])
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: containerView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: pointLabel1.topAnchor,constant: -9),
            pointView1.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 14),
            pointView1.widthAnchor.constraint(equalToConstant: 5),
            pointView1.heightAnchor.constraint(equalToConstant: 5),
            pointView1.topAnchor.constraint(equalTo: pointLabel1.topAnchor,constant: 7),
            pointLabel1.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 29),
            pointLabel1.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -15),
            pointLabel1.bottomAnchor.constraint(equalTo: pointLabel2.topAnchor, constant: -12),
            pointView2.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 14),
            pointView2.widthAnchor.constraint(equalToConstant: 5),
            pointView2.heightAnchor.constraint(equalToConstant: 5),
            pointView2.topAnchor.constraint(equalTo: pointLabel2.topAnchor,constant: 7),
            pointLabel2.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 29),
            pointLabel2.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -15),
            pointLabel2.bottomAnchor.constraint(equalTo: pointLabel3.topAnchor, constant: -12),
            pointView3.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 14),
            pointView3.widthAnchor.constraint(equalToConstant: 5),
            pointView3.heightAnchor.constraint(equalToConstant: 5),
            pointView3.topAnchor.constraint(equalTo: pointLabel3.topAnchor,constant: 7),
            pointLabel3.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 29),
            pointLabel3.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -15),
            pointLabel3.bottomAnchor.constraint(equalTo: pointLabel4.topAnchor, constant: -12),
            pointView4.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 14),
            pointView4.widthAnchor.constraint(equalToConstant: 5),
            pointView4.heightAnchor.constraint(equalToConstant: 5),
            pointView4.topAnchor.constraint(equalTo: pointLabel4.topAnchor,constant: 7),
            pointLabel4.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 29),
            pointLabel4.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -15),
            pointLabel4.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
        ])
        NSLayoutConstraint.activate([
            headerIconView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor,constant: 10),
            headerIconView.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -8),
            headerIconView.widthAnchor.constraint(equalToConstant: 18),
            headerIconView.heightAnchor.constraint(equalToConstant: 18),
            headerIconView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 12),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -12),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: headerView.trailingAnchor, constant: -14),


        ])
    }
    
}

// MARK: - Public
extension UserIntroductionsViewCell {
    
}

// MARK: - Action
@objc private extension UserIntroductionsViewCell {
    
}

// MARK: - Private
private extension UserIntroductionsViewCell {
    
}
