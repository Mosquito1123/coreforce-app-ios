//
//  SearchView.swift
//  hfpower
//
//  Created by EDY on 2024/5/27.
//

import UIKit
typealias GoToNotificationBlock = (_ sender:UIButton)->Void
typealias GoToCustomerServiceBlock = (_ sender:UIButton)->Void
typealias GoToSearchServiceBlock = (_ sender:UITextField)->Void
class SearchView: UIView {

    // MARK: - Accessor
    var searchIconImage:UIImage?{
        didSet{
            leftIconView.image = searchIconImage
        }
    }
    var showRightView:Bool?{
        didSet{
            rightIconButton.isHidden = showRightView == false
            customerServiceIconButton.isHidden = showRightView == false
        }
    }
   
    var goToSearchServiceBlock:GoToSearchServiceBlock?
    var goToNotificationBlock:GoToNotificationBlock?
    var goToCustomerServiceBlock:GoToCustomerServiceBlock?
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
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    lazy var customerServiceIconButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "customer_service")?.resized(toSize: CGSize(width: 20, height: 20)), for: .normal)
        button.setImage(UIImage(named: "customer_service")?.resized(toSize: CGSize(width: 20, height: 20)), for: .highlighted)
        button.addTarget(self, action: #selector(goToCustomerServiceView(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var rightIconButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "notification")?.resized(toSize: CGSize(width: 20, height: 20)), for: .normal)
        button.setImage(UIImage(named: "notification")?.resized(toSize: CGSize(width: 20, height: 20)), for: .highlighted)
        button.addTarget(self, action: #selector(goToNotificationsView(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 22
        self.layer.shadowColor = UIColor(red: 0.39, green: 0.47, blue: 0.67, alpha: 0.06).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 20
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
        addSubview(customerServiceIconButton)
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
            textField.trailingAnchor.constraint(equalTo: customerServiceIconButton.leadingAnchor,constant: -7.5),
            customerServiceIconButton.widthAnchor.constraint(equalToConstant: 20),
            customerServiceIconButton.heightAnchor.constraint(equalToConstant: 20),
            customerServiceIconButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            customerServiceIconButton.trailingAnchor.constraint(equalTo: self.rightIconButton.leadingAnchor,constant: -22.5),

            rightIconButton.widthAnchor.constraint(equalToConstant: 20),
            rightIconButton.heightAnchor.constraint(equalToConstant: 20),
            rightIconButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            rightIconButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -17.5),
        ])
    }
    
}

// MARK: - Public
extension SearchView:UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard let goToSearchServiceBlock = self.goToSearchServiceBlock else {return true}
        goToSearchServiceBlock(textField)
        return false
    }
}

// MARK: - Action
@objc private extension SearchView {
    @objc func goToNotificationsView(_ sender:UIButton){
        self.goToNotificationBlock?(sender)
    }
    @objc func goToCustomerServiceView(_ sender:UIButton){
        self.goToCustomerServiceBlock?(sender)
    }
}

// MARK: - Private
private extension SearchView {
    
}
