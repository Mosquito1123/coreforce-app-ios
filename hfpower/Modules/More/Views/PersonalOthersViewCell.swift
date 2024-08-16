//
//  PersonalOthersViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/6/24.
//

import UIKit

class PersonalOthersViewCell: PersonalContentViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PersonalElementIconViewCell.self), for: indexPath) as? PersonalElementIconViewCell else {return UICollectionViewCell()}
        cell.elementIconView.titleLabel.text = self.items[indexPath.item].title
        cell.elementIconView.iconImageView.image = UIImage(named: self.items[indexPath.item].icon ?? "")

        return cell
    }
    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 计算每个单元格的宽度
        let itemsPerRow: CGFloat = 5
        let padding: CGFloat = 10
        let totalPadding = padding * (itemsPerRow - 1)
        let individualWidth = (collectionView.bounds.width - totalPadding) / itemsPerRow
        
        return CGSize(width: individualWidth, height: individualWidth)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didSelectItemAtBlock?(collectionView,indexPath)
    }
    
    
    // MARK: - Accessor
    var didSelectItemAtBlock:((_ collectionView: UICollectionView, _ indexPath: IndexPath)->Void)?
    var items = [PersonalListItem](){
        didSet{
            self.collectionView.reloadData()
        }
    }
    // MARK: - Subviews
    lazy var collectionView: UICollectionView = {
        // 创建 UICollectionViewFlowLayout
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 12
        
        // 创建 UICollectionView
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PersonalElementIconViewCell.self, forCellWithReuseIdentifier: String(describing: PersonalElementIconViewCell.self))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    // MARK: - Static
    override class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    override class func cell(with tableView: UITableView) -> PersonalOthersViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? PersonalOthersViewCell { return cell }
        return PersonalOthersViewCell(style: .default, reuseIdentifier: identifier)
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
        setupLayout()
        bottomMargin.constant = -55
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Setup
private extension PersonalOthersViewCell {
    
    private func setupSubviews() {
        self.stackView.addArrangedSubview(collectionView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            collectionView.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
    
}

// MARK: - Public
extension PersonalOthersViewCell {
    
}

// MARK: - Action
@objc private extension PersonalOthersViewCell {
    
}

// MARK: - Private
private extension PersonalOthersViewCell {
    
}
