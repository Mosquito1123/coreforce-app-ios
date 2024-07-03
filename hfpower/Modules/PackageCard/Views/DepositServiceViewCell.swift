//
//  DepositServiceViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/7/1.
//

import UIKit

class DepositServiceViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DepositServiceCollectionCell.cellIdentifier(), for: indexPath) as? DepositServiceCollectionCell else {return UICollectionViewCell()}
        cell.model = self.items[indexPath.row]
        return cell
    }
    
    
    // MARK: - Accessor
    var containerViewHeight:NSLayoutConstraint!
    var items = [DepositService](){
        didSet{
            self.collectionView.reloadData()
        }
    }
    // MARK: - Subviews
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return  view
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "押金服务"
        label.textColor = UIColor(rgba: 0x333333FF)
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var collectionView: UICollectionView = {
        // 初始化 UICollectionViewFlowLayout
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumInteritemSpacing = 10 // 列间距
        collectionViewLayout.minimumLineSpacing = 16 // 行间距
        let itemWidth = (UIScreen.main.bounds.size.width - 28 - 10 - 28) / 2
        collectionViewLayout.itemSize = CGSize(width: itemWidth, height: 80)
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        collectionViewLayout.scrollDirection = .vertical

        // 初始化 UICollectionView
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // 注册 UICollectionView 的 cell
        collectionView.register(DepositServiceCollectionCell.self, forCellWithReuseIdentifier: DepositServiceCollectionCell.cellIdentifier())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
                                                                                            
        return collectionView
    }()
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with tableView: UITableView) -> DepositServiceViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? DepositServiceViewCell { return cell }
        return DepositServiceViewCell(style: .default, reuseIdentifier: identifier)
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Setup
private extension DepositServiceViewCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        self.contentView.addSubview(containerView)
        self.containerView.addSubview(titleLabel)
        self.containerView.addSubview(collectionView)
    }
    
    private func setupLayout() {
        containerViewHeight = containerView.heightAnchor.constraint(equalToConstant: 150)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -14),
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 6),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -6),
            containerViewHeight
        ])
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 14),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -16),
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -16),
        ])

    }
    
}

// MARK: - Public
extension DepositServiceViewCell {
    
}

// MARK: - Action
@objc private extension DepositServiceViewCell {
    
}

// MARK: - Private
private extension DepositServiceViewCell {
    
}
class DepositServiceCollectionCell:UICollectionViewCell{
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with collectionView: UICollectionView,_ indexPath:IndexPath) -> DepositServiceCollectionCell {
        let identifier = cellIdentifier()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? DepositServiceCollectionCell { return cell }
        return DepositServiceCollectionCell()
    }
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "支付押金"
        label.textColor = UIColor(rgba: 0x333333FF)
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var ruleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "退租后、押金可退"
        label.textColor = UIColor(rgba: 0x666666FF)
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "600元"
        label.textColor = UIColor(rgba: 0x666666FF)
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var cornerIconView:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "collection_unselected")

        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    var model: DepositService? {
        didSet {
        }
    }
    
    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder:coder)
    }

    // MARK: - Setup

    private func setupSubviews() {
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1).cgColor
        self.layer.cornerRadius = 6
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.ruleLabel)
        self.contentView.addSubview(self.amountLabel)
        self.contentView.addSubview(self.cornerIconView)

    }
    private func setupLayout(){
        NSLayoutConstraint.activate([
           
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.ruleLabel.topAnchor,constant: -6),
            ruleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            ruleLabel.bottomAnchor.constraint(equalTo: self.amountLabel.topAnchor),
            amountLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            amountLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -11),
            cornerIconView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            cornerIconView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            cornerIconView.widthAnchor.constraint(equalToConstant: 16),
            cornerIconView.heightAnchor.constraint(equalToConstant: 16),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor,constant: -14),
            ruleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor,constant: -14),
            amountLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor,constant: -14),

        ])
    }
    // MARK: - Selection

    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = UIColor(red: 0.19, green: 0.44, blue: 0.94, alpha: 0.0800)
                layer.borderWidth = 1.5
                layer.borderColor = UIColor(red: 0.19, green: 0.44, blue: 0.94, alpha: 1).cgColor
                cornerIconView.image = UIImage(named: "collection_selected")
            } else {
                backgroundColor = .white
                layer.borderWidth = 1
                layer.borderColor = UIColor(red: 0.94, green: 0.94, blue: 0.94, alpha: 1).cgColor
                cornerIconView.image = UIImage(named: "collection_unselected")
            }
        }
    }
}
