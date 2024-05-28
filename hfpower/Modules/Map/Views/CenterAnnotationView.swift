//
//  CenterAnnotationView.swift
//  hfpower
//
//  Created by EDY on 2024/5/28.
//

import UIKit
import MapKit
class CenterAnnotationView: MKAnnotationView {

    // MARK: - Accessor
    override var annotation: MKAnnotation?{
        willSet{
            
        }
    }
    // MARK: - Subviews

    // MARK: - Lifecycle
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Setup
private extension CenterAnnotationView {
    
    private func setupSubviews() {
        self.image = UIImage(named: "center_point")

    }
    
    private func setupLayout() {
        
    }
    
}

// MARK: - Public
extension CenterAnnotationView {
    
}

// MARK: - Action
@objc private extension CenterAnnotationView {
    
}

// MARK: - Private
private extension CenterAnnotationView {
    
}
