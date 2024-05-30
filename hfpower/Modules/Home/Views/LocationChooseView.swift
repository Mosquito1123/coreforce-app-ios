//
//  LocationChooseView.swift
//  hfpower
//
//  Created by EDY on 2024/5/27.
//

import UIKit

class LocationChooseView: UIView {

    // MARK: - Accessor
    
    // MARK: - Subviews
    lazy var currentLocationButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("青岛市", for: .normal)
        button.setTitleColor(UIColor(named: "333333"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var currentLocationStatusButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(TriangleDrawer.drawDownwardTriangle(width: 7.9, height: 4.64,color: UIColor(named: "333333") ?? UIColor.black), for: .normal)
        button.setImage(TriangleDrawer.drawUpwardTriangle(width: 7.9, height: 4.64,color: UIColor(named: "333333") ?? UIColor.black), for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 22
        // shadowCode
        self.layer.shadowColor = UIColor(red: 0.39, green: 0.47, blue: 0.67, alpha: 0.06).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 20
        
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Setup
private extension LocationChooseView {
    
    private func setupSubviews() {
        addSubview(currentLocationButton)
        addSubview(currentLocationStatusButton)

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            currentLocationButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 14),
            currentLocationButton.trailingAnchor.constraint(equalTo: currentLocationStatusButton.leadingAnchor,constant: -2),
            currentLocationStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10),
            currentLocationButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            currentLocationStatusButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)

        ])
    }
    
}

// MARK: - Public
extension LocationChooseView {
    
}

// MARK: - Action
@objc private extension LocationChooseView {
    
}

// MARK: - Private
private extension LocationChooseView {
    
}
class TriangleDrawer {
    
    static func drawUpwardTriangle(width: CGFloat, height: CGFloat,color:UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        context.beginPath()
        context.move(to: CGPoint(x: width / 2, y: 0))
        context.addLine(to: CGPoint(x: 0, y: height))
        context.addLine(to: CGPoint(x: width, y: height))
        context.closePath()
        
        context.setFillColor(color.cgColor)
        context.fillPath()
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    static func drawDownwardTriangle(width: CGFloat, height: CGFloat,color:UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        context.beginPath()
        context.move(to: CGPoint(x: 0, y: 0))
        context.addLine(to: CGPoint(x: width, y: 0))
        context.addLine(to: CGPoint(x: width / 2, y: height))
        context.closePath()
        
        context.setFillColor(color.cgColor)
        context.fillPath()
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
