//
//  PersonalContentViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/6/24.
//

import UIKit

class PersonalContentViewCell: UITableViewCell {
    
    // MARK: - Accessor
    var tapped:((UITapGestureRecognizer) -> Void)?
    var bottomMargin:NSLayoutConstraint!
    // MARK: - Subviews
    lazy var mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor(hex:0x4D4D4DFF)
        titleLabel.font = UIFont.systemFont(ofSize: 16,weight: .medium)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "small_detail_icon")
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with tableView: UITableView) -> PersonalContentViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? PersonalContentViewCell { return cell }
        return PersonalContentViewCell(style: .default, reuseIdentifier: identifier)
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
    
}

// MARK: - Setup
private extension PersonalContentViewCell {
    
    private func setupSubviews() {
        self.contentView.addSubview(self.mainView)
        self.mainView.addSubview(self.titleLabel)
        self.mainView.addSubview(self.iconImageView)
        self.mainView.addSubview(self.stackView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
        self.iconImageView.isUserInteractionEnabled = true
        self.iconImageView.addGestureRecognizer(tap)
    }
    
    private func setupLayout() {
        bottomMargin = self.mainView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -8)
        NSLayoutConstraint.activate([
            self.mainView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 12),
            self.mainView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 8),
            bottomMargin,
            self.mainView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -12),
            
        ])
        NSLayoutConstraint.activate([
            self.titleLabel.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 14),
            self.titleLabel.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 16),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.stackView.topAnchor, constant: -13),
            self.stackView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 14),
            self.stackView.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -14),
            self.stackView.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: -14),
            self.iconImageView.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor,constant: 3),
            self.iconImageView.bottomAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,constant: -5),
            self.iconImageView.widthAnchor.constraint(equalToConstant: 18),
            self.iconImageView.heightAnchor.constraint(equalToConstant: 18),

        ])
    }
    
}

// MARK: - Public
extension PersonalContentViewCell {
    
}

// MARK: - Action
@objc private extension PersonalContentViewCell {
    @objc func tapAction(_ sender: UITapGestureRecognizer) {
        self.tapped?(sender)
    }
}

// MARK: - Private
private extension PersonalContentViewCell {
    
}
