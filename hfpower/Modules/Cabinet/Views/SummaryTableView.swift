//
//  SummaryTableView.swift
//  hfpower
//
//  Created by EDY on 2024/6/4.
//

import UIKit

class SummaryTableView: UIView {
    
    // MARK: - Accessor
    var items:[[String]] = [[]]{
        didSet{
            stackView.arrangedSubviews.forEach { view in
                if view.tag != 99{
                    stackView.removeArrangedSubview(view)
                    view.removeFromSuperview()
                }
               
            }
            for i in 0..<items.count{
                let rowStackView = createRow(rowIndex: i,items: items)
                stackView.addArrangedSubview(rowStackView)
            }
        }
    }
    // MARK: - Subviews
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func createRow(rowIndex: Int,items:[[String]]) -> UIStackView {
        let rowStackView = UIStackView()
        rowStackView.axis = .horizontal
        rowStackView.distribution = .fillEqually
        rowStackView.spacing = 1
        rowStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rowStackView.heightAnchor.constraint(equalToConstant: 34)
        ])
        for columnIndex in 0..<items[rowIndex].count {
            let cell = createCell(row: rowIndex, column: columnIndex,items: items)
            rowStackView.addArrangedSubview(cell)
        }
        
        return rowStackView
    }
    
    func createCell(row: Int, column: Int,items:[[String]]) -> UIView {
        let cellView = UIView()
        cellView.backgroundColor = .white
        
        let label = UILabel()
        label.text = items[row][column]
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        if column == 1{
            label.textColor = UIColor(hex:0x26B01EFF)
        }else{
            label.textColor = UIColor(hex:0x1D2129FF)

        }
        label.translatesAutoresizingMaskIntoConstraints = false
        
        cellView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: cellView.centerYAnchor)
        ])
        
        return cellView
    }
}

// MARK: - Setup
private extension SummaryTableView {
    
    private func setupSubviews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackView)
        
        let headerView = GradientHeaderView()
        headerView.items = ["电池型号","可换电池","电量>90%"]
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        headerView.tag = 99
        stackView.addArrangedSubview(headerView)
        for rowIndex in 0..<2 {
            let rowStackView = createRow(rowIndex: rowIndex)
            stackView.addArrangedSubview(rowStackView)
        }
        
        
        
    }
    func createRow(rowIndex: Int) -> UIStackView {
        let rowStackView = UIStackView()
        rowStackView.axis = .horizontal
        rowStackView.distribution = .fillEqually
        rowStackView.spacing = 1
        rowStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rowStackView.heightAnchor.constraint(equalToConstant: 34)
        ])
        for columnIndex in 0..<3 {
            let cell = createCell(row: rowIndex, column: columnIndex)
            rowStackView.addArrangedSubview(cell)
        }
        
        return rowStackView
    }
    
    func createCell(row: Int, column: Int) -> UIView {
        let cellView = UIView()
        cellView.backgroundColor = .white
        
        let label = UILabel()
        label.text = "R\(row+1)C\(column+1)"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        if column == 1{
            label.textColor = UIColor(hex:0x26B01EFF)
        }else{
            label.textColor = UIColor(hex:0x1D2129FF)

        }
        label.translatesAutoresizingMaskIntoConstraints = false
        
        cellView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: cellView.centerYAnchor)
        ])
        
        return cellView
    }
    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
}

// MARK: - Public
extension SummaryTableView {
    
}

// MARK: - Action
@objc private extension SummaryTableView {
    
}

// MARK: - Private
private extension SummaryTableView {
    
}
class GradientHeaderView: UIView {
    var items:[String] = []{
        didSet{
            if  let stackView = self.viewWithTag(99) as? UIStackView{
                stackView.arrangedSubviews.forEach { view in
                    stackView.removeArrangedSubview(view)
                    view.removeFromSuperview()
                }
                for i in 0..<items.count {
                    let label = UILabel()
                    label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
                    label.textColor = UIColor(hex:0x1D2129FF)
                    label.text = items[i]
                    label.textAlignment = .center
                    stackView.addArrangedSubview(label)
                }
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientBackground()
        setupHeaderLabels()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradientBackground()
        setupHeaderLabels()
    }
    
    private func setupGradientBackground() {
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor(red: 0.95, green: 0.96, blue: 0.98, alpha: 0).cgColor, UIColor(red: 0.97, green: 0.97, blue: 0.98, alpha: 1).cgColor, UIColor(red: 0.97, green: 0.97, blue: 0.99, alpha: 1).cgColor, UIColor(red: 0.97, green: 0.97, blue: 0.98, alpha: 1).cgColor, UIColor(red: 0.95, green: 0.96, blue: 0.98, alpha: 0).cgColor]
        bgLayer1.locations = [0, 0.06, 0.49, 0.94, 1]
        bgLayer1.frame = self.bounds
        bgLayer1.startPoint = CGPoint(x: 0, y: 0.5)
        bgLayer1.endPoint = CGPoint(x: 0.5, y: 0.5)
   
        
       
        self.layer.insertSublayer(bgLayer1, at: 0)
    }
    
    private func setupHeaderLabels() {
        let headerStackView = UIStackView()
        headerStackView.axis = .horizontal
        headerStackView.distribution = .fillEqually
        headerStackView.spacing = 1
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.tag = 99
        for i in 1...3 {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            label.textColor = UIColor(hex:0x1D2129FF)
            label.text = "Header \(i)"
            label.textAlignment = .center
            headerStackView.addArrangedSubview(label)
        }
        
        addSubview(headerStackView)
        
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: self.topAnchor),
            headerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.sublayers?.first?.frame = self.bounds
    }
}
