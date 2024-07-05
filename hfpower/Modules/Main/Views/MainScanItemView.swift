//
//  MainScanItemView.swift
//  hfpower
//
//  Created by EDY on 2024/5/28.
//

import UIKit
import ESTabBarController_swift
enum MainScanItemType:Int {
    case battery_rent
    case battery_change
    case battery_release
    
}
extension MainScanItemType {
    func getValue() -> String {
        switch self {
        case .battery_rent:
            return "扫码租电"
        case .battery_change:
            return "扫码换电"
        case .battery_release:
            return "解除寄存"
       
        }
    }
    func getColorValue() -> String {
        switch self {
        case .battery_rent:
            return "22C788"
        case .battery_change:
            return "447AFE"
        case .battery_release:
            return "FF8842"
       
        }
    }
}
class MainScanItemView: ESTabBarItemContentView {

    // MARK: - Accessor
    var mainScanItemType:MainScanItemType? = .battery_rent{
        didSet{
            scanButton.setTitle(mainScanItemType?.getValue(), for: .normal)
            scanButton.setTitle(mainScanItemType?.getValue(), for: .highlighted)
            scanButton.setBackgroundImage(UIColor(named: mainScanItemType?.getColorValue()  ?? "22C788")?.toImage(), for: .normal)
            scanButton.setBackgroundImage(UIColor(named: mainScanItemType?.getColorValue()  ?? "22C788")?.withAlphaComponent(0.3).toImage(), for: .highlighted)

        }
        
    }
    // MARK: - Subviews
    lazy var mainView:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 97.0/2
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var scanButton:UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 76, height: 76)
        button.tintAdjustmentMode = .automatic
        button.setTitle("扫码租电", for: .normal)
        button.setTitle("扫码租电", for: .highlighted)

        button.setImage(UIImage(named: "scan"), for: .normal)
        button.setImage(UIImage(named: "scan"), for: .highlighted)

        button.setBackgroundImage(UIColor(rgba:0x22C788FF).toImage(), for: .normal)
        button.setBackgroundImage(UIColor(rgba:0x22C788FF).withAlphaComponent(0.3).toImage(), for: .highlighted)

        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.white.withAlphaComponent(0.3), for: .highlighted)

        button.layer.cornerRadius = 38
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.insets = UIEdgeInsets.init(top: -32, left: 0, bottom: 0, right: 0)

        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        scanButton.setImagePosition(type: .imageTop, Space: 4)

    }
}

// MARK: - Setup
private extension MainScanItemView {
    
    private func setupSubviews() {
        addSubview(mainView)
        addSubview(scanButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            mainView.widthAnchor.constraint(equalToConstant: 97),
            mainView.heightAnchor.constraint(equalToConstant: 97),
            mainView.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: 11),
            mainView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            scanButton.widthAnchor.constraint(equalToConstant: 76),
            scanButton.heightAnchor.constraint(equalToConstant: 76),
            scanButton.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: 11),
            scanButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
        

    }
    
}

// MARK: - Public
extension MainScanItemView {
    
}

// MARK: - Action
@objc private extension MainScanItemView {
    
}

// MARK: - Private
private extension MainScanItemView {
    
}
