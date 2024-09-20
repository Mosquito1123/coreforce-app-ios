//
//  CustomerServicePagerViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/7/4.
//

import UIKit

class CustomerServicePagerViewCell: UITableViewCell ,UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomerServicePagerItemViewCell.cellIdentifier(), for: indexPath) as? CustomerServicePagerItemViewCell else {return UITableViewCell()}
        cell.element = self.elements[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.didSelectRowAction?(tableView,indexPath)
    }
    
    // MARK: - Accessor
    var didSelectRowAction:((_ tableView: UITableView, _ indexPath: IndexPath)->Void)?
    var containerViewHeight:NSLayoutConstraint!

    var elements:[HFHelpList] = [HFHelpList](){
        didSet{
            self.tableView.reloadData()

        }
    }
    var title:String?{
        didSet{
            self.titleLabel.text = title
            
        }
    }
    // MARK: - Subviews
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "常见问题"
        label.numberOfLines = 0
        label.textColor = UIColor(hex:0x333333FF)
        label.font = UIFont.systemFont(ofSize: 18,weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //主视图
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return  view
    }()
    // 懒加载的 TableView
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomerServicePagerItemViewCell.self, forCellReuseIdentifier: CustomerServicePagerItemViewCell.cellIdentifier())

        return tableView
    }()
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with tableView: UITableView) -> CustomerServicePagerViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CustomerServicePagerViewCell { return cell }
        return CustomerServicePagerViewCell(style: .default, reuseIdentifier: identifier)
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
private extension CustomerServicePagerViewCell {
    
    private func setupSubviews() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.contentView.addSubview(containerView)
        self.containerView.addSubview(self.titleLabel)
        self.containerView.addSubview(self.tableView)

    }
    
    private func setupLayout() {
        containerViewHeight = containerView.heightAnchor.constraint(equalToConstant: 342)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            containerViewHeight
        ])
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 14),
            titleLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -20),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -20),
        ])
    }
    
}

// MARK: - Public
extension CustomerServicePagerViewCell {
    
}

// MARK: - Action
@objc private extension CustomerServicePagerViewCell {
    
}

// MARK: - Private
private extension CustomerServicePagerViewCell {
    
}
