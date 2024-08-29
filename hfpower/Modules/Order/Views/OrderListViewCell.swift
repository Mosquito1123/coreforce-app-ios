//
//  OrderListViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/8/15.
//

import UIKit

class OrderListViewCell: BaseTableViewCell<OrderList> {
    class DetailView:UIView{
        lazy var titleLabel1: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.text = "订单类型："
            label.textColor = UIColor(rgba:0x666666FF)
            label.font = UIFont.systemFont(ofSize: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        lazy var contentLabel1: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.textAlignment = .left
            label.text = "¥2000 "
            label.textColor = UIColor(rgba:0x333333FF)
            label.font = UIFont.systemFont(ofSize: 14,weight: .medium)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        lazy var titleLabel2: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.text = "订单金额："
            label.textColor = UIColor(rgba:0x666666FF)
            label.font = UIFont.systemFont(ofSize: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        lazy var contentLabel2: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.textAlignment = .left
            label.text = "¥2000 "
            label.textColor = UIColor(rgba:0xFF6565FF)
            label.font = UIFont.systemFont(ofSize: 14,weight: .medium)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        lazy var titleLabel3: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.text = "订单时间："
            label.textColor = UIColor(rgba:0x666666FF)
            label.font = UIFont.systemFont(ofSize: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        lazy var contentLabel3: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.textAlignment = .left
            label.text = "¥2000 "
            label.textColor = UIColor(rgba:0x333333FF)
            label.font = UIFont.systemFont(ofSize: 14,weight: .medium)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.layer.cornerRadius = 12
            self.backgroundColor = UIColor(rgba:0xF9F9FBFF)
            self.addSubview(titleLabel1)
            self.addSubview(contentLabel1)
            self.addSubview(titleLabel2)
            self.addSubview(contentLabel2)
            self.addSubview(titleLabel3)
            self.addSubview(contentLabel3)
            NSLayoutConstraint.activate([
                titleLabel1.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 14),
                titleLabel1.topAnchor.constraint(equalTo: topAnchor,constant: 16),
                titleLabel1.bottomAnchor.constraint(equalTo: self.titleLabel2.topAnchor,constant: -12),
                titleLabel1.trailingAnchor.constraint(equalTo: contentLabel1.leadingAnchor,constant: -10.5),
                contentLabel1.topAnchor.constraint(equalTo: self.topAnchor,constant: 16),
                contentLabel1.bottomAnchor.constraint(equalTo: contentLabel2.topAnchor,constant: -12),
                contentLabel1.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -14),
                titleLabel2.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 14),
                titleLabel2.bottomAnchor.constraint(equalTo: titleLabel3.topAnchor,constant: -12),
                titleLabel2.trailingAnchor.constraint(equalTo: contentLabel2.leadingAnchor,constant: -10.5),
                contentLabel2.bottomAnchor.constraint(equalTo: contentLabel3.topAnchor,constant: -12),
                contentLabel2.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -14),
                titleLabel3.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 14),
                titleLabel3.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -11),
                titleLabel3.trailingAnchor.constraint(equalTo: contentLabel3.leadingAnchor,constant: -10.5),
                contentLabel3.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -11),
                contentLabel3.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -14),
                titleLabel1.trailingAnchor.constraint(equalTo: titleLabel2.trailingAnchor),
                titleLabel2.trailingAnchor.constraint(equalTo: titleLabel3.trailingAnchor),
                titleLabel1.trailingAnchor.constraint(equalTo: leadingAnchor,constant: 90),

            ])
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
    }
    class RefundView:UIView{
        lazy var titleLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.text = "退款金额： "
            label.textColor = UIColor(rgba:0x666666FF)
            label.font = UIFont.systemFont(ofSize: 14)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        lazy var contentLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.text = "¥2000 "
            label.textColor = UIColor(rgba:0xFF6565FF)
            label.font = UIFont.systemFont(ofSize: 14,weight: .medium)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.layer.cornerRadius = 12
            self.backgroundColor = UIColor(rgba:0xFFF6F6FF)
            self.addSubview(titleLabel)
            self.addSubview(contentLabel)
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 14),
                titleLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 16),
                titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -16),
                titleLabel.trailingAnchor.constraint(equalTo: contentLabel.leadingAnchor,constant: -10.5),
                contentLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 16),
                contentLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -16),
                contentLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -14),


            ])
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
    }
    // MARK: - Accessor
    override func configure() {
        self.titleLabel.text = element?.orderNo
        let payStatus = element?.payStatus ?? -1
        switch payStatus {
        case -1:
            self.statusLabel.text = "异常"
            self.statusLabel.textColor = UIColor(rgba:0xFF6565FF)

        case 0:
            self.statusLabel.text = "取消/过期"
            self.statusLabel.textColor = UIColor(rgba:0xA0A0A0FF)
            self.refundView.contentLabel.text = "￥\(element?.payableAmount ?? 0)"


        case 1:
            self.statusLabel.text = "待支付"
            self.statusLabel.textColor = UIColor(rgba:0xFF6565FF)

        case 2:
            self.statusLabel.text = "已支付"
            self.statusLabel.textColor = UIColor(rgba:0x447AFEFF)
        case 3:
            self.statusLabel.text = "无需支付"
            self.statusLabel.textColor = UIColor(rgba:0xA0A0A0FF)

        case 4:
            self.statusLabel.text = "支付异常"
            self.statusLabel.textColor = UIColor(rgba:0xFF6565FF)

        default:
            self.statusLabel.text = "异常"
            self.statusLabel.textColor = UIColor(rgba:0xFF6565FF)

        }
        let deviceType = element?.deviceType ?? 0
        switch deviceType{
        case 1:
            self.detailView.contentLabel1.text = "租电池订单"
            self.detailView.contentLabel2.text = "￥\(element?.totalAmount ?? 0)"
            self.detailView.contentLabel3.text = element?.createAt
        case 2:
            self.detailView.contentLabel1.text = "电池柜订单"
            self.detailView.contentLabel2.text = "￥\(element?.totalAmount ?? 0)"
            self.detailView.contentLabel3.text = element?.createAt
        case 3:
            self.detailView.contentLabel1.text = "充电柜订单"
            self.detailView.contentLabel2.text = "￥\(element?.totalAmount ?? 0)"
            self.detailView.contentLabel3.text = element?.createAt
        case 4:
            self.detailView.contentLabel1.text = "租车订单"
            self.detailView.contentLabel2.text = "￥\(element?.totalAmount ?? 0)"
            self.detailView.contentLabel3.text = element?.createAt
        case 5:
            self.detailView.contentLabel1.text = "换电柜格口订单"
            self.detailView.contentLabel2.text = "￥\(element?.totalAmount ?? 0)"
            self.detailView.contentLabel3.text = element?.createAt

        default:
            self.detailView.contentLabel1.text = "换电柜格口订单"
            self.detailView.contentLabel2.text = "￥\(element?.totalAmount ?? 0)"
            self.detailView.contentLabel3.text = element?.createAt

        }
    }
    var detailViewBottom:NSLayoutConstraint!
    // MARK: - Subviews
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return  view
    }()
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "order_list_icon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "TQSO202308091234"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(rgba:0x333333FF)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "已支付"
        label.font = UIFont.systemFont(ofSize: 14,weight: .medium)
        label.textColor = UIColor(rgba:0x447AFEFF)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var detailView:DetailView = {
        let view = DetailView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var refundView:RefundView = {
        let view = RefundView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // MARK: - Static
    override class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    override class func cell(with tableView: UITableView) -> OrderListViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? OrderListViewCell { return cell }
        return OrderListViewCell(style: .default, reuseIdentifier: identifier)
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
private extension OrderListViewCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
        self.backgroundColor = UIColor(rgba: 0xF6F6F6FF)
        self.contentView.addSubview(self.containerView)
        self.containerView.addSubview(self.detailView)
        self.containerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.iconImageView)
        self.containerView.addSubview(self.statusLabel)
        self.containerView.addSubview(self.refundView)
    }
    
    private func setupLayout() {
        detailViewBottom = detailView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -14)

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -14),
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 7),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -7),
        ])
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 14),
            iconImageView.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 16),
            iconImageView.heightAnchor.constraint(equalToConstant: 16),
            
            titleLabel.leadingAnchor.constraint(equalTo: self.iconImageView.trailingAnchor, constant: 6),
            titleLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 18.5),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: statusLabel.leadingAnchor,constant: -14),
            statusLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor,constant: -14),
            detailView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 16.5),
            detailView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor,constant: 12),
            detailView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor,constant: -12),
            detailViewBottom,
            refundView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor,constant: 12),
            refundView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor,constant: -12),
            refundView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -14)


        ])
        
    }
    
}

// MARK: - Public
extension OrderListViewCell {
    
}

// MARK: - Action
@objc private extension OrderListViewCell {
    
}

// MARK: - Private
private extension OrderListViewCell {
    
}
