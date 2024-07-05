//
//  CabinetFilterViewController.swift
//  hfpower
//
//  Created by EDY on 2024/7/5.
//

import UIKit

class CabinetFilterViewController: UIViewController {
    
    // MARK: - Accessor
    var sureAction:ButtonActionBlock?
    var closeAction:ButtonActionBlock?
    var items = [CabinetFilter]()
    // MARK: - Subviews
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(rgba:0x1D2129FF)
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var closeButton:UIButton = {
        let button = UIButton(type:.custom)
        button.setImage(UIImage(named: "filter_close")?.resized(toSize: CGSize(width: 20, height: 20)), for: .normal)
        button.addTarget(self, action: #selector(close(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var sureButton:UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 343, height: 40)
        button.tintAdjustmentMode = .automatic
        button.setBackgroundImage(UIColor(rgba:0x447AFEFF).toImage(), for: .normal)
        button.setBackgroundImage(UIColor(rgba:0x447AFEFF).withAlphaComponent(0.5).toImage(), for: .highlighted)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitle("确定", for: .normal)
        button.setTitle("确定", for: .highlighted)
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(sureButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var collectionView: UICollectionView = {
        // 初始化 UICollectionViewFlowLayout
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumInteritemSpacing = 10 // 列间距
        collectionViewLayout.minimumLineSpacing = 16 // 行间距
        let itemWidth = (UIScreen.main.bounds.size.width - 16 - 30 - 16) / 4
        collectionViewLayout.itemSize = CGSize(width: itemWidth, height: 36)
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        collectionViewLayout.scrollDirection = .vertical

        // 初始化 UICollectionView
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // 注册 UICollectionView 的 cell
        collectionView.register(CabinetFilterViewCell.self, forCellWithReuseIdentifier: CabinetFilterViewCell.cellIdentifier())
        collectionView.register(CabinetFilterHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CabinetFilterHeaderReusableView.viewIdentifier())

        collectionView.translatesAutoresizingMaskIntoConstraints = false
                                                                                            
        return collectionView
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    
}

// MARK: - Setup
private extension CabinetFilterViewController {
    
    private func setupNavbar() {
        self.title = "筛选"
        self.titleLabel.text = self.title
    }
   
    private func setupSubviews() {
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.closeButton)
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.sureButton)
        self.view.bringSubviewToFront(self.sureButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
        
        ])
        NSLayoutConstraint.activate([
            sureButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 16),
            sureButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -16),
            sureButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -27),
            sureButton.heightAnchor.constraint(equalToConstant: 40)


        ])
    }
}

// MARK: - Public
extension CabinetFilterViewController {
    
}
extension CabinetFilterViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.items.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items[section].filterItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CabinetFilterViewCell.cellIdentifier(), for: indexPath) as? CabinetFilterViewCell else {return CabinetFilterViewCell()}
        cell.model = self.items[indexPath.section].filterItems?[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    
}
// MARK: - Request
private extension CabinetFilterViewController {
    
}

// MARK: - Action
@objc private extension CabinetFilterViewController {
    @objc func close(_ sender:UIButton){
        self.closeAction?(sender)
    }
    @objc func sureButtonTapped(_ sender:UIButton){
        self.sureAction?(sender)
    }
}

// MARK: - Private
private extension CabinetFilterViewController {
    
}
