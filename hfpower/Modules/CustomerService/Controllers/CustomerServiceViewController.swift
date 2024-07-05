//
//  CustomerServiceViewController.swift
//  hfpower
//
//  Created by EDY on 2024/5/29.
//

import UIKit
import JXSegmentedView
class CustomerServiceViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Accessor
    var contactAction:ButtonActionBlock?
    var segmentedDataSource: JXSegmentedBaseDataSource?
        let segmentedView = JXSegmentedView()
        lazy var listContainerView: JXSegmentedListContainerView! = {
            return JXSegmentedListContainerView(dataSource: self)
        }()
    // MARK: - Subviews
    lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "customer_service_background")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var contactButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("联系我们", for: .normal)
        button.setTitleColor(UIColor(rgba: 0x447AFEFF), for: .normal)
        button.setTitleColor(UIColor(rgba: 0x447AFEFF), for: .selected)
        button.setImage(UIImage(named: "customer_service_phone"), for: .normal)
        button.setImage(UIImage(named: "customer_service_phone"), for: .highlighted)
        button.setImage(UIImage(named: "customer_service_phone"), for: .selected)

        button.titleLabel?.font = UIFont.systemFont(ofSize: 16,weight: .medium)
        button.setBackgroundImage(UIColor.white.toImage(), for: .normal)
        button.setBackgroundImage(UIColor.white.withAlphaComponent(0.5).toImage(), for: .highlighted)
        button.setBackgroundImage(UIColor.white.toImage(), for: .selected)
        button.setBackgroundImage(UIColor.white.toImage(), for: .disabled)
        button.layer.cornerRadius = 24.5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(onCalled(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(rgba:0xF7F7F7FF)
        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        // 设置导航栏颜色
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
            navigationBar.tintColor = UIColor.white  // 设置导航栏按钮颜色
            
            // 设置标题字体和颜色
            let titleAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 18,weight: .semibold)
            ]
            navigationBar.titleTextAttributes = titleAttributes
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 恢复导航栏颜色
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.setBackgroundImage(nil, for: .default)
            navigationBar.shadowImage = nil
            navigationBar.tintColor = nil  // 恢复默认按钮颜色
            
            // 恢复标题字体和颜色
            navigationBar.titleTextAttributes = nil
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contactButton.setImagePosition(type: .imageLeft, Space: 2)
    }
}

// MARK: - Setup
private extension CustomerServiceViewController {
    
    private func setupNavbar() {
        self.title = "核蜂客服"
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self;

        // 自定义返回按钮
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "customer_service_back"), for: .normal)  // 设置自定义图片
        backButton.setTitle("", for: .normal)  // 设置标题
        backButton.setTitleColor(.white, for: .normal)  // 设置标题颜色
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let backBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBarButtonItem
    }

    @objc func backButtonTapped() {
        // 返回按钮的点击事件处理
        self.navigationController?.popViewController(animated: true)
    }
   
    private func setupSubviews() {
        self.view.addSubview(self.backgroundImageView)
        let dataSource = JXSegmentedDotDataSource()
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titleSelectedColor = UIColor.white
        dataSource.titleNormalColor = UIColor.white.withAlphaComponent(0.7)
        dataSource.titleSelectedFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
        dataSource.titleNormalFont = UIFont.systemFont(ofSize: 15)

        dataSource.isTitleStrokeWidthEnabled = true
        dataSource.isSelectedAnimable = true
        dataSource.titles = ["常见问题","换电操作","电池问题","电柜问题","其他"]
        dataSource.dotStates = [false,false, false,false,false]
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorColor = .white
        indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
        segmentedView.indicators = [indicator]
        segmentedDataSource = dataSource
        segmentedView.dataSource = segmentedDataSource
        segmentedView.delegate = self
        segmentedView.defaultSelectedIndex = 0
        segmentedView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedView)
        listContainerView.translatesAutoresizingMaskIntoConstraints = false
        segmentedView.listContainer = listContainerView
        view.addSubview(listContainerView)
        view.addSubview(contactButton)
        self.view.bringSubviewToFront(contactButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            self.backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.backgroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.backgroundImageView.heightAnchor.constraint(equalToConstant: 300),
            self.segmentedView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.segmentedView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.segmentedView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.segmentedView.heightAnchor.constraint(equalToConstant: 50),
            self.listContainerView.topAnchor.constraint(equalTo: self.segmentedView.bottomAnchor),
            self.listContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.listContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.listContainerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.contactButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 16),
            self.contactButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -16),
            self.contactButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -29),
            self.contactButton.heightAnchor.constraint(equalToConstant: 50),


        ])
    }
}

// MARK: - Public
extension CustomerServiceViewController: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        if let dotDataSource = segmentedDataSource as? JXSegmentedDotDataSource {
            //先更新数据源的数据
            dotDataSource.dotStates[index] = false
            //再调用reloadItem(at: index)
            segmentedView.reloadItem(at: index)
        }

//        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }
}

extension CustomerServiceViewController: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        let pager = CustomerServicePagerView()
        pager.title = (segmentedView.dataSource as? JXSegmentedDotDataSource)?.titles[index]
        return pager
    }
}
extension CustomerServiceViewController {
    
}

// MARK: - Request
private extension CustomerServiceViewController {
    
}

// MARK: - Action
@objc private extension CustomerServiceViewController {
    @objc func onCalled(_ sender:UIButton){
        if let phoneURL = URL(string: "tel://400-6789-509"), UIApplication.shared.canOpenURL(phoneURL) {
            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        }
        self.contactAction?(sender)
    }
}

// MARK: - Private
private extension CustomerServiceViewController {
    
}
class CustomerServicePagerView:UIView,JXSegmentedListContainerViewListDelegate,UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomerServicePagerViewCell.cellIdentifier(), for: indexPath) as? CustomerServicePagerViewCell else {return UITableViewCell()}
        cell.title = self.title
        return cell
    }
    
    func listView() -> UIView {
        return self
    }
    var title:String?
    // MARK: - Subviews
    
    // 懒加载的 TableView
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomerServicePagerViewCell.self, forCellReuseIdentifier: CustomerServicePagerViewCell.cellIdentifier())

        return tableView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
    }
}
private extension CustomerServicePagerView{
    private func setupNavbar() {
    }
    private func setupSubviews() {
        self.addSubview(self.tableView)
      
    }
    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
