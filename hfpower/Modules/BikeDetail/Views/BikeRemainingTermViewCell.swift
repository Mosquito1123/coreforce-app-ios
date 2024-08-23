//
//  BikeRemainingTermViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/8/20.
//

import UIKit



class BikeRemainingTermViewCell: UICollectionViewCell {
    
    // MARK: - Accessor
    var cornerType:BaseCellCornerType = .all{
        didSet{
            switch cornerType {
            case .first:
                self.containerView.layer.cornerRadius = 12
                self.containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            case .last:
                self.containerView.layer.cornerRadius = 12
                self.containerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            case .all:
                self.containerView.layer.cornerRadius = 12
                self.containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            case .none:
                self.containerView.layer.cornerRadius = 0
                
            }
        }
    }
    var element:BikeRemainingTerm?{
        didSet{
            self.titleLabel.text = element?.title
            self.contentLabel.text = element?.content
            self.contentLabel.textColor = element?.overdueOrExpiringSoon == true ? UIColor(rgba: 0xFF2F1DFF):UIColor(rgba: 0x333333FF)
            
        }
    }
    // MARK: - Subviews
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner,.layerMinXMaxYCorner, .layerMaxXMaxYCorner]    
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "剩余租期"
        label.textColor = UIColor(rgba: 0x1D2129FF)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "28天17小时"
        label.textColor = UIColor(rgba: 0x333333FF)
        label.font = UIFont.systemFont(ofSize: 16,weight: .medium)
        label.textAlignment = .right
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var extraLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgba: 0xFF3A3AFF)
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .right
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with collectionView: UICollectionView, for indexPath: IndexPath) -> BikeRemainingTermViewCell {
        let identifier = cellIdentifier()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? BikeRemainingTermViewCell { return cell }
        return BikeRemainingTermViewCell()
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
    
}

// MARK: - Setup
private extension BikeRemainingTermViewCell {
    
    private func setupSubviews() {
        self.contentView.backgroundColor = UIColor(rgba: 0xF7F7F7FF)
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(contentLabel)
        containerView.addSubview(extraLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            // Container view constraints
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 0.5),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 12),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -12),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -0.5),
            
            // Title label constraints
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 14),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -16),
            // Content label constraints
            contentLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            contentLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -14),
            contentLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -16),
            
            extraLabel.trailingAnchor.constraint(equalTo: contentLabel.leadingAnchor, constant: -10),
            extraLabel.centerYAnchor.constraint(equalTo: contentLabel.centerYAnchor),
        ])
    }
    
}


// MARK: - Public
extension BikeRemainingTermViewCell {
    
}

// MARK: - Action
@objc private extension BikeRemainingTermViewCell {
    
}

// MARK: - Private
private extension BikeRemainingTermViewCell {
    
}
