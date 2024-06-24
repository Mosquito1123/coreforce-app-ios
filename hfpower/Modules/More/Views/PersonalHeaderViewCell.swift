//
//  PersonalHeaderViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/6/24.
//

import UIKit

class PersonalHeaderViewCell: UITableViewCell {
    
    // MARK: - Accessor
    var settingsAction:ButtonActionBlock?
    // MARK: - Subviews
    lazy var settingsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "settings"), for: .normal)
        button.setImage(UIImage(named: "settings"), for: .highlighted)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)

        button.tintAdjustmentMode = .automatic
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var titleLabel: CopyableLabel = {
        let label = CopyableLabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = UIColor(named: "333333")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var subTitleLabel: CopyableLabel = {
        let label = CopyableLabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(named: "666666")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var cornerBackgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "corner_bg")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var authorityButton: VerificationButton = {
        let button = VerificationButton(type: .custom)
        button.isVerified = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var headerImageView: CircularImageView = {
        let circularImageView = CircularImageView(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        circularImageView.translatesAutoresizingMaskIntoConstraints = false
        return circularImageView
    }()
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with tableView: UITableView) -> PersonalHeaderViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? PersonalHeaderViewCell { return cell }
        return PersonalHeaderViewCell(style: .default, reuseIdentifier: identifier)
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
      
        
    }

}

// MARK: - Setup
private extension PersonalHeaderViewCell {
    
    private func setupSubviews() {
        contentView.addSubview(cornerBackgroundView)
        contentView.addSubview(headerImageView)
        contentView.addSubview(authorityButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(settingsButton)

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
        
        ])
    }
    
}

// MARK: - Public
extension PersonalHeaderViewCell {
    
}

// MARK: - Action
@objc private extension PersonalHeaderViewCell {
    @objc func buttonTapped(_ sender:UIButton){
        self.settingsAction?(sender)
    }
}

// MARK: - Private
private extension PersonalHeaderViewCell {
    
}

class CircularImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        // 设置控件大小
        self.frame.size = CGSize(width: 64, height: 64)
        
        // 设置圆形边框
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.borderWidth = 2.5
        self.layer.borderColor = UIColor.white.cgColor
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}
class CopyableLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLongPressGesture()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLongPressGesture()
    }

    private func setupLongPressGesture() {
        isUserInteractionEnabled = true
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(showMenu))
        addGestureRecognizer(longPressGesture)
    }

    @objc private func showMenu() {
        becomeFirstResponder()
        
        let menu = UIMenuController.shared
        if !menu.isMenuVisible {
            if #available(iOS 13.0, *) {
                menu.showMenu(from: self, rect: bounds)
            } else {
                menu.setTargetRect(bounds, in: self)
                menu.setMenuVisible(true, animated: true)
            }
        }
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(copy(_:))
    }

    override func copy(_ sender: Any?) {
        UIPasteboard.general.string = text
    }
}
class VerificationButton: UIButton {

    var isVerified: Bool = false {
        didSet {
            updateAppearance()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    private func setupButton() {
        layer.cornerRadius = 2
        titleLabel?.font = UIFont.systemFont(ofSize: 9, weight: .medium)
        self.tintAdjustmentMode = .automatic
        setTitleColor(.white, for: .normal)
        setTitleColor(.white, for: .highlighted)
        setImage(UIImage(named: "authority"), for: .normal)
        setImage(UIImage(named: "authority"), for: .highlighted)

        updateAppearance()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setImagePosition(type: .imageLeft, Space: 1)
    }
    private func updateAppearance() {
        if isVerified {
            setBackgroundImage(UIColor(named: "447AFE")?.toImage(), for: .normal)
            setTitle("已实名认证", for: .normal)
        } else {
            setBackgroundImage(UIColor(named: "FE9044")?.toImage(), for: .normal)
            setTitle("未实名认证", for: .normal)
        }
    }
}
