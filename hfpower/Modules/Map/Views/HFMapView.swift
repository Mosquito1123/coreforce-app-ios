//
//  HFMapView.swift
//  hfpower
//
//  Created by EDY on 2024/5/29.
//

import UIKit
import MapKit
typealias CenterCoordinateCallBack = (CLLocationCoordinate2D)->Void
typealias RegionCallBack = (MKCoordinateRegion)->Void

class HFMapView: MKMapView {

    // MARK: - Accessor
    var regionCallBack:RegionCallBack?
    
   
    // MARK: - Subviews

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupLayout()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Setup
private extension HFMapView {
    
    private func setupSubviews() {
        
    }
    
    private func setupLayout() {
        
    }
    
}

// MARK: - Public
extension HFMapView {
    
}

// MARK: - Action
@objc private extension HFMapView {
    
}

// MARK: - Private
private extension HFMapView {
    
}
