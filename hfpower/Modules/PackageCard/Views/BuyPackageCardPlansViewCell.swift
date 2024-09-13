//
//  BuyPackageCardPlansViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/6/28.
//

import UIKit
enum BuyPackageCardPlanCellType:Int{
    case common
    case limitedTime
    case newComers
    
    
}
class BuyPackageCardPlansViewCell: BaseTableViewCell<BuyPackageCard>,UICollectionViewDelegate,UICollectionViewDataSource {
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
        self.titleLabel.text = element?.title
        self.items = (element?.items ?? [HFPackageCardModel]()).map({ model in
            let modelx = model
            modelx.cellType = NSNumber(integerLiteral: 0)
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

    var didSelectItemBlock:((_ collectionView: UICollectionView, _ indexPath: IndexPath)->Void)?
    var containerViewHeight:NSLayoutConstraint!
    var items = [HFPackageCardModel](){
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
        label.textColor = UIColor(rgba:0x333333FF)
        label.font = UIFont.systemFont(ofSize: 16,weight: .medium)
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
    
    override class func cell(with tableView: UITableView) -> BuyPackageCardPlansViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? BuyPackageCardPlansViewCell { return cell }
        return BuyPackageCardPlansViewCell(style: .default, reuseIdentifier: identifier)
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
private extension BuyPackageCardPlansViewCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1)
        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(titleLabel)
        self.containerView.addSubview(collectionView)
    }
    
    private func setupLayout() {
        containerViewHeight = containerView.heightAnchor.constraint(equalToConstant: 328)
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
extension BuyPackageCardPlansViewCell {
    
}

// MARK: - Action
@objc private extension BuyPackageCardPlansViewCell {
    
}

// MARK: - Private
private extension BuyPackageCardPlansViewCell {
    
}

class BuyPackageCardPlanCell: UICollectionViewCell {

    
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with collectionView: UICollectionView,_ indexPath:IndexPath) -> BuyPackageCardPlanCell {
        let identifier = cellIdentifier()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? BuyPackageCardPlanCell { return cell }
        return BuyPackageCardPlanCell()
    }
    // MARK: - Properties

    var model: HFPackageCardModel? {
        didSet {
            guard let model = model else { return }
           
            
            if model.tag == "" {
                leftTopView.isHidden = true
                leftTopLabel.isHidden = true
            } else {
                leftTopView.isHidden = false
                leftTopLabel.isHidden = false
            }
            leftTopLabel.text = model.tag
            daysLabel.text = "\(model.days)天"
            let nf = NumberFormatter()
            nf.maximumFractionDigits = 2
            nf.minimumFractionDigits = 0
            planAmountLabel.text = nf.string(from: model.price )
            let attributedText = NSAttributedString(string: "￥\(nf.string(from: model.originalPrice ) ?? "0")",
                                                    attributes: [
                                                        .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                                                        .foregroundColor: UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 1),
                                                        .font: UIFont.systemFont(ofSize: 12)
                                                    ])
            originAmountLabel.attributedText = attributedText
            let perMonthNumber = (model.price.doubleValue  )/(model.days.doubleValue )
            planPerMonthLabel.text = "\(nf.string(from: NSNumber(value: perMonthNumber)) ?? "0")元/天"
            guard let type = BuyPackageCardPlanCellType(rawValue: model.cellType.intValue) else {return}
            switch type {
            case .common:
                if model.selected.boolValue {
                    backgroundColor = UIColor(red: 0.94, green: 0.96, blue: 1, alpha: 1)
                    layer.borderWidth = 1.5
                    layer.borderColor = UIColor(red: 0.19, green: 0.44, blue: 0.94, alpha: 1).cgColor
                    planUnitLabel.textColor = UIColor(red: 0.19, green: 0.44, blue: 0.94, alpha: 1)
                    planAmountLabel.textColor = UIColor(red: 0.19, green: 0.44, blue: 0.94, alpha: 1)
                } else {
                    backgroundColor = UIColor(red: 0.96, green: 0.97, blue: 0.98, alpha: 1)
                    layer.borderWidth = 0.0
                    layer.borderColor = UIColor.clear.cgColor
                    planUnitLabel.textColor = UIColor(white: 51/255, alpha: 1)
                    planAmountLabel.textColor = UIColor(white: 51/255, alpha: 1)
                }
            case .limitedTime:
                if model.selected.boolValue {
                    backgroundColor = UIColor(rgba: 0xFFF3E3FF)
                    layer.borderWidth = 1.5
                    layer.borderColor = UIColor(rgba: 0xF97B02FF).cgColor
                    planUnitLabel.textColor = UIColor(rgba: 0xF97602FF)
                    planAmountLabel.textColor = UIColor(rgba: 0xF97602FF)
                    planPerMonthLabel.textColor = UIColor(rgba: 0xF97602FF)
                } else {
                    backgroundColor = UIColor(rgba: 0xFFF3E3FF)
                    layer.borderWidth = 0.0
                    layer.borderColor = UIColor.clear.cgColor
                    planUnitLabel.textColor = UIColor(white: 51/255, alpha: 1)
                    planAmountLabel.textColor = UIColor(white: 51/255, alpha: 1)
                    planPerMonthLabel.textColor = UIColor(rgba: 0xF97602FF)

                }
            case .newComers:
                if model.selected.boolValue {
                    backgroundColor = UIColor(rgba:0xFFF1F0FF)
                    layer.borderWidth = 1.5
                    layer.borderColor =  UIColor(rgba:0xEC5259FF).cgColor
                    planUnitLabel.textColor =  UIColor(rgba:0xEC5259FF)
                    planAmountLabel.textColor =  UIColor(rgba:0xEC5259FF)
                    planPerMonthLabel.textColor = UIColor(rgba: 0xF5746BFF)

                } else {
                    backgroundColor = UIColor(rgba:0xFFF1F0FF)
                    layer.borderWidth = 0.0
                    layer.borderColor = UIColor.clear.cgColor
                    planUnitLabel.textColor = UIColor(white: 51/255, alpha: 1)
                    planAmountLabel.textColor = UIColor(white: 51/255, alpha: 1)
                    planPerMonthLabel.textColor = UIColor(rgba: 0xF5746BFF)

                }
            }
        }
    }

    // 懒加载视图
    lazy var leftTopView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 18))
        view.translatesAutoresizingMaskIntoConstraints = false

        // 创建渐变层
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.colors = [
            UIColor(red: 246/255.0, green: 120/255.0, blue: 109/255.0, alpha: 1.0).cgColor,
            UIColor(red: 235/255.0, green: 76/255.0, blue: 86/255.0, alpha: 1.0).cgColor
        ]
        gradientLayer.locations = [0, 1]

        // 设置圆角
        let maskPath = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.topLeft, .bottomRight], cornerRadii: CGSize(width: 6, height: 6))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = view.bounds
        maskLayer.path = maskPath.cgPath
        gradientLayer.mask = maskLayer

        view.layer.addSublayer(gradientLayer)
        return view
    }()

    lazy var leftTopLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 18))
        label.text = ""
        label.textAlignment = .center
        label.textColor = UIColor(white: 1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        return label
    }()

    lazy var daysLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "60天"
        label.textColor = UIColor(white: 51/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var planUnitLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .right
        label.text = "￥"
        label.textColor = UIColor(white: 51/255, alpha: 1)
        label.font = UIFont(name: "DIN Alternate Bold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var planAmountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "999"
        label.textColor = UIColor(white: 51/255, alpha: 1)
        label.font = UIFont(name: "DIN Alternate Bold", size: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var originAmountLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSAttributedString(string: "￥1698",
                                                attributes: [
                                                    .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                                                    .foregroundColor: UIColor(red: 0.63, green: 0.63, blue: 0.63, alpha: 1),
                                                    .font: UIFont.systemFont(ofSize: 12)
                                                ])
        label.attributedText = attributedText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var planPerMonthLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = ""
        label.textColor = UIColor(red: 0.19, green: 0.44, blue: 0.94, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

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
        self.backgroundColor = UIColor(red: 246/255, green: 247/255, blue: 249/255, alpha: 1)
        self.layer.cornerRadius = 6
        contentView.addSubview(daysLabel)
        contentView.addSubview(planUnitLabel)
        contentView.addSubview(planAmountLabel)
        contentView.addSubview(originAmountLabel)
        contentView.addSubview(planPerMonthLabel)
        contentView.addSubview(leftTopView)
        contentView.addSubview(leftTopLabel)

    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            leftTopView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            leftTopView.topAnchor.constraint(equalTo: contentView.topAnchor),

            leftTopLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            leftTopLabel.topAnchor.constraint(equalTo: contentView.topAnchor),

            daysLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            daysLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),

            planAmountLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 10),
            planAmountLabel.topAnchor.constraint(equalTo: daysLabel.bottomAnchor, constant: 10),

            planUnitLabel.centerYAnchor.constraint(equalTo: planAmountLabel.centerYAnchor),
            planUnitLabel.trailingAnchor.constraint(equalTo: planAmountLabel.leadingAnchor),

            originAmountLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            originAmountLabel.topAnchor.constraint(equalTo: planAmountLabel.bottomAnchor, constant: 10),

            planPerMonthLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            planPerMonthLabel.topAnchor.constraint(equalTo: originAmountLabel.bottomAnchor, constant: 10)
        ])
    }

    // MARK: - Selection

    override var isSelected: Bool {
        didSet {
            
        }
    }
}
