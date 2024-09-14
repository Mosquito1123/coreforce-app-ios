//
//  HFBatteryReturnView.swift
//  hfpower
//
//  Created by EDY on 2024/9/14.
//

import UIKit
import CoreImage

class HFBatteryReturnView: UIView {
    
    var code: String? {
        didSet {
            guard let code = code else { return }
            let filter = CIFilter(name: "CIQRCodeGenerator")
            filter?.setDefaults()
            let data = code.data(using: .utf8)
            filter?.setValue(data, forKey: "inputMessage")
            if let image = filter?.outputImage {
                self.codeImageView.image = createNonInterpolatedUIImage(from: image, withSize: 200)
            }
        }
    }
    
    var opNo: String? {
        didSet {
            guard let opNo = opNo else { return }
            self.hintOne.text = "正在退租..."
            self.codeImageView.isHidden = true
            self.hintTwo.frame = CGRect(x: 20, y: hintOne.frame.maxY + 20, width: self.frame.width - 40, height: 80)
            self.hintTwo.text = "请确认电池与换电柜是否连接良好,或点击确定后稍后确认\n\n或拨打客服电话"
            self.phoneCodeBtn.frame = CGRect(x: 20, y: self.hintTwo.frame.maxY + 10, width: self.frame.width - 40, height: 50)
            self.scanCabintBtn.isHidden = true
            self.phoneCodeBtn.isHidden = false
            self.returnBattery.frame = CGRect(x: 24, y: self.frame.height - 42 - 14, width: (self.frame.width - 48 - 12) / 2, height: 42)
            self.verifyReturn.frame = CGRect(x: self.returnBattery.frame.maxX + 12, y: self.frame.height - 42 - 14, width: (self.frame.width - 48 - 12) / 2, height: 42)
            self.verifyReturn.center.x = self.center.x
            self.verifyReturn.setTitle("确认并重试", for: .normal)
        }
    }
    
    var scanCabintBtnAction: (() -> Void)?
    var returnAction: (() -> Void)?
    var verifyReturnAction: (() -> Void)?
    var scanVerifyReturnAction: (() -> Void)?
    
    lazy var hintOne: UILabel = {
        let label = UILabel()
        configureHintLabel(label, y: 5, text: "请携带电池到运营商处退电")
        return label
    }()
    
    lazy var codeImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: hintOne.frame.maxY + 30, width: 200, height: 200))
        imageView.center.x = self.center.x
        return imageView
    }()
    
    lazy var hintTwo: UILabel = {
        let label = UILabel()
        configureHintLabel(label, y: codeImageView.frame.maxY + 10, text: "或扫描柜子归还电池")
        return label
    }()
    
    lazy var scanCabintBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 24, y: hintTwo.frame.maxY + 10, width: self.frame.width - 48, height: 40)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.setBackgroundImage(UIColor(rgba: 0x447AFEFF).withAlphaComponent(0.5).toImage(), for: .selected)
        button.setBackgroundImage(UIColor(rgba: 0x447AFEFF).toImage(), for: .normal)
        button.setImage(UIImage(named: "scan"), for: .normal)
        button.addTarget(self, action: #selector(scanCabintBtnClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var phoneCodeBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.isHidden = true
        button.setTitle("400-6789-509", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.backgroundColor = UIColor.lightGray
        button.addTarget(self, action: #selector(phoneCodeBtnClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var returnBattery: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 24, y: self.frame.height - 42 - 14, width: (self.frame.width - 48 - 12) / 2, height: 42)
        button.layer.cornerRadius = 21
        button.backgroundColor = UIColor.lightGray
        button.setTitle("取消", for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.addTarget(self, action: #selector(returnBatteryClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var verifyReturn: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: returnBattery.frame.maxX + 12, y: self.frame.height - 42 - 14, width: (self.frame.width - 48 - 12) / 2, height: 42)
        button.layer.cornerRadius = 21
        button.backgroundColor = UIColor(rgba: 0x447AFEFF)
        button.setTitle("确认已归还", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(verifyReturnBatteryClicked), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(hintOne)
        self.addSubview(codeImageView)
        self.addSubview(hintTwo)
        self.addSubview(scanCabintBtn)
        self.addSubview(phoneCodeBtn)
        self.addSubview(returnBattery)
        self.addSubview(verifyReturn)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureHintLabel(_ label: UILabel, y: CGFloat, text: String) {
        label.frame = CGRect(x: 0, y: y, width: self.frame.width, height: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = text
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 15)
    }
    
    @objc private func scanCabintBtnClicked() {
        scanCabintBtnAction?()
    }
    
    @objc private func returnBatteryClicked() {
        returnAction?()
    }
    
    @objc private func verifyReturnBatteryClicked() {
        if let _ = opNo {
            scanVerifyReturnAction?()
        } else {
            verifyReturnAction?()
        }
    }
    
    @objc private func phoneCodeBtnClicked() {
        if let url = URL(string: "tel://400-6789-509") {
            UIApplication.shared.open(url)
        }
    }
    
    private func createNonInterpolatedUIImage(from ciImage: CIImage, withSize size: CGFloat) -> UIImage {
        let extent = ciImage.extent.integral
        let scale = min(size / extent.width, size / extent.height)
        
        let width = Int(extent.width * scale)
        let height = Int(extent.height * scale)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
        let ciContext = CIContext(options: nil)
        guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue),
              let bitmapImage = ciContext.createCGImage(ciImage, from: extent) else {
            return UIImage()
        }
        
        context.interpolationQuality = .none
        context.scaleBy(x: scale, y: scale)
        context.draw(bitmapImage, in: extent)
        
        guard let scaledImage = context.makeImage() else {
            return UIImage()
        }
        
        return UIImage(cgImage: scaledImage)
    }
}
