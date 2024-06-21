//
//  ChartMainView.swift
//  hfpower
//
//  Created by EDY on 2024/6/21.
//

import UIKit
import DGCharts

class ChartMainView: UIView {

    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var contentView: LineChartView = {
        let chartView = LineChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        return chartView
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Setup
private extension ChartMainView {
    
    private func setupSubviews() {
        self.addSubview(contentView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 14),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -14),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -14),
            contentView.topAnchor.constraint(equalTo: self.topAnchor,constant: 14),

        ])
    }
    
}

// MARK: - Public
extension ChartMainView {
    
}

// MARK: - Action
@objc private extension ChartMainView {
    
}

// MARK: - Private
private extension ChartMainView {
    
}
