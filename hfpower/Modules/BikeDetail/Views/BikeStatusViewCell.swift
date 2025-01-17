//
//  BikeStatusViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/8/20.
//

import UIKit
import MapKit

class BikeStatusViewCell: UICollectionViewCell {
    
    // MARK: - Accessor
    var bikeStatus:BikeStatus?{
        didSet{
            let status = bikeStatus?.bikeDetail.status ?? 0
            switch status {
            case 1:
                statusButton.setTitle("未出租", for: .normal)
                statusButton.setTitle("未出租", for: .highlighted)
            case 2:
                statusButton.setTitle("已出租", for: .normal)
                statusButton.setTitle("已出租", for: .highlighted)
            case 3:
                statusButton.setTitle("已过期(未归还)", for: .normal)
                statusButton.setTitle("已过期(未归还)", for: .highlighted)
            case 4:
                statusButton.setTitle("丢失", for: .normal)
                statusButton.setTitle("丢失", for: .highlighted)
            case 5:
                statusButton.setTitle("损坏/报废", for: .normal)
                statusButton.setTitle("损坏/报废", for: .highlighted)
            default:
                statusButton.setTitle("异常/停用", for: .normal)
                statusButton.setTitle("异常/停用", for: .highlighted)
            }
            // 检查是否过期
            let overdue = HFKeyedArchiverTool.pleaseStarTimes(HFKeyedArchiverTool.getCurrentTimes(), andEndTime: bikeStatus?.bikeDetail.locomotiveEndDate ?? "", isDay: false) < 0

            if overdue {
                self.statusButton.setTitle("已过期", for: .normal)
            } else {
                self.statusButton.setTitle("使用中", for: .normal)
            }

            // 创建一个CLLocation对象
            let location = CLLocation(latitude: bikeStatus?.bikeDetail.lastLat?.doubleValue ?? 0, longitude: bikeStatus?.bikeDetail.lastLon?.doubleValue ?? 0)

            // 创建一个CLGeocoder对象
            let geocoder = CLGeocoder()

            // 调用逆地理解析方法
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let error = error {
                    print("逆地理解析错误: \(error.localizedDescription)")
                    return
                }
                
                if let placemarks = placemarks, placemarks.count > 0 {
                    // 获取第一个地标对象
                    if let placemark = placemarks.first {
                        // 打印详细地址信息
                        let address = "\(placemark.name ?? ""), \(placemark.locality ?? ""), \(placemark.administrativeArea ?? ""), \(placemark.country ?? "")"
                        
                        print("解析出的地址: \(address)")
                        self.locationButton.setTitle(address, for: .normal)
                    }
                } else {
                    print("未找到相关地标信息")
                }
            }

        }
    }
    // MARK: - Subviews
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "device_bike")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var statusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintAdjustmentMode = .automatic
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.setTitle("使用中", for: .normal)
        button.setTitle("使用中", for: .highlighted)
        button.setTitleColor(UIColor(hex:0x333333FF), for: .normal)
        button.setTitleColor(UIColor(hex:0x333333FF), for: .highlighted)
        button.setImage(UIColor(hex:0x447AFEFF).circularImage(diameter: 6), for: .normal)
        button.setImage(UIColor(hex:0x447AFEFF).circularImage(diameter: 6), for: .highlighted)
        button.setBackgroundImage(UIColor.white.withAlphaComponent(0.6).toImage(), for: .normal)
        button.setBackgroundImage(UIColor.white.withAlphaComponent(0.6).toImage(), for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16,weight: .medium)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var navigateButton:UIButton = {
        let button = UIButton(type: .custom)
        // 设置按钮的圆角和边框
        button.setTitle("导航", for: .normal)
        button.setTitleColor(UIColor(hex:0x333333FF), for: .normal)
        button.setBackgroundImage(UIColor.white.toImage(), for: .normal)
        button.setImage(UIImage(named: "device_navigate"), for: .normal)
        // 设置按钮的标题字体和大小
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hex:0xE5E6EBFF).cgColor
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var locationButton:UIButton = {
        let button = UIButton(type: .custom)
        // 设置按钮的圆角和边框
        button.tintAdjustmentMode = .automatic
        button.setTitle("李沧区青山路700号", for: .normal)
        button.setTitleColor(UIColor(hex:0x262626FF), for: .normal)
        button.setTitleColor(UIColor(hex:0x262626FF), for: .highlighted)
        button.setImage(UIImage(named: "device_refresh"), for: .normal)
        button.setImage(UIImage(named: "device_refresh"), for: .highlighted)
        // 设置按钮的标题字体和大小
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14,weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with collectionView: UICollectionView, for indexPath: IndexPath) -> BikeStatusViewCell {
        let identifier = cellIdentifier()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? BikeStatusViewCell { return cell }
        return BikeStatusViewCell()
    }
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        locationButton.setImagePosition(type: .imageLeft, Space: 2)
        statusButton.setImagePosition(type: .imageLeft, Space: 9)
    }
}

// MARK: - Setup
private extension BikeStatusViewCell {
    
    private func setupSubviews() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        self.backgroundView = backgroundView

        self.contentView.addSubview(self.logoImageView)
        self.contentView.addSubview(self.statusButton)
        self.contentView.addSubview(self.locationButton)
        self.contentView.addSubview(self.navigateButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            statusButton.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 12),
            statusButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -12),
            statusButton.widthAnchor.constraint(equalToConstant: 90),
            statusButton.heightAnchor.constraint(equalToConstant: 30),
            locationButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor,constant: 20),
            locationButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor,constant: -30),
            navigateButton.leadingAnchor.constraint(equalTo: locationButton.trailingAnchor,constant: 10),
            navigateButton.centerYAnchor.constraint(equalTo: locationButton.centerYAnchor),
            navigateButton.widthAnchor.constraint(equalToConstant: 62),
            navigateButton.heightAnchor.constraint(equalToConstant: 30),


        ])
    }
    
}

// MARK: - Public
extension BikeStatusViewCell {
    
}

// MARK: - Action
@objc private extension BikeStatusViewCell {
    
}

// MARK: - Private
private extension BikeStatusViewCell {
    
}
