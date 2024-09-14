//
//  CabinetPanelViewController.swift
//  hfpower
//
//  Created by EDY on 2024/6/19.
//

import UIKit

class CabinetPanelViewController: UIViewController {
    
    // MARK: - Accessor
    var annotation:CabinetAnnotation?{
        didSet{
            self.cabinetPanelView.titleLabel.text = annotation?.cabinet?.number
            self.cabinetPanelView.locationLabel.text = annotation?.cabinet?.location
            self.cabinetPanelView.statisticView.batteryListView.onLine = annotation?.cabinet?.onLine.boolValue ?? false
            self.cabinetPanelView.rentStatusButton.isHidden = !(annotation?.cabinet?.rentReturnBattery.boolValue ?? true)
            self.cabinetPanelView.depositStatusButton.isHidden = !(annotation?.cabinet?.rentReturnBattery.boolValue ?? true)
            let topThree = (annotation?.cabinet?.topThreeGrids as? [HFGridList]) ?? []
            self.cabinetPanelView.statisticView.batteryListView.batteryLevels = topThree.map { CGFloat($0.batteryCapacityPercent.doubleValue)/100.0 }
            let extraInfos = (annotation?.cabinet?.extraInfo as? [HFCabinetExtraInfo]) ?? []
            self.cabinetPanelView.statisticView.summaryTableView.items = extraInfos.map { [$0.largeTypeName,$0.changeCount.stringValue,$0.count.stringValue] }
            guard let sourceCoordinate = mapController?.mapView.userLocation.location?.coordinate else {return} // 起点
            guard let destinationCoordinate = annotation?.coordinate else {return}
            self.mapController?.calculateCyclingTime(from: sourceCoordinate, to: destinationCoordinate, completion: { response, error in
                guard let response = response, let route = response.routes.first else {
                    print("Error calculating directions: \(String(describing: error))")
                    return
                }
                
                let walkingTimeInSeconds = route.expectedTravelTime
                let cyclingTimeInSeconds = walkingTimeInSeconds / 4.5 // 假设电动车速度是步行的 4.5 倍
                
                // 时间格式化// 距离格式化
                let cyclingTimeFormatted = String.formatTime(seconds: cyclingTimeInSeconds) 
                let distanceFormatted = String.formatDistance(meters: route.distance)
                self.cabinetPanelView.rideLabel.text = "\(distanceFormatted) · 骑行\(cyclingTimeFormatted)"

                
                
               
                
                
            })
        }
    }
    var mapController:MapViewController?
    var navigateAction:ButtonActionBlock?
    var scanAction:ButtonActionBlock?
    var dropDownAction:ButtonActionBlock?
    var detailAction:ButtonActionBlock?
    var giftAction:ButtonActionBlock?{
        didSet{
            self.cabinetPanelView.giftAction = giftAction
        }
    }
    // MARK: - Subviews
    lazy var cabinetPanelView: CabinetPanelView = {
        var panelView = CabinetPanelView()
        panelView.translatesAutoresizingMaskIntoConstraints = false
        return panelView
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        setupNavbar()
        setupSubviews()
        setupLayout()
    }
   
    
}

// MARK: - Setup
private extension CabinetPanelViewController {
    
    private func setupNavbar() {
        
    }
   
    private func setupSubviews() {
        view.backgroundColor = .white
        view.addSubview(self.cabinetPanelView)
        self.cabinetPanelView.statisticView.showTop = true
        self.cabinetPanelView.navigateAction = self.navigateAction
        self.cabinetPanelView.scanAction = self.scanAction
        self.cabinetPanelView.detailAction = self.detailAction
        self.cabinetPanelView.dropDownAction = self.dropDownAction

    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            cabinetPanelView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            cabinetPanelView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            cabinetPanelView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            cabinetPanelView.topAnchor.constraint(equalTo: self.view.topAnchor),

        ])
    }
}

// MARK: - Public
extension CabinetPanelViewController {
    
}

// MARK: - Request
private extension CabinetPanelViewController {
    
}

// MARK: - Action
@objc private extension CabinetPanelViewController {
    
}

// MARK: - Private
private extension CabinetPanelViewController {
    
}
