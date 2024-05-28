//
//  SearchView.swift
//  hfpower
//
//  Created by EDY on 2024/5/27.
//

import UIKit
typealias GoToNotificationBlock = (_ sender:UIButton)->Void
class SearchView: UIView,UITextFieldDelegate {

    // MARK: - Accessor
    var goToNotificationBlock:GoToNotificationBlock?
    // MARK: - Subviews
    lazy var leftIconView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "search")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var textField:UITextField = {
        let textField = UITextField()
        // 手机号码输入框
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.enablesReturnKeyAutomatically = true
        textField.returnKeyType = .done
        textField.defaultTextAttributes = [.font:UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor(named:"333333") ?? UIColor.black]
        textField.attributedPlaceholder = NSAttributedString(string: "搜索词", attributes: [.font:UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor(named:"A0A0A0") ?? UIColor.black])
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    lazy var rightIconButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "notification"), for: .normal)
        button.setImage(UIImage(named: "notification"), for: .highlighted)
        button.addTarget(self, action: #selector(goToNotificationsView(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 22
        self.layer.masksToBounds = true
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Setup
private extension SearchView {
    
    private func setupSubviews() {
        addSubview(leftIconView)
        addSubview(textField)
        addSubview(rightIconButton)

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            leftIconView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 18.5),
            leftIconView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            leftIconView.widthAnchor.constraint(equalToConstant: 15),
            leftIconView.heightAnchor.constraint(equalToConstant: 15),
            leftIconView.trailingAnchor.constraint(equalTo: textField.leadingAnchor,constant: -7.5),
            textField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textField.trailingAnchor.constraint(equalTo: rightIconButton.leadingAnchor,constant: -7.5),
            rightIconButton.widthAnchor.constraint(equalToConstant: 17),
            rightIconButton.heightAnchor.constraint(equalToConstant: 17),
            rightIconButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            rightIconButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -17.5),
        ])
    }
    
}

// MARK: - Public
extension SearchView {
    
}

// MARK: - Action
@objc private extension SearchView {
    @objc func goToNotificationsView(_ sender:UIButton){
        self.goToNotificationBlock?(sender)
    }
}

// MARK: - Private
private extension SearchView {
    
}
