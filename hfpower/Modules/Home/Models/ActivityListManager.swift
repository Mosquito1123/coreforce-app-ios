//
//  ActivityListManager.swift
//  hfpower
//
//  Created by EDY on 2024/6/14.
//

import UIKit

class ActivityListManager: NSObject {
    
    // MARK: - Accessor
    static let shared = ActivityListManager()
    var activityList:[ActivityResponse]?
    // MARK: - Lifecycle
    override init() {
        super.init()
        
    }
    
}

// MARK: - Public
extension ActivityListManager {
    
}

// MARK: - Private
private extension ActivityListManager {
    
}
