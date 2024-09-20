//
//  SearchCabinetListHeaderView.swift
//  hfpower
//
//  Created by EDY on 2024/5/30.
//

import UIKit

class SearchCabinetListHeaderView: UIView {
    override var intrinsicContentSize: CGSize {
       return UIView.layoutFittingExpandedSize
     }
    // MARK: - Accessor
    var backAction:ButtonActionBlock?
    // MARK: - Subviews
//    lazy var backButton: UIButton = {
//        let button = UIButton(type: .custom)
//        button.setImage(UIImage(named: "back_arrow"), for: .normal)
//        button.addTarget(self, action: #selector(backButtonTapped(_:)), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    lazy var searchView:SearchView = {
        let view = SearchView()
        view.searchIconImage = UIImage(named: "search_list_icon_search")
        view.showRightView = false
        view.backgroundColor = UIColor(hex:0xF7F8FAFF)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var relocatedView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white

        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Setup
private extension SearchCabinetListHeaderView {
    
    private func setupSubviews() {
//        addSubview(backButton)
        addSubview(searchView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            searchView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 16),
//            backButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            backButton.widthAnchor.constraint(equalToConstant: 20),
//            backButton.heightAnchor.constraint(equalToConstant: 20),
//            backButton.trailingAnchor.constraint(equalTo: searchView.leadingAnchor,constant: -8),
            searchView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            searchView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -14),
            searchView.heightAnchor.constraint(equalToConstant: 44),



            
        ])
        
    }
    
}

// MARK: - Public
extension SearchCabinetListHeaderView {
    
}

// MARK: - Action
@objc private extension SearchCabinetListHeaderView {
    @objc func backButtonTapped(_ sender:UIButton){
        self.backAction?(sender)
        
    }
}

// MARK: - Private
private extension SearchCabinetListHeaderView {
    
}
class SearchCabinetListHeaderViewSearchView {
    
}
