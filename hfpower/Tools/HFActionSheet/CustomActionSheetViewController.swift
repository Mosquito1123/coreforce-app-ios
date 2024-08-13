//
//  CustomActionSheetViewController.swift
//  hfpower
//
//  Created by EDY on 2024/7/18.
//

import UIKit
public typealias HandlerAction = (_ section:Int,_ row:Int) -> ()

class CustomActionSheetViewController: BaseViewController{
    
    // MARK: - Accessor
    var handler:HandlerAction?
    var items = [[NSAttributedString]](){
        didSet{
            self.tableView.reloadData()
        }
    }
    // MARK: - Subviews
    private lazy var mainView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: self.view.frame.maxY - 205, width: self.view.frame.width, height: 205))
        view.layer.cornerRadius = 16
        if #available(iOS 11.0, *) {
            view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
            // 处理不支持 `maskedCorners` 的 iOS 版本
        }
        view.clipsToBounds = true
        view.backgroundColor = UIColor(white: 1.0, alpha: 1.0) // 替换 `RGBA` 函数
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(HFActionSheetSectionFooterView.self, forHeaderFooterViewReuseIdentifier: HFActionSheetSectionFooterView.viewIdentifier())
        tableView.register(HFTitleTableViewCell.self, forCellReuseIdentifier: HFTitleTableViewCell.cellIdentifier())
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

// MARK: - Setup
private extension CustomActionSheetViewController {
    
    private func setupNavbar() {
        self.title = "支付方式"
    }
   
    private func setupSubviews() {
        self.view.backgroundColor = .clear

        self.view.addSubview(self.mainView)
        self.mainView.addSubview(self.tableView)
        self.view.isUserInteractionEnabled = true
//        let tap = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(_:)))
//        tap.delegate = self
//        self.view.addGestureRecognizer(tap)

    }
    
    private func setupLayout() {
        // 设置 mainView 的约束
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            mainView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 205/812.0)
        ])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: mainView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }
}

// MARK: - Public
extension CustomActionSheetViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.handler?(indexPath.section,indexPath.row)
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return HFActionSheetSectionFooterView.view(with: tableView)
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0{
            return 8
        }else{
            return 0
        }
    }
    
}
extension CustomActionSheetViewController:UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HFTitleTableViewCell.cellIdentifier(), for: indexPath) as? HFTitleTableViewCell else {return UITableViewCell()}
        cell.titleLabel.attributedText = self.items[indexPath.section][indexPath.row]
        return cell
    }
    
    
}

// MARK: - Request
private extension CustomActionSheetViewController {
    
}

// MARK: - Action
@objc private extension CustomActionSheetViewController {
    @objc func backgroundTapped(_ tap:UITapGestureRecognizer){
        self.dismiss(animated: true)
    }
}

// MARK: - Private
private extension CustomActionSheetViewController {
    
}
class HFTitleTableViewCell: UITableViewCell {
    
    // MARK: - Accessor
    var lineHeight:NSLayoutConstraint!
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var lineView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgba: 0xF7F8FAFF)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // MARK: - Subviews
    
    // MARK: - Static
    class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    class func cell(with tableView: UITableView) -> HFTitleTableViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? HFTitleTableViewCell { return cell }
        return HFTitleTableViewCell(style: .default, reuseIdentifier: identifier)
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
private extension HFTitleTableViewCell {
    
    private func setupSubviews() {
        self.contentView.addSubview(self.lineView)
        self.contentView.addSubview(self.titleLabel)
        self.backgroundColor = UIColor.white
    }
    
    private func setupLayout() {
        lineHeight = lineView.heightAnchor.constraint(equalToConstant: 1)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 14.5),
            titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -17),
            lineView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),

            lineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            lineHeight
            

        ])
    }
    
}

// MARK: - Public
extension HFTitleTableViewCell {
    
}

// MARK: - Action
@objc private extension HFTitleTableViewCell {
    
}

// MARK: - Private
private extension HFTitleTableViewCell {
    
}

class HFActionSheetSectionFooterView: UITableViewHeaderFooterView {

    // MARK: - Accessor
    var lineHeight:NSLayoutConstraint!

    // MARK: - Subviews
    lazy var lineView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgba: 0xF7F8FAFF)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // MARK: - Lifecycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    class func viewIdentifier() -> String {
        return String(describing: self)
    }
    class func viewHeight() -> CGFloat{
        return 8
    }
    
    class func view(with tableView: UITableView) -> HFActionSheetSectionFooterView {
        let identifier = viewIdentifier()
        if let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? HFActionSheetSectionFooterView { return cell }
        return HFActionSheetSectionFooterView(reuseIdentifier: identifier)
    }
}

// MARK: - Setup
private extension HFActionSheetSectionFooterView {
    
    private func setupSubviews() {
        self.contentView.addSubview(lineView)
    }
    
    private func setupLayout() {
//        lineHeight = lineView.heightAnchor.constraint(equalToConstant: 8)

        NSLayoutConstraint.activate([
            lineView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            lineView.topAnchor.constraint(equalTo: contentView.topAnchor),

            lineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            lineHeight
        
        ])
    }
    
}

// MARK: - Public
extension HFActionSheetSectionFooterView {
    
}

// MARK: - Action
@objc private extension HFActionSheetSectionFooterView {
    
}

// MARK: - Private
private extension HFActionSheetSectionFooterView {
    
}
