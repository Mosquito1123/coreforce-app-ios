//
//  MapFeatureView.swift
//  hfpower
//
//  Created by EDY on 2024/5/29.
//

import UIKit
enum MapFeatureType {
    case list
    case locate
    case refresh
    case filter
}
extension MapFeatureType {
    func getValue() -> String {
        switch self {
        case .list:
            return "list"
        case .locate:
            return "locate"
        case .refresh:
            return "refresh"
        case .filter:
            return "filter"
        }
    }
}
typealias MapFeatureAction = (_ sender:UIButton,_ mapFeatureType:MapFeatureType?)->Void
class MapFeatureView: UIView {

    // MARK: - Accessor
    var mapFeatureType:MapFeatureType?
    var mapFeatureAction:MapFeatureAction?
    // MARK: - Subviews
    lazy var featureButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: - Lifecycle
   convenience init(_ mapFeatureType:MapFeatureType?,_ mapFeatureAction:MapFeatureAction?){
       self.init(frame:CGRect(x: 0, y: 0, width: 38, height: 38))
       self.mapFeatureType = mapFeatureType
       self.mapFeatureAction = mapFeatureAction
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        // fillCode
        self.backgroundColor = UIColor.white
        // shadowCode
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.07).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 6
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let type = mapFeatureType else { return  }
        featureButton.setImage(UIImage(named: type.getValue()), for:.normal )
        featureButton.setImage(UIImage(named: type.getValue()), for:.highlighted )
    }
}

// MARK: - Setup
private extension MapFeatureView {
    
    private func setupSubviews() {
        addSubview(featureButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 38),
            self.heightAnchor.constraint(equalToConstant: 38),
            featureButton.widthAnchor.constraint(equalToConstant: 21),
            featureButton.heightAnchor.constraint(equalToConstant: 21),
            featureButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            featureButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
}

// MARK: - Public
extension MapFeatureView {
    
}

// MARK: - Action
@objc private extension MapFeatureView {
    @objc func buttonAction(_ sender:UIButton){
        self.mapFeatureAction?(sender,self.mapFeatureType)
    }
}

// MARK: - Private
private extension MapFeatureView {
    
}
