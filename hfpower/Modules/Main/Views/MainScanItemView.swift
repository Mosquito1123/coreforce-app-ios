//
//  MainScanItemView.swift
//  hfpower
//
//  Created by EDY on 2024/5/28.
//

import UIKit
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
class MainScanButton: UIButton {
    
    var type: MainScanItemType = .battery_rent {
        didSet {
            updateUI(for: type)
        }
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
        setupLayout()
    }
    
    // MARK: - Setup
    
    private func setupSubviews() {
        self.frame = CGRect(x: 0.0, y: 0.0, width: 76, height: 76)
        self.layer.cornerRadius = 38
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setTitle("扫码租电", for: .normal)
        setTitle("扫码租电", for: .highlighted)
        
        setImage(UIImage(named: "scan"), for: .normal)
        setImage(UIImage(named: "scan"), for: .highlighted)
        
        setBackgroundImage(UIColor(rgba: 0x22C788FF).toImage(size: CGSize(width: 76, height: 76)), for: .normal)
        setBackgroundImage(UIColor(rgba: 0x22C788FF).toImage(size: CGSize(width: 76, height: 76)), for: .highlighted)
        
        setTitleColor(.white, for: .normal)
        setTitleColor(UIColor.white.withAlphaComponent(0.3), for: .highlighted)
        
        titleLabel?.font = UIFont.systemFont(ofSize: 11)
    }
    
    private func setupLayout() {
        // Add layout setup if needed
    }
    
    private func updateUI(for type: MainScanItemType) {
        switch type {
        case .battery_rent:
            setTitle("扫码租电", for: .normal)
            setTitle("扫码租电", for: .highlighted)
            setBackgroundImage(UIColor(rgba: 0x22C788FF).toImage(size: CGSize(width: 76, height: 76)), for: .normal)
            setBackgroundImage(UIColor(rgba: 0x22C788FF).toImage(size: CGSize(width: 76, height: 76)), for: .highlighted)
        case .battery_change:
            setTitle("扫码换电", for: .normal)
            setTitle("扫码换电", for: .highlighted)
            setBackgroundImage(UIColor(rgba: 0x447AFEFF).toImage(size: CGSize(width: 76, height: 76)), for: .normal)
            setBackgroundImage(UIColor(rgba: 0x447AFEFF).toImage(size: CGSize(width: 76, height: 76)), for: .highlighted)
        case .battery_release:
            setTitle("解除寄存", for: .normal)
            setTitle("解除寄存", for: .highlighted)
            setBackgroundImage(UIColor(rgba: 0xFF8842FF).toImage(size: CGSize(width: 76, height: 76)), for: .normal)
            setBackgroundImage(UIColor(rgba: 0xFF8842FF).toImage(size: CGSize(width: 76, height: 76)), for: .highlighted)
        }
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setImagePosition(type: .imageTop, Space: 4)
        
    }
}

