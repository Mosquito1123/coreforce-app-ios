//
//  FirstViewController.swift
//  hfpower
//
//  Created by EDY on 2024/10/14.
//

import UIKit

class StackLayout: UICollectionViewLayout {

    // Cell 大小
    var itemSize: CGSize = CGSize(width: 200, height: 300)
    
    // 叠加偏移量
    var stackOffset: CGFloat = 30
    
    // 内容区域大小
    override var collectionViewContentSize: CGSize {
        let totalItems = collectionView?.numberOfItems(inSection: 0) ?? 0
        let totalHeight = CGFloat(totalItems) * stackOffset + itemSize.height
        return CGSize(width: collectionView?.bounds.width ?? 0, height: totalHeight)
    }
    
    // 返回所有 Cell 布局属性
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributesArray: [UICollectionViewLayoutAttributes] = []
        let totalItems = collectionView?.numberOfItems(inSection: 0) ?? 0
        
        for item in 0..<totalItems {
            let indexPath = IndexPath(item: item, section: 0)
            if let attributes = layoutAttributesForItem(at: indexPath) {
                attributesArray.append(attributes)
            }
        }
        return attributesArray
    }
    
    // 设置单个 Cell 的布局属性
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let collectionView = collectionView else { return nil }
        
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        // 计算每个 Cell 的位置，堆叠在一起并且有一定的偏移
        let yPosition = stackOffset * CGFloat(indexPath.item)
        let xPosition = (collectionView.bounds.width - itemSize.width) / 2
        
        attributes.frame = CGRect(x: xPosition, y: yPosition, width: itemSize.width, height: itemSize.height)
        attributes.zIndex = indexPath.item
        
        return attributes
    }
    
    // 是否需要实时更新布局
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

class FirstViewController: UICollectionViewController {
    
    // MARK: - Accessor
    
    // MARK: - Subviews

    // MARK: - Lifecycle
    init() {
        let stackLayout = StackLayout()
        super.init(collectionViewLayout: stackLayout)
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10  // 这里可以根据需求设置项数
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        // 设置每个 Cell 的外观
        cell.backgroundColor = .blue
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.black.cgColor
        
        return cell
    }
}

// MARK: - Setup
private extension FirstViewController {
    
    private func setupNavbar() {
        
    }
   
    private func setupSubviews() {
        // 初始化自定义堆叠布局
        let stackLayout = StackLayout()
        collectionView.collectionViewLayout = stackLayout
        
        // 注册 Cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    private func setupLayout() {
        
    }
}

// MARK: - Public
extension FirstViewController {
    
}

// MARK: - Request
private extension FirstViewController {
    
}

// MARK: - Action
@objc private extension FirstViewController {
    
}

// MARK: - Private
private extension FirstViewController {
    
}
