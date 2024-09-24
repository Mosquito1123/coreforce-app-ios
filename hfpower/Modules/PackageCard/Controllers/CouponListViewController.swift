//
//  CouponListViewController.swift
//  hfpower
//
//  Created by EDY on 2024/7/11.
//

import UIKit

class CouponListViewController: BaseTableViewController<CouponListViewCell,Coupon> {
    
    // MARK: - Accessor
    override var title: String?{
        didSet{
            self.titleLabel.text = title
        }
    }
    // MARK: - Subviews
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(hex:0x333333FF)
        label.font = UIFont.systemFont(ofSize: 18,weight: .medium)
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
    private lazy var mainView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: self.view.frame.maxY - 590, width: self.view.frame.width, height: 590))
        view.layer.cornerRadius = 20
        if #available(iOS 11.0, *) {
            view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
            // 处理不支持 `maskedCorners` 的 iOS 版本
        }
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(white: 1.0, alpha: 1.0) // 替换 `RGBA` 函数
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var submitButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 24.5
        button.layer.masksToBounds = true
        button.tintAdjustmentMode = .automatic
        button.setTitle("确定使用", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .highlighted)
        button.setBackgroundImage(UIColor(hex:0x447AFEFF).toImage(), for: .normal)
        button.setBackgroundImage(UIColor(hex:0x447AFEFF).withAlphaComponent(0.5).toImage(), for: .normal)
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(submitButtonClick(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var submitButtonBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSubviews()
        setupLayout()
        /*空白页占位
                 tableView.emptyState.format = noCoupon.format
                 tableView.emptyState.show(noCoupon)
         */
        self.loadData()

    }
    func loadData(){
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: - Setup
private extension CouponListViewController {
    
    private func setupNavbar() {
        self.title = "我的优惠券"
        
    }
   
    private func setupSubviews() {
        self.view.backgroundColor = .clear
        
        // 添加子视图
        self.view.addSubview(mainView)
        mainView.addSubview(closeButton)
        mainView.addSubview(titleLabel)
        mainView.addSubview(tableView)
        tableView.backgroundColor = UIColor(hex:0xF8F8F8FF)
        mainView.addSubview(submitButtonBackgroundView)
        submitButtonBackgroundView.addSubview(submitButton)
        self.items = [Coupon()]
    }
    
    private func setupLayout() {
        // 设置 mainView 的约束
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            mainView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 590/812.0)
        ])
        
        // 设置 closeButton、titleLabel、tableView、submitButtonBackgroundView 和 submitButton 的约束
        NSLayoutConstraint.activate([
            // closeButton 的约束
            closeButton.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 15),
            closeButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -15),
            closeButton.widthAnchor.constraint(equalToConstant: 18),
            closeButton.heightAnchor.constraint(equalToConstant: 18),
            
            // titleLabel 的约束
            titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 15),
            titleLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -15),
            
            // tableView 的约束
            tableView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: submitButtonBackgroundView.topAnchor),
            
            // submitButtonBackgroundView 的约束
            submitButtonBackgroundView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            submitButtonBackgroundView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            submitButtonBackgroundView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            submitButtonBackgroundView.heightAnchor.constraint(equalToConstant: 90),
            
            // submitButton 的约束
            submitButton.topAnchor.constraint(equalTo: submitButtonBackgroundView.topAnchor, constant: 12),
            submitButton.leadingAnchor.constraint(equalTo: submitButtonBackgroundView.leadingAnchor, constant: 12),
            submitButton.trailingAnchor.constraint(equalTo: submitButtonBackgroundView.trailingAnchor, constant: -12),
            submitButton.heightAnchor.constraint(equalToConstant: 49)
        ])
    }
}

// MARK: - Public
extension CouponListViewController {
    
}

// MARK: - Request
private extension CouponListViewController {
    
}

// MARK: - Action
@objc private extension CouponListViewController {
    @objc func close(_ sender:UIButton){
        self.dismiss(animated: true)
    }
    @objc func submitButtonClick(_ sender:UIButton){
        
    }
}

// MARK: - Private
private extension CouponListViewController {
    
}
