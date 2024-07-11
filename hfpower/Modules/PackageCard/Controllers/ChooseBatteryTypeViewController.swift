//
//  ChooseBatteryTypeViewController.swift
//  hfpower
//
//  Created by EDY on 2024/7/11.
//

import UIKit
import JXSegmentedView
class ChooseBatteryTypeViewController: BaseViewController {
    
    // MARK: - Accessor
    var segmentedDataSource: JXSegmentedBaseDataSource?
    let segmentedView = JXSegmentedView()
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    // MARK: - Subviews

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    
}

// MARK: - Setup
private extension ChooseBatteryTypeViewController {
    
    private func setupNavbar() {
        self.title = "选择电池型号"
    }
   
    private func setupSubviews() {
        self.view.backgroundColor = UIColor(rgba:0xF7F7F7FF)
        let dataSource = JXSegmentedDotDataSource()
        dataSource.isTitleColorGradientEnabled = true
        dataSource.titleSelectedColor = UIColor(rgba: 0x3171EFFF)
        dataSource.titleNormalColor = UIColor(rgba: 0x666666FF)
        dataSource.titleSelectedFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        dataSource.titleNormalFont = UIFont.systemFont(ofSize: 15)
        
        dataSource.isTitleStrokeWidthEnabled = true
        dataSource.isSelectedAnimable = true
        dataSource.titles = ["全部","48V","60V"]
        dataSource.dotStates = [false,false, false]
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorColor = .clear
        indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
        segmentedView.indicators = [indicator]
        segmentedDataSource = dataSource
        segmentedView.dataSource = segmentedDataSource
        segmentedView.delegate = self
        segmentedView.backgroundColor = .white
        segmentedView.defaultSelectedIndex = 0
        segmentedView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedView)
        listContainerView.translatesAutoresizingMaskIntoConstraints = false
        segmentedView.listContainer = listContainerView
        view.addSubview(listContainerView)

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            self.segmentedView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.segmentedView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.segmentedView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.segmentedView.heightAnchor.constraint(equalToConstant: 50),
            self.listContainerView.topAnchor.constraint(equalTo: self.segmentedView.bottomAnchor),
            self.listContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.listContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.listContainerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),



        ])
    }
}

// MARK: - Public
extension ChooseBatteryTypeViewController: JXSegmentedViewDelegate {
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

extension ChooseBatteryTypeViewController: JXSegmentedListContainerViewDataSource {
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

// MARK: - Request
private extension ChooseBatteryTypeViewController {
    
}

// MARK: - Action
@objc private extension ChooseBatteryTypeViewController {
    
}

// MARK: - Private
private extension ChooseBatteryTypeViewController {
    
}
