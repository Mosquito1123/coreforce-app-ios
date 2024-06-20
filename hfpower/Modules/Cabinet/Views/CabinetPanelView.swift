//
//  CabinetPanelView.swift
//  hfpower
//
//  Created by EDY on 2024/6/19.
//

import UIKit

class CabinetPanelView: UIView {

    // MARK: - Accessor
    var cabinet:CabinetSummary?{
        didSet{
            
        }
    }
    var navigateAction:ButtonActionBlock?
    var scanAction:ButtonActionBlock?
    var dropDownAction:ButtonActionBlock?
    var detailAction:ButtonActionBlock?
    // MARK: - Subviews
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "金海牛能源环境产业园A座"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(named: "262626")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var dropDownButton:UIButton = {
        let button = UIButton(type:.custom)
        button.setImage(UIImage(named: "drop_down"), for: .normal)
        button.setImage(UIImage(named: "drop_down"), for: .selected)
        button.addTarget(self, action: #selector(dropDownButtonAction(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var detailButton: UIButton = {
        let button = UIButton(type:.custom)
        button.setImage(UIImage(named: "icon_arrow_right"), for: .normal)
        button.setTitle("详情", for: .normal)
        button.setTitleColor(UIColor(named: "447AFE"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        button.addTarget(self, action: #selector(detailButtonAction(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var businessTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "营业时间：24h"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(named: "999999")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var rideLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "100m · 骑行1分钟"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(named: "333333")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var locationImageView: UIImageView = {
        let locationImageView = UIImageView()
        locationImageView.image = UIImage(named: "search_list_icon_location")
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        return locationImageView
    }()
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "李沧区青山路700号"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(named: "999999")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var rentStatusButton:UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.setTitle("可租赁", for: .normal)
        button.setTitleColor(UIColor(named: "165DFF"), for: .normal)
        button.backgroundColor = UIColor(named: "165DFF 10")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var depositStatusButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("可寄存", for: .normal)
        button.setTitleColor(UIColor(named: "FF7D00"), for: .normal)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor(named: "FFF7E8")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var navigateButton:UIButton = {
        let button = UIButton(type: .custom)
        // 设置按钮的圆角和边框
        button.setTitle("导航", for: .normal)
        button.setTitleColor(UIColor(named: "1D2129"), for: .normal)
        button.setBackgroundImage(UIColor.white.toImage(), for: .normal)
        button.setBackgroundImage(UIColor.white.toImage(), for: .highlighted)

        // 设置按钮的标题字体和大小
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15,weight: .medium)
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "E5E6EB")?.cgColor
        button.addTarget(self, action: #selector(navigateButtonAction(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var scanButton:UIButton = {
        let button = UIButton(type: .custom)
        // 设置按钮的圆角和边框
        button.setTitle("扫码换电", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setBackgroundImage(UIColor(named: "447AFE")?.toImage(), for: .normal)
        button.setBackgroundImage(UIColor(named: "447AFE")?.toImage(), for: .highlighted)

        // 设置按钮的标题字体和大小
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15,weight: .medium)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(scanButtonAction(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var statisticView: CabinetStatisticView = {
        let view = CabinetStatisticView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var lineView:UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(named: "F7F7F7")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var topLineView:UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(named: "EDEDED")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        navigateButton.setImagePosition(type: .imageLeft, Space: 5)
        detailButton.setImagePosition(type: .imageRight, Space: 6)
       
    }
}

// MARK: - Setup
private extension CabinetPanelView {
    
    private func setupSubviews() {
        addSubview(titleLabel)
        addSubview(dropDownButton)
        addSubview(detailButton)
        addSubview(businessTimeLabel)
        addSubview(topLineView)
        addSubview(depositStatusButton)
        addSubview(rentStatusButton)
        addSubview(rideLabel)
        addSubview(locationImageView)
        addSubview(locationLabel)
        addSubview(statisticView)
        addSubview(navigateButton)
        addSubview(lineView)
        addSubview(scanButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 16),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 16),
            dropDownButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -16),
            dropDownButton.topAnchor.constraint(equalTo: self.topAnchor,constant: 16),
            dropDownButton.widthAnchor.constraint(equalToConstant: 18),
            dropDownButton.heightAnchor.constraint(equalToConstant: 18),
            detailButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -16),
            detailButton.centerYAnchor.constraint(equalTo: businessTimeLabel.centerYAnchor),
            detailButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16),
            businessTimeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            businessTimeLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5.5),
            businessTimeLabel.trailingAnchor.constraint(equalTo:rentStatusButton.leadingAnchor, constant: -14),
            rentStatusButton.centerYAnchor.constraint(equalTo: businessTimeLabel.centerYAnchor),
            rentStatusButton.widthAnchor.constraint(equalToConstant: 41),
            rentStatusButton.heightAnchor.constraint(equalToConstant: 20),

            depositStatusButton.centerYAnchor.constraint(equalTo: businessTimeLabel.centerYAnchor),
            depositStatusButton.widthAnchor.constraint(equalToConstant: 41),
            depositStatusButton.heightAnchor.constraint(equalToConstant: 20),
            rentStatusButton.trailingAnchor.constraint(equalTo: depositStatusButton.leadingAnchor,constant: -6),
            topLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            topLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            topLineView.topAnchor.constraint(equalTo: self.businessTimeLabel.bottomAnchor, constant: 13),
            topLineView.heightAnchor.constraint(equalToConstant: 0.5),
            
            rideLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            rideLabel.topAnchor.constraint(equalTo: topLineView.bottomAnchor, constant: 10),
            rideLabel.bottomAnchor.constraint(equalTo: locationLabel.topAnchor, constant: -4),
            locationImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            locationImageView.bottomAnchor.constraint(equalTo: statisticView.topAnchor, constant: -14),
            locationImageView.widthAnchor.constraint(equalToConstant: 14),
            locationImageView.heightAnchor.constraint(equalToConstant: 14),

            locationLabel.leadingAnchor.constraint(equalTo: self.locationImageView.trailingAnchor, constant: 3),
            locationLabel.bottomAnchor.constraint(equalTo: statisticView.topAnchor, constant: -14),
            
            
            
            
            statisticView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            statisticView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statisticView.bottomAnchor.constraint(equalTo: navigateButton.topAnchor, constant: -14),
            statisticView.heightAnchor.constraint(equalToConstant: 160),



            lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 10),

            navigateButton.widthAnchor.constraint(equalToConstant: 165),
            navigateButton.heightAnchor.constraint(equalToConstant: 50),
            navigateButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            scanButton.widthAnchor.constraint(equalToConstant: 165),
            scanButton.heightAnchor.constraint(equalToConstant: 50),
            scanButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            scanButton.centerYAnchor.constraint(equalTo: navigateButton.centerYAnchor),


        ])
    }
    
}

// MARK: - Public
extension CabinetPanelView {
    
}

// MARK: - Action
@objc private extension CabinetPanelView {
    @objc func dropDownButtonAction(_ sender:UIButton){
        self.dropDownAction?(sender)
    }
    @objc func navigateButtonAction(_ sender:UIButton){
        self.navigateAction?(sender)
    }
    @objc func scanButtonAction(_ sender:UIButton){
        self.scanAction?(sender)
    }
    @objc func detailButtonAction(_ sender:UIButton){
        self.detailAction?(sender)
    }
}

// MARK: - Private
private extension CabinetPanelView {
    
}
