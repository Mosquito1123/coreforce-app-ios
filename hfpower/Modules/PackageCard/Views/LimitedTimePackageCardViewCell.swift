//
//  LimitedTimePackageCardViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/7/10.
//

import UIKit

class LimitedTimePackageCardViewCell: BaseTableViewCell<BuyPackageCard>,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BuyPackageCardPlanCell.cellIdentifier(), for: indexPath) as? BuyPackageCardPlanCell else {return UICollectionViewCell()}
        cell.model = self.items[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 找到之前被选中的 item
        var previouslySelectedIndex: IndexPath?
        
        // 遍历 items 找到已选中的 item，并记录它的 index
        for i in 0..<self.items.count {
            if self.items[i].selected == NSNumber(value: true) {
                previouslySelectedIndex = IndexPath(item: i, section: 0)
                self.items[i].selected = NSNumber(value: false) // 取消选中
                break
            }
        }
        
        // 设置当前点击的 item 为选中
        self.items[indexPath.item].selected = NSNumber(value: true)
        
        // 准备需要刷新的 indexPaths 数组
        var indexPathsToReload: [IndexPath] = []
        
        // 如果之前有选中的 item，添加它的 indexPath 进行刷新
        if let previousIndex = previouslySelectedIndex {
            indexPathsToReload.append(previousIndex)
        }
        
        // 添加当前选中的 item 进行刷新
        indexPathsToReload.append(indexPath)
        
        // 仅刷新需要更新的 cell
        collectionView.reloadItems(at: indexPathsToReload)
        self.didSelectItemBlock?(collectionView,indexPath)
    }
    func cancelAllSelected(){
        var previouslySelectedIndex: IndexPath?
        
        // 遍历 items 找到已选中的 item，并记录它的 index
        for i in 0..<self.items.count {
            if self.items[i].selected == NSNumber(value: true) {
                previouslySelectedIndex = IndexPath(item: i, section: 0)
                self.items[i].selected = NSNumber(value: false) // 取消选中
                break
            }
        }
        var indexPathsToReload: [IndexPath] = []
        
        // 如果之前有选中的 item，添加它的 indexPath 进行刷新
        if let previousIndex = previouslySelectedIndex {
            indexPathsToReload.append(previousIndex)
        }
        // 仅刷新需要更新的 cell
        collectionView.reloadItems(at: indexPathsToReload)
    }
    // MARK: - Accessor
    override func configure() {
        self.headerLabel.text = element?.title
        self.items = (element?.items ?? [HFPackageCardModel]()).map({ model in
            let modelx = model
            modelx.cellType = NSNumber(integerLiteral: 1)
            return modelx
        })

        self.containerViewHeight.constant = calculateCollectionViewHeight(for: self.items, itemHeight: 155, lineSpacing: 10)
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
    var containerViewHeight:NSLayoutConstraint!
    var items = [HFPackageCardModel](){
        didSet{
            self.collectionView.reloadData()
        }
    }
    var didSelectItemBlock:((_ collectionView: UICollectionView, _ indexPath: IndexPath)->Void)?
    // MARK: - Subviews
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return  view
    }()
    lazy var headerIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "limited_time_icon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var headerBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "limited_time_background")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var headerLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor(rgba: 0x724A17FF)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var collectionView: UICollectionView = {
        // 初始化 UICollectionViewFlowLayout
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumInteritemSpacing = 10 // 列间距
        collectionViewLayout.minimumLineSpacing = 16 // 行间距
        let itemWidth = (UIScreen.main.bounds.size.width - 28 - 20 - 28) / 3
        collectionViewLayout.itemSize = CGSize(width: itemWidth, height: 150)
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        collectionViewLayout.scrollDirection = .vertical

        // 初始化 UICollectionView
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // 注册 UICollectionView 的 cell
        collectionView.register(BuyPackageCardPlanCell.self, forCellWithReuseIdentifier: BuyPackageCardPlanCell.cellIdentifier())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
                                                                                            
        return collectionView
    }()
    // MARK: - Static
    override class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    override class func cell(with tableView: UITableView) -> LimitedTimePackageCardViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? LimitedTimePackageCardViewCell { return cell }
        return LimitedTimePackageCardViewCell(style: .default, reuseIdentifier: identifier)
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
    override func layoutSubviews() {
        super.layoutSubviews()

        // fillCode
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor(red: 1, green: 0.97, blue: 0.94, alpha: 1).cgColor, UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor]
        bgLayer1.locations = [0, 1]
        bgLayer1.frame = containerView.bounds
        bgLayer1.startPoint = CGPoint(x: 0.5, y: 0)
        bgLayer1.endPoint = CGPoint(x: 1, y: 1)
        containerView.layer.insertSublayer(bgLayer1, at: 0)
    }
}

// MARK: - Setup
private extension LimitedTimePackageCardViewCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(headerBackgroundImageView)
        self.containerView.addSubview(headerIconImageView)
        self.containerView.addSubview(headerLabel)
        self.containerView.addSubview(collectionView)
    }
    
    private func setupLayout() {
        containerViewHeight = containerView.heightAnchor.constraint(equalToConstant: 220)
    
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -14),
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 6),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -6),
            containerViewHeight
        ])
        NSLayoutConstraint.activate([
            headerBackgroundImageView.topAnchor.constraint(equalTo: containerView.topAnchor),

            headerBackgroundImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headerBackgroundImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            headerBackgroundImageView.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -13.5),
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -16),
        ])
        NSLayoutConstraint.activate([
            headerIconImageView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor,constant: 11),
            headerIconImageView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 7.5),
            headerIconImageView.widthAnchor.constraint(equalToConstant: 13),
            headerIconImageView.heightAnchor.constraint(equalToConstant: 13),
            headerIconImageView.trailingAnchor.constraint(equalTo: self.headerLabel.leadingAnchor,constant: -6.5),
            headerLabel.centerYAnchor.constraint(equalTo: headerIconImageView.centerYAnchor)

        ])
    }
    
}

// MARK: - Public
extension LimitedTimePackageCardViewCell {
    
}

// MARK: - Action
@objc private extension LimitedTimePackageCardViewCell {
    
}

// MARK: - Private
private extension LimitedTimePackageCardViewCell {
    
}
