//
//  NeedAuthView.swift
//  hfpower
//
//  Created by EDY on 2024/5/28.
//

import UIKit
typealias AuthAction = (_ sender:UIButton) -> Void

class NeedAuthView: UIView {

    // MARK: - Accessor
    var authAction:AuthAction?

    // MARK: - Subviews
    lazy var iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.image = UIImage(named: "horn")
        iconView.translatesAutoresizingMaskIntoConstraints = false
        return iconView
    }()
    lazy var titleLabel:UILabel={
        let label = UILabel()
        label.text = "实名认证体验更多服务"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor(named: "333333")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var actionButton:UIButton = {
        let actionButton = UIButton(type:.custom)
        actionButton.setTitle("立即实名", for: .normal)
        actionButton.setTitle("立即实名", for: .highlighted)
     
        actionButton.setTitleColor(UIColor.white, for: .normal)
        actionButton.setTitleColor(UIColor.white, for: .highlighted)
        let imageEnabled = image(from: UIColor(named: "447AFE") ?? .blue)
        let imageDisabled = image(from: UIColor(named: "447AFE 20") ?? .blue)
        actionButton.setBackgroundImage(imageEnabled, for: .normal)
        actionButton.setBackgroundImage(imageDisabled, for: .disabled)

        actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        actionButton.layer.cornerRadius = 15
        actionButton.layer.masksToBounds = true
        actionButton.addTarget(self, action: #selector(authAction(_:)), for: .touchUpInside)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        return actionButton
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 10
        // shadowCode
        self.layer.shadowColor = UIColor(red: 0.39, green: 0.47, blue: 0.67, alpha: 0.3).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 10
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Setup
private extension NeedAuthView {
    
    private func setupSubviews() {
        addSubview(iconView)
        addSubview(titleLabel)
        addSubview(actionButton)

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 14),
            iconView.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            iconView.widthAnchor.constraint(equalToConstant: 15),
            iconView.heightAnchor.constraint(equalToConstant: 15),

            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor,constant: 8),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            actionButton.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor,constant: 8),
            actionButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -14),
            actionButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 30),
            actionButton.widthAnchor.constraint(equalToConstant: 100),

            self.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
}

// MARK: - Public
extension NeedAuthView {
    
}

// MARK: - Action
@objc private extension NeedAuthView {
    @objc func authAction(_ sender:UIButton){
        self.authAction?(sender)
    }
}

// MARK: - Private
private extension NeedAuthView {
    func image(from color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        // 创建一个图形上下文
        let renderer = UIGraphicsImageRenderer(size: size)
        
        // 使用图形上下文渲染图像
        let image = renderer.image { context in
            // 设置绘图颜色
            context.cgContext.setFillColor(color.cgColor)
            
            // 绘制一个矩形填充整个图形上下文
            context.cgContext.fill(CGRect(origin: .zero, size: size))
        }
        
        return image
    }
}
