//
//  FirstContentActivityViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/10/15.
//

import UIKit

class FirstContentActivityViewCell: BaseTableViewCell<FirstContentItem> {
    
    // MARK: - Accessor
    var gradientLayer:CAGradientLayer?
    var containerViewHeight:NSLayoutConstraint!
    var didSelectItemBlock:((_ collectionView: UICollectionView, _ indexPath: IndexPath)->Void)?
    override func configure() {
        self.titleLabel.text = element?.title
        self.items = HFPackageCardModel.mj_objectArray(withKeyValuesArray: (element?.extra as? NSString)?.mj_JSONObject()) as? [HFPackageCardModel] ?? []
//        self.containerViewHeight.constant = calculateCollectionViewHeight(for: self.items, itemHeight: 155, lineSpacing: 10)
    }
    func calculateCollectionViewHeight(for items: [Any], itemHeight: CGFloat, lineSpacing: CGFloat) -> CGFloat {
        let numberOfItemsPerRow = 3  // 每行显示的 item 数量
        let itemsCount = items.count
        
        // 计算行数，向上取整
        let numberOfRows = (itemsCount + numberOfItemsPerRow - 1) / numberOfItemsPerRow
        
        // 计算总高度
        let totalHeight = CGFloat(numberOfRows) * itemHeight + CGFloat(numberOfRows - 1) * lineSpacing + 70
        
        return totalHeight
    }
    var items = [HFPackageCardModel]() {
        didSet {
            collectionView.reloadData()
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
    lazy var  titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: 0x9E501DFF)
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var  collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 12
        layout.itemSize = CGSize.init(width: 114, height: 159)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FirstContentActivityCollectionViewCell.self, forCellWithReuseIdentifier: FirstContentActivityCollectionViewCell.cellIdentifier())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    // MARK: - Static
    override class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    override class func cell(with tableView: UITableView) -> FirstContentActivityViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? FirstContentActivityViewCell { return cell }
        return FirstContentActivityViewCell(style: .default, reuseIdentifier: identifier)
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
        setupLayout()
    }
    private func applyGradientBackground() {
        if let _ = self.gradientLayer{
            return
        }else{
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [UIColor(hex: 0xFFE6D8FF).cgColor, UIColor(hex: 0xF9F3F0FF).cgColor]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
            gradientLayer.cornerRadius = 12
            gradientLayer.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 28))
            containerView.layer.insertSublayer(gradientLayer, at: 0)
            self.gradientLayer = gradientLayer
        }
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        applyGradientBackground()
    }
}
extension FirstContentActivityViewCell:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FirstContentActivityCollectionViewCell.cellIdentifier(), for: indexPath) as? FirstContentActivityCollectionViewCell else {return FirstContentActivityCollectionViewCell()}
        cell.model = self.items[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didSelectItemBlock?(collectionView,indexPath)
    }
    
}
// MARK: - Setup
private extension FirstContentActivityViewCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
        self.backgroundColor = .white
        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(titleLabel)
        self.containerView.addSubview(collectionView)
    }
    
    private func setupLayout() {
        containerViewHeight = containerView.heightAnchor.constraint(equalToConstant: 237)
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
extension FirstContentActivityViewCell {
    
}

// MARK: - Action
@objc private extension FirstContentActivityViewCell {
    
}

// MARK: - Private
private extension FirstContentActivityViewCell {
    
}
