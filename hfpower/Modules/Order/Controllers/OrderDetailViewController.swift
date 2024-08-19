//
//  OrderDetailViewController.swift
//  hfpower
//
//  Created by EDY on 2024/8/19.
//

import UIKit

class OrderDetailViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    class BottomView:UIView{
        lazy var submitButton: UIButton = {
            let button = UIButton(type: .custom)
            button.tintAdjustmentMode = .automatic
            button.setTitle("立即支付", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15,weight: .medium)
            button.setBackgroundImage(UIColor(rgba: 0x447AFEFF).toImage(), for: .normal)
            button.setBackgroundImage(UIColor(rgba: 0x447AFEFF).withAlphaComponent(0.5).toImage(), for: .selected)
            button.setBackgroundImage(UIColor(rgba: 0x447AFEFF).withAlphaComponent(0.5).toImage(), for: .highlighted)
            button.layer.cornerRadius = 21
            button.layer.masksToBounds = true
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        lazy var cancelButton: UIButton = {
            let button = UIButton(type: .custom)
            button.setTitle("取消支付", for: .normal)
            button.tintAdjustmentMode = .automatic
            button.setTitleColor(UIColor(rgba: 0x1D2129FF), for: .normal)
            button.setTitleColor(UIColor(rgba: 0x1D2129FF).withAlphaComponent(0.5), for: .highlighted)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15,weight: .medium)
            button.setBackgroundImage(UIColor.white.toImage(), for: .normal)
            button.setBackgroundImage(UIColor.white.withAlphaComponent(0.5).toImage(), for: .highlighted)
            button.setBackgroundImage(UIColor.white.withAlphaComponent(0.5).toImage(), for: .selected)
            button.layer.borderColor = UIColor(rgba: 0xE5E6EBFF).cgColor
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 21
            button.layer.masksToBounds = true
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.backgroundColor = .white
            self.addSubview(self.submitButton)
            self.addSubview(self.cancelButton)
            NSLayoutConstraint.activate([
                submitButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor),
                submitButton.heightAnchor.constraint(equalTo: cancelButton.heightAnchor),
                submitButton.heightAnchor.constraint(equalToConstant: 42),
                cancelButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
                cancelButton.trailingAnchor.constraint(equalTo: submitButton.leadingAnchor, constant: -13),
                cancelButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 15.5),
                cancelButton.topAnchor.constraint(equalTo: submitButton.topAnchor),
                submitButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
                

            ])
        }
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderDetailViewCell.cellIdentifier(), for: indexPath) as? OrderDetailViewCell else {return OrderDetailViewCell()}
        cell.element = self.items[indexPath.section].items[indexPath.row]
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cellx = cell as? OrderDetailViewCell{
            if indexPath.row == 0 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                cellx.cornerType = .all
            } else {
                if indexPath.row == 0 {
                    cellx.cornerType = .first
                    
                } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                    cellx.cornerType = .last
                    
                }else{
                    cellx.cornerType = .none
                    
                }
            }
        }
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: SettingsHeaderView.viewIdentifier()) as? SettingsHeaderView else {return UIView()}
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        16
    }
    var items = [OrderDetail](){
        didSet{
            self.tableView.reloadData()
        }
    }

    
    // MARK: - Accessor
    var bottomViewHeight:NSLayoutConstraint!
    // MARK: - Subviews
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(OrderDetailViewCell.self, forCellReuseIdentifier: OrderDetailViewCell.cellIdentifier())
        tableView.register(OrderDetailHeaderView.self, forHeaderFooterViewReuseIdentifier: OrderDetailHeaderView.viewIdentifier())
        let tableFooterView = OrderDetailFooterView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 67))

        tableView.tableFooterView = tableFooterView
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(rgba:0xF6F6F6FF)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    lazy var bottomView: BottomView = {
        let view = BottomView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false

        setupNavbar()
        setupSubviews()
        setupLayout()
        self.items = [
            OrderDetail(id: 0,title: "",items: [
                OrderDetailItem(id: 0, title: "订单类型", content: "租电车"),
                OrderDetailItem(id: 1, title: "订单状态", content: "待支付"),
                OrderDetailItem(id: 2, title: "订单编号", content: "20000000000000333"),
                OrderDetailItem(id: 3, title: "订单时间", content: "2024-07-21 17:53:21"),

            ]),
            OrderDetail(id: 1,title: "",items: [
                OrderDetailItem(id: 0, title: "电池编号", content: "TQ343222"),
                OrderDetailItem(id: 1, title: "电池型号", content: "60VMax"),
                OrderDetailItem(id: 2, title: "电池租期", content: "33天"),
                OrderDetailItem(id: 3, title: "服务网点", content: "青岛片区"),

            ]),
            OrderDetail(id: 2,title: "",items: [
                OrderDetailItem(id: 0, title: "电池租金", content: "299元",extra: "15元/天 x60"),
                OrderDetailItem(id: 1, title: "电池押金", content: "0元"),
                OrderDetailItem(id: 2, title: "优惠", content: "-33元"),
                OrderDetailItem(id: 3, title: "套餐", content: "299元/30天"),
                OrderDetailItem(id: 4, title: "合计", content: "299元"),


            ]),
            OrderDetail(id: 2,title: "",items: [
                OrderDetailItem(id: 0, title: "押金授权", content: "支付宝信用免押"),
                OrderDetailItem(id: 1, title: "支付方式", content: "微信支付"),

            ]),
        ]

    }
    
}

// MARK: - Setup
private extension OrderDetailViewController {
    private func setupNavbar() {
        self.title = "订单详情"

        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;
        
        // 自定义返回按钮
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "customer_service_back")?.colorized(with: UIColor.black)?.resized(toSize: CGSize.init(width: 12, height: 20)), for: .normal)  // 设置自定义图片
        backButton.setTitle("", for: .normal)  // 设置标题
        backButton.setTitleColor(.black, for: .normal)  // 设置标题颜色
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        // 创建一个新的 UINavigationBarAppearance 实例
        let appearance = UINavigationBarAppearance()
        
        // 设置背景色为白色
        appearance.backgroundImage = UIColor.white.toImage()
        appearance.shadowImage = UIColor.white.toImage()
        
        // 设置标题文本属性为白色
        appearance.titleTextAttributes = [.foregroundColor: UIColor(rgba: 0x333333FF),.font:UIFont.systemFont(ofSize: 18, weight: .medium)]
        
        // 设置大标题文本属性为白色
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        
    }
   
   
    private func setupSubviews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(bottomView)
        
    }
    
    private func setupLayout() {
        bottomViewHeight = bottomView.heightAnchor.constraint(equalToConstant: 107)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            bottomView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            bottomViewHeight
            
        ])
    }
}

// MARK: - Public
extension OrderDetailViewController {
    
}

// MARK: - Request
private extension OrderDetailViewController {
    
}

// MARK: - Action
@objc private extension OrderDetailViewController {
    
}

// MARK: - Private
private extension OrderDetailViewController {
    
}
