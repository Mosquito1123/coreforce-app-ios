//
//  DepositManagementTableFooterView.swift
//  hfpower
//
//  Created by EDY on 2024/8/15.
//

import UIKit

class DepositManagementTableFooterView: UIView {

    // MARK: - Accessor
    
    // MARK: - Subviews
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgba: 0xF7F7F7FF)
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var headerView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgba: 0xF7F7F7FF)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var headerIconView:UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "deposit_warning")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "押金必读"
        label.textColor = UIColor(rgba:0x1D2129FF)
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
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
        label.text = "若您有租赁中的车辆或电池，则押金无法退回，请先退租电池或车辆再尝试取回押金。"
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
        label.text = "若您使用支付宝预授权支付押金，则退押相当于释放支付宝预授权冻结的金额，请至支付宝账单查看解冻情况。"
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
        label.text = "若您在使用过程中发生了逾期、损坏设备、丢失设备等情况，则产生的相关费用将在押金中扣除。"
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
        label.text = "押金将在您提出退回申请的48小时之内原路返回。"
        label.textColor = UIColor(rgba:0x666666FF)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Setup
private extension DepositManagementTableFooterView {
    
    private func setupSubviews() {
        addSubview(containerView)
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
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            containerView.topAnchor.constraint(equalTo: topAnchor,constant: 24),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -6),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14)
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
extension DepositManagementTableFooterView {
    
}

// MARK: - Action
@objc private extension DepositManagementTableFooterView {
    
}

// MARK: - Private
private extension DepositManagementTableFooterView {
    
}
