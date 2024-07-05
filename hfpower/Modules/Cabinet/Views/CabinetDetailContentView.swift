//
//  CabinetDetailContentView.swift
//  hfpower
//
//  Created by EDY on 2024/6/20.
//

import UIKit
import DGCharts
class CabinetDetailContentView: UIView {

    // MARK: - Accessor
    var navigateAction:ButtonActionBlock?
    // MARK: - Subviews
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "金海牛能源环境产业园A座"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(rgba:0x262626FF)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
  
  
    lazy var businessTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "营业时间：24h"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(rgba:0x999999FF)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var rideLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "100m · 骑行1分钟"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(rgba:0x333333FF)
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
        label.textColor = UIColor(rgba:0x999999FF)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var rentStatusButton:UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.setTitle("可租赁", for: .normal)
        button.setTitleColor(UIColor(rgba:0x165DFFFF), for: .normal)
        button.backgroundColor = UIColor(rgba:0x165DFFFF).withAlphaComponent(0.1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var depositStatusButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("可寄存", for: .normal)
        button.setTitleColor(UIColor(rgba:0xFF7D00FF), for: .normal)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor(rgba:0xFFF7E8FF)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var navigateButton:UIButton = {
        let button = UIButton(type: .custom)
        // 设置按钮的圆角和边框
        button.tintAdjustmentMode = .automatic
        button.setTitle("导航", for: .normal)
        button.setTitleColor(UIColor(rgba:0x447AFEFF), for: .normal)
        button.setImage(UIImage(named: "cabinet_navigate"),for: .normal)
        button.setImage(UIImage(named: "cabinet_navigate"),for: .highlighted)


        // 设置按钮的标题字体和大小
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12,weight: .regular)

        button.addTarget(self, action: #selector(navigateButtonAction(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var cabinetNumberView: CabinetNumberView = {
        let cabinetNumberView = CabinetNumberView()
        cabinetNumberView.translatesAutoresizingMaskIntoConstraints = false
        return cabinetNumberView
    }()
    lazy var statisticView: CabinetStatisticView = {
        let view = CabinetStatisticView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var chartView: ChartMainView = {
        let chartView = ChartMainView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        return chartView
    }()
    lazy var topLineView:UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(rgba:0xEDEDEDFF)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(rgba:0xF7F7F7FF)
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor, UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor, UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1).cgColor]
        bgLayer1.locations = [0, 0.62, 1]
        bgLayer1.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 136.5)
//        bgLayer1.startPoint = CGPoint(x: 0, y: 0)
//        bgLayer1.endPoint = CGPoint(x: 1, y: 1)
        self.layer.insertSublayer(bgLayer1, at: 0)
        navigateButton.setImagePosition(type: .imageTop, Space: 6)
       
    }
}

// MARK: - Setup
private extension CabinetDetailContentView {
    
    private func setupSubviews() {

        // fillCode
   
        addSubview(titleLabel)
        addSubview(businessTimeLabel)
        addSubview(topLineView)
        addSubview(depositStatusButton)
        addSubview(rentStatusButton)
        addSubview(rideLabel)
        addSubview(locationImageView)
        addSubview(locationLabel)
        addSubview(cabinetNumberView)
        addSubview(statisticView)
        statisticView.showTop = true
        addSubview(navigateButton)
        addSubview(chartView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 16),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 16),
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
            topLineView.topAnchor.constraint(equalTo: self.businessTimeLabel.bottomAnchor, constant: 21),
            topLineView.heightAnchor.constraint(equalToConstant: 0.5),
            
            rideLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            rideLabel.topAnchor.constraint(equalTo: topLineView.bottomAnchor, constant: 10),
            rideLabel.bottomAnchor.constraint(equalTo: locationLabel.topAnchor, constant: -4),
            locationImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            locationImageView.bottomAnchor.constraint(equalTo: cabinetNumberView.topAnchor, constant: -14),
            locationImageView.widthAnchor.constraint(equalToConstant: 14),
            locationImageView.heightAnchor.constraint(equalToConstant: 14),

            locationLabel.leadingAnchor.constraint(equalTo: self.locationImageView.trailingAnchor, constant: 3),
            locationLabel.bottomAnchor.constraint(equalTo: cabinetNumberView.topAnchor, constant: -14),
            cabinetNumberView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            cabinetNumberView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            cabinetNumberView.bottomAnchor.constraint(equalTo: statisticView.topAnchor, constant: -12),
            
            
            
            statisticView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            statisticView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statisticView.bottomAnchor.constraint(equalTo: chartView.topAnchor, constant: -12),
            statisticView.heightAnchor.constraint(equalToConstant: 146),

            navigateButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            navigateButton.topAnchor.constraint(equalTo: self.topAnchor,constant: 14),
            navigateButton.widthAnchor.constraint(equalToConstant: 39),
            navigateButton.heightAnchor.constraint(equalToConstant: 62),
            chartView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            chartView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
//            chartView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -20-100),
            chartView.heightAnchor.constraint(equalToConstant: 240),


        ])
    }
    
}

// MARK: - Public
extension CabinetDetailContentView {
    
}

// MARK: - Action
@objc private extension CabinetDetailContentView {
    @objc func navigateButtonAction(_ sender:UIButton){
        self.navigateAction?(sender)
    }
}

// MARK: - Private
private extension CabinetDetailContentView {
    
}
