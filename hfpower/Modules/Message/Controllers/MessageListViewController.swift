//
//  MessageListViewController.swift
//  hfpower
//
//  Created by EDY on 2024/9/14.
//

import UIKit
import MJRefresh

class MessageListViewController: BaseTableViewController<MessageListViewCell,HFMessageData> {
    
    // MARK: - Accessor
    var pageNum = 1
    var pageCount = 1
    // MARK: - Subviews

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSubviews()
        setupLayout()
        // 初始化 TableView 的刷新控件
        setupRefreshControls()
        loadData()
    }
    
    func setupRefreshControls() {
        // 下拉刷新
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRefreshing))
        
        // 上拉加载更多
        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(footerRefreshing))
    }
    func loadData() {
        getData(memberMsgUrl, param: ["page": 1], isLoading: true, success: { responseObject in
            if let body = (responseObject  as? [String: Any])?["body"] as? [String: Any],
               let pageResult = body["pageResult"] as? [String: Any],
               let dataList = pageResult["dataList"] as? [[String: Any]] {

                self.items = (HFMessageData.mj_objectArray(withKeyValuesArray: dataList) as? [HFMessageData]) ?? []
                self.pageNum = 1

                if let total = pageResult["total"] as? NSNumber,
                   let size = pageResult["size"] as? NSNumber {
                    self.pageCount = Int(ceil(total.doubleValue / size.doubleValue))
                }

                self.tableView.mj_footer?.resetNoMoreData()
            }
        }, error: { error in
            self.showError(withStatus: error.localizedDescription)
            self.pageNum = 1
            self.pageCount = 1
            self.tableView.mj_footer?.resetNoMoreData()
        })
    }

    @objc func headerRefreshing() {
        self.items.removeAll()
        self.pageNum = 1

        getData(memberMsgUrl, param: ["page": 1], isLoading: true, success: { responseObject in
            if let body = (responseObject  as? [String: Any])?["body"] as? [String: Any],
               let pageResult = body["pageResult"] as? [String: Any],
               let dataList = pageResult["dataList"] as? [[String: Any]] {

                self.items = (HFMessageData.mj_objectArray(withKeyValuesArray: dataList) as? [HFMessageData]) ?? []
                self.pageNum = 1

                if let total = pageResult["total"] as? NSNumber,
                   let size = pageResult["size"] as? NSNumber {
                    self.pageCount = Int(ceil(total.doubleValue / size.doubleValue))
                }

                self.tableView.mj_header?.endRefreshing()
                self.tableView.mj_footer?.resetNoMoreData()
            }
        }, error: { error in
            self.showError(withStatus: error.localizedDescription)
            self.pageNum = 1
            self.pageCount = 1
            self.tableView.mj_header?.endRefreshing()
            self.tableView.mj_footer?.resetNoMoreData()
        })
    }

    @objc func footerRefreshing() {

        if (pageNum + 1) > pageCount {
            self.tableView.mj_footer?.endRefreshingWithNoMoreData()
            return
        }

        pageNum += 1

        getData(memberMsgUrl, param: ["page": pageNum], isLoading: true, success: { responseObject in
            if let body = (responseObject  as? [String: Any])?["body"] as? [String: Any],
               let pageResult = body["pageResult"] as? [String: Any],
               let dataList = pageResult["dataList"] as? [[String: Any]] {

                let newMessages = (HFMessageData.mj_objectArray(withKeyValuesArray: dataList) as? [HFMessageData]) ?? []
                self.items.append(contentsOf: newMessages)

                self.tableView.reloadData()
                self.tableView.mj_footer?.endRefreshing()
            }
        }, error: { error in
            self.showError(withStatus: error.localizedDescription)
            self.tableView.mj_footer?.endRefreshing()
        })
    }

}

// MARK: - Setup
private extension MessageListViewController {
    
    private func setupNavbar() {
        self.title = "消息列表"
    }
    
    private func setupSubviews() {
        self.view.backgroundColor = UIColor(rgba: 0xF6F6F6FF)
        self.tableView.backgroundColor = UIColor(rgba: 0xF6F6F6FF)
        self.view.addSubview(self.tableView)
        
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
    }
}

// MARK: - Public
extension MessageListViewController {
    
}

// MARK: - Request
private extension MessageListViewController {
    
}

// MARK: - Action
@objc private extension MessageListViewController {
    
}

// MARK: - Private
private extension MessageListViewController {
    
}
