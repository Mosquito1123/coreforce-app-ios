//
//  CabinetAnnotationView.swift
//  hfpower
//
//  Created by EDY on 2024/6/12.
//

import UIKit
import MapKit
class CabinetAnnotationView: MKAnnotationView {

    // MARK: - Accessor
    override var annotation: MKAnnotation?{
        didSet{
            let cabinetAnnotation = annotation as? CabinetAnnotation
            mainButton.frame = CGRect(x: 0, y: 0, width: 40, height: 43)
            // 设置标题
            mainButton.titleLabel?.font = UIFont(name: "DIN Alternate Bold", size: 18)
            mainButton.setTitle("\(cabinetAnnotation?.cabinet?.batteryCount ?? 0)", for: .normal)
            mainButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)

            mainButton.setTitleColor(.white, for: .normal)
            if cabinetAnnotation?.cabinet?.onLine == true{
                mainButton.setBackgroundImage(UIImage(named: "online_annotation"), for: .normal)

            }else{
                mainButton.setBackgroundImage(UIImage(named: "offline_annotation"), for: .normal)

            }
            self.image = mainButton.asImage()
        }
    }
    
    // MARK: - Subviews
    lazy var mainButton: UIButton = {
        let button = UIButton(type:.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    // MARK: - Lifecycle
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        if #available(iOS 14.0, *) {
            self.zPriority = .defaultSelected
        } else {
            // Fallback on earlier versions
        }
        self.collisionMode = .circle
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.centerOffset = CGPoint(x: 0, y: -(self.image?.size.height ?? 0)/2)

    }
}

// MARK: - Setup
private extension CabinetAnnotationView {
    
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
    
}

// MARK: - Public
extension CabinetAnnotationView {
    
}

// MARK: - Action
@objc private extension CabinetAnnotationView {
    
}

// MARK: - Private
private extension CabinetAnnotationView {
    
}
