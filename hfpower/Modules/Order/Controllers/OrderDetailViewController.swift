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
    @objc var id:NSNumber?
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
        loadData()
    }
    func payStatusString(orderDetail:HFOrderDetailData?)->String{
        let payStatus = orderDetail?.payStatus ?? 0
        switch payStatus {
        case -1:
            return "异常"
        case 0:
            return "取消/过期"
        case 1:
            return "待支付"
        case 2:
            return "已支付"
        case 3:
            return "无需支付"
        case 4:
            return "支付异常"
        default:
            return ""
        }
    }
    func payMethodString(orderDetail:HFOrderDetailData?)->String{
        let payMethod  = orderDetail?.payMethod ?? 0
        switch payMethod {
        case 1:
            return "微信JSAPI"
        case 2:
            return "微信APP"
        case 3:
            return "微信NATIVE"
        case 4:
            return "微信"
        case 5:
            return "支付宝APP"
        case 10:
            return "钱包"
        case 11:
            return "寄存券"
        case 12:
            return "套餐卡"
        default:
            return ""
        }
    }
    func authOrderStatusString(orderDetail:HFOrderDetailData?)->String{
        let authOrderStatus = orderDetail?.authOrderStatus ?? 0
        switch authOrderStatus {
        case 0:
            return "支付宝预授权中"
        case 1:
            return "支付宝已授权"
        case 2:
            return "押金支付授权"
        default:
            return "无"
        }
    }
    func configOrderDetail(orderDetail:HFOrderDetailData?){
        if let deviceType = orderDetail?.deviceType{
            let orderNo = orderDetail?.orderNo ?? ""
            
            switch deviceType {
            case 1:
                let batteryNumber = orderDetail?.batteryNumber ?? ""
                let batteryTypeName = orderDetail?.batteryTypeName ?? ""
                let agentName = orderDetail?.agentName ?? ""
                let createAt = orderDetail?.createAt ?? ""
                let duration = orderDetail?.duration ?? 0
                let rentString = String(format: "%.2f元", orderDetail?.rent ?? 0.0)
                let depositString = String(format: "%.2f元", orderDetail?.deposit ?? 0.0)
                let couponDiscountAmountString = String(format: "%.2f元", orderDetail?.couponDiscountAmount ?? 0.0)
                let planString = orderDetail?.payMethod == 12 ? String(format: "租电套餐%d天", orderDetail?.payVoucherDays ?? 0.0):"无"
                let rentDetailString = String(format: "¥%.2f/%d天x%d", orderDetail?.rent ?? 0, orderDetail?.duration ?? 0, orderDetail?.leaseDuration ?? 0)
                let paidString = String(format: "%.2f元", (orderDetail?.totalAmount ?? 0.0) - (orderDetail?.couponDiscountAmount ?? 0.0))
                self.items = [
                    OrderDetail(id: 0,items: [
                        OrderDetailItem(id: 0, title: "订单类型", content: "电池"),
                        OrderDetailItem(id: 1, title: "订单状态", content: payStatusString(orderDetail: orderDetail)),
                        OrderDetailItem(id: 2, title: "订单编号", content: orderNo),
                        OrderDetailItem(id: 3, title: "订单时间", content: createAt),
                        
                    ]),
                    OrderDetail(id: 1,items: [
                        OrderDetailItem(id: 0, title: "电池编号", content: batteryNumber),
                        OrderDetailItem(id: 1, title: "电池型号", content: batteryTypeName),
                        OrderDetailItem(id: 2, title: "电池租期", content: "\(duration)"),
                        OrderDetailItem(id: 3, title: "服务网点", content: agentName),
                        
                    ]),
                    OrderDetail(id: 2,items: [
                        OrderDetailItem(id: 0, title: "电池租金", content: rentString,extra: rentDetailString),
                        OrderDetailItem(id: 1, title: "电池押金", content: depositString),
                        OrderDetailItem(id: 2, title: "优惠", content: couponDiscountAmountString),
                        OrderDetailItem(id: 3, title: "套餐", content: planString),
                        OrderDetailItem(id: 4, title: "合计", content: paidString),
                        
                        
                    ]),
                    OrderDetail(id: 2,items: [
                        OrderDetailItem(id: 0, title: "押金授权", content: authOrderStatusString(orderDetail: orderDetail)),
                        OrderDetailItem(id: 1, title: "支付方式", content: payMethodString(orderDetail: orderDetail)),
                        
                    ]),
                ]
            case 4:
                let locomotiveNumber = orderDetail?.locomotiveNumber ?? ""
                let agentName = orderDetail?.agentName ?? ""
                let createAt = orderDetail?.createAt ?? ""
                let duration = orderDetail?.duration ?? 0
                let rentString = String(format: "%.2f元", orderDetail?.rent ?? 0.0)
                let depositString = String(format: "%.2f元", orderDetail?.deposit ?? 0.0)
                let couponDiscountAmountString = String(format: "%.2f元", orderDetail?.couponDiscountAmount ?? 0.0)
                let planString = orderDetail?.payMethod == 12 ? String(format: "租电套餐%d天", orderDetail?.payVoucherDays ?? 0.0):"无"
                let rentDetailString = String(format: "¥%.2f/%d天x%d", orderDetail?.rent ?? 0, orderDetail?.duration ?? 0, orderDetail?.leaseDuration ?? 0)
                let paidString = String(format: "%.2f元", (orderDetail?.totalAmount ?? 0.0) - (orderDetail?.couponDiscountAmount ?? 0.0))
                self.items = [
                    OrderDetail(id: 0,items: [
                        OrderDetailItem(id: 0, title: "订单类型", content: "电车"),
                        OrderDetailItem(id: 1, title: "订单状态", content: payStatusString(orderDetail: orderDetail)),
                        OrderDetailItem(id: 2, title: "订单编号", content: orderNo),
                        OrderDetailItem(id: 3, title: "订单时间", content: createAt),
                        
                    ]),
                    OrderDetail(id: 1,items: [
                        OrderDetailItem(id: 0, title: "机车编号", content: locomotiveNumber),
                        OrderDetailItem(id: 1, title: "机车租期", content: "\(duration)"),
                        OrderDetailItem(id: 2, title: "机车服务网点", content: agentName),
                        
                    ]),
                    OrderDetail(id: 2,items: [
                        OrderDetailItem(id: 0, title: "机车租金", content: rentString,extra: rentDetailString),
                        OrderDetailItem(id: 1, title: "机车押金", content: depositString),
                        OrderDetailItem(id: 2, title: "优惠", content: couponDiscountAmountString),
                        OrderDetailItem(id: 3, title: "套餐", content: planString),
                        OrderDetailItem(id: 4, title: "合计", content: paidString),
                        
                        
                    ]),
                    OrderDetail(id: 2,items: [
                        OrderDetailItem(id: 0, title: "押金授权", content: authOrderStatusString(orderDetail: orderDetail)),
                        OrderDetailItem(id: 1, title: "支付方式", content: payMethodString(orderDetail: orderDetail)),
                        
                    ]),
                ]
            default:
                let batteryNumber = orderDetail?.batteryNumber ?? ""
                let batteryTypeName = orderDetail?.batteryTypeName ?? ""
                let agentName = orderDetail?.agentName ?? ""
                let createAt = orderDetail?.createAt ?? ""
                let duration = orderDetail?.duration ?? 0
                let rentString = String(format: "%.2f元", orderDetail?.rent ?? 0.0)
                let depositString = String(format: "%.2f元", orderDetail?.deposit ?? 0.0)
                let couponDiscountAmountString = String(format: "%.2f元", orderDetail?.couponDiscountAmount ?? 0.0)
                let planString = orderDetail?.payMethod == 12 ? String(format: "租电套餐%d天", orderDetail?.payVoucherDays ?? 0.0):"无"
                let rentDetailString = String(format: "¥%.2f/%d天x%d", orderDetail?.rent ?? 0, orderDetail?.duration ?? 0, orderDetail?.leaseDuration ?? 0)
                let paidString = String(format: "%.2f元", (orderDetail?.totalAmount ?? 0.0) - (orderDetail?.couponDiscountAmount ?? 0.0))
                self.items = [
                    OrderDetail(id: 0,items: [
                        OrderDetailItem(id: 0, title: "订单类型", content: "电池"),
                        OrderDetailItem(id: 1, title: "订单状态", content: payStatusString(orderDetail: orderDetail)),
                        OrderDetailItem(id: 2, title: "订单编号", content: orderNo),
                        OrderDetailItem(id: 3, title: "订单时间", content: createAt),
                        
                    ]),
                    OrderDetail(id: 1,items: [
                        OrderDetailItem(id: 0, title: "电池编号", content: batteryNumber),
                        OrderDetailItem(id: 1, title: "电池型号", content: batteryTypeName),
                        OrderDetailItem(id: 2, title: "电池租期", content: "\(duration)"),
                        OrderDetailItem(id: 3, title: "服务网点", content: agentName),
                        
                    ]),
                    OrderDetail(id: 2,items: [
                        OrderDetailItem(id: 0, title: "电池租金", content: rentString,extra: rentDetailString),
                        OrderDetailItem(id: 1, title: "电池押金", content: depositString),
                        OrderDetailItem(id: 2, title: "优惠", content: couponDiscountAmountString),
                        OrderDetailItem(id: 3, title: "套餐", content: planString),
                        OrderDetailItem(id: 4, title: "合计", content: paidString),
                        
                        
                    ]),
                    OrderDetail(id: 2,items: [
                        OrderDetailItem(id: 0, title: "押金授权", content: authOrderStatusString(orderDetail: orderDetail)),
                        OrderDetailItem(id: 1, title: "支付方式", content: payMethodString(orderDetail: orderDetail)),
                        
                    ]),
                ]
                
            }
            
        }
        
    }
    func loadData(){
        if let id = self.id{
            self.getData(orderUrl, param: ["id":id], isLoading: true) { responseObject in
                if let body = (responseObject as? [String:Any])?["body"] as? [String: Any],
                   let order = body["order"] as? [String: Any] {
                    let orderData = HFOrderDetailData.mj_object(withKeyValues: order)
                    let payStatus = orderData?.payStatus ?? 1
                    switch payStatus {
                    case -1:
                        self.bottomViewHeight.constant = 0
                    case 0:
                        self.bottomViewHeight.constant = 0
                    case 1:
                        self.bottomViewHeight.constant = 107
                    case 2:
                        self.bottomViewHeight.constant = 0
                    case 3:
                        self.bottomViewHeight.constant = 0
                    case 4:
                        self.bottomViewHeight.constant = 0
                    default:
                        self.bottomViewHeight.constant = 0
                        
                    }
                    self.configOrderDetail(orderDetail: orderData)
                }
            } error: { error in
                self.showError(withStatus: error.localizedDescription)
            }
            
        }
        
        
    }
    
}

// MARK: - Setup
private extension OrderDetailViewController {
    private func setupNavbar() {
        self.title = "订单详情"
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;
        
        // 自定义返回按钮
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back_arrow"), for: .normal)  // 设置自定义图片
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
        bottomView.cancelButton.addAction(for: .touchUpInside) {
            if let id = self.id{
                
                self.postData(orderCancelUrl,
                         param: ["orderId": id],
                         isLoading: true,
                         success: { [weak self] responseObject in
                    self?.navigationController?.popViewController(animated: true)
                },
                         error: { error in
                    // 处理错误
                    self.showError(withStatus: error.localizedDescription)
                })
            }
            
            
        }
        bottomView.submitButton.addAction(for: .touchUpInside) {
            
        }
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
