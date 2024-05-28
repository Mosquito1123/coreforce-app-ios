//
//  MainScanItemView.swift
//  hfpower
//
//  Created by EDY on 2024/5/28.
//

import UIKit
import ESTabBarController_swift

class MainScanItemView: ESTabBarItemContentView {

    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var mainView:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 97.0/2
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var scanButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("扫码租电", for: .normal)
        button.setImage(UIImage(named: "scan"), for: .normal)
        button.setBackgroundImage(UIColor(named: "22C788")?.toImage(), for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 38
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.insets = UIEdgeInsets.init(top: -32, left: 0, bottom: 0, right: 0)

        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        scanButton.setImagePosition(type: .imageTop, Space: 4)

    }
}

// MARK: - Setup
private extension MainScanItemView {
    
    private func setupSubviews() {
        addSubview(mainView)
        addSubview(scanButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            mainView.widthAnchor.constraint(equalToConstant: 97),
            mainView.heightAnchor.constraint(equalToConstant: 97),
            mainView.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: 11),
            mainView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            scanButton.widthAnchor.constraint(equalToConstant: 76),
            scanButton.heightAnchor.constraint(equalToConstant: 76),
            scanButton.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: 11),
            scanButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
        

    }
    
}

// MARK: - Public
extension MainScanItemView {
    
}

// MARK: - Action
@objc private extension MainScanItemView {
    
}

// MARK: - Private
private extension MainScanItemView {
    
}
