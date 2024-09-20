//
//  CommonInputView.swift
//  hfpower
//
//  Created by EDY on 2024/8/16.
//

import UIKit

class CommonInputView: UIView {

    // MARK: - Accessor
    var placeholder:String?{
        didSet{
            textField.attributedPlaceholder = NSAttributedString(string: placeholder ?? "请输入优惠券码", attributes: [.font:UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor(hex:0x86909CFF)])

        }
    }
    // MARK: - Subviews
    lazy var textField :UITextField = {
        let textField = UITextField()
        // 手机号码输入框
        textField.borderStyle = .none
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.enablesReturnKeyAutomatically = true
        textField.returnKeyType = .done
        textField.defaultTextAttributes = [.font:UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor(hex:0x333333FF)]
        textField.attributedPlaceholder = NSAttributedString(string: "请输入优惠券码", attributes: [.font:UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor(hex:0x86909CFF)])
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
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
private extension CommonInputView {
    
    private func setupSubviews() {
        self.backgroundColor = UIColor(hex:0xF7F8FAFF)
        self.layer.cornerRadius = 22
        self.addSubview(self.textField)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20),
            textField.centerYAnchor.constraint(equalTo:self.centerYAnchor),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20),
            
        ])
    }
    
}

// MARK: - Public
extension CommonInputView:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.layer.borderColor = UIColor(hex:0x3171EFFF).cgColor
        self.layer.borderWidth = 1.5
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.borderWidth = 0

    }
}

// MARK: - Action
@objc private extension CommonInputView {
    
}

// MARK: - Private
private extension CommonInputView {
    
}
