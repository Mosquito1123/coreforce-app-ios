//
//  LogoffTableHeaderView.swift
//  hfpower
//
//  Created by EDY on 2024/7/9.
//

import UIKit

class LogoffTableHeaderView: UIView {
    
    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logoff_warning")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    lazy var dashedLineView1: DashedLineView = {
        let view = DashedLineView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "注销须知"
        label.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dashedLineView2: DashedLineView = {
        let view = DashedLineView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder:coder)
    }
    
}

// MARK: - Setup
private extension LogoffTableHeaderView {
    
    private func setupSubviews() {
        self.addSubview(self.iconImageView)
        self.addSubview(self.dashedLineView1)
        self.addSubview(self.titleLabel)
        self.addSubview(self.dashedLineView2)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            self.iconImageView.widthAnchor.constraint(equalToConstant: 56),
            self.iconImageView.heightAnchor.constraint(equalToConstant: 47),
            self.iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.iconImageView.topAnchor.constraint(equalTo: self.topAnchor,constant: 30),
            self.iconImageView.bottomAnchor.constraint(equalTo: self.titleLabel.topAnchor,constant: -30),
            self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            // DashedLineView1 Constraints
            dashedLineView1.widthAnchor.constraint(equalToConstant: 100),
            dashedLineView1.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            dashedLineView1.heightAnchor.constraint(equalToConstant: 1),
            titleLabel.leadingAnchor.constraint(equalTo: dashedLineView1.trailingAnchor, constant: 12),
            
            // DashedLineView2 Constraints
            dashedLineView2.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 12),
            dashedLineView2.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            dashedLineView2.heightAnchor.constraint(equalToConstant: 1),
            dashedLineView2.widthAnchor.constraint(equalToConstant: 100),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14),

        ])
    }
    
}

// MARK: - Public
extension LogoffTableHeaderView {
    
}

// MARK: - Action
@objc private extension LogoffTableHeaderView {
    
}

// MARK: - Private
private extension LogoffTableHeaderView {
    
}
class DashedLineView: UIView {
    
    var dashColor: UIColor = UIColor(red: 134/255, green: 144/255, blue: 156/255, alpha: 1.0)
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setLineWidth(1.0)
        context.setStrokeColor(dashColor.cgColor)
        
        let dashPattern: [CGFloat] = [4, 2] // Dash pattern: 4 points solid, 2 points space
        context.setLineDash(phase: 0, lengths: dashPattern)
        context.move(to: CGPoint(x: 0, y: rect.height / 2))
        context.addLine(to: CGPoint(x: rect.width, y: rect.height / 2))
        context.strokePath()
    }
}
