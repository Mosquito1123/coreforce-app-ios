//
//  CabinetDetailContentViewController.swift
//  hfpower
//
//  Created by EDY on 2024/6/20.
//

import UIKit
import DGCharts

class CabinetDetailContentViewController: UIViewController {
    
    // MARK: - Accessor
    var cabinetExchangeForecastDatas:[HFCabinetExchangeForecast]?{
        didSet{
            
            let maxY = cabinetExchangeForecastDatas?.max(by: { $0.count.doubleValue < $1.count.doubleValue })?.count.doubleValue ?? 0

            if let chartDataEntrys = cabinetExchangeForecastDatas?.map({ data in
                if data.count.doubleValue == maxY{
                    return ChartDataEntry(x: data.hh.doubleValue , y: data.count.doubleValue ,icon: UIImage(named: "max_value"))

                }else{
                    return ChartDataEntry(x: data.hh.doubleValue , y: data.count.doubleValue )

                }
            }){
                
                let chartDataSet = LineChartDataSet(entries: chartDataEntrys)
                chartDataSet.mode = .cubicBezier
                chartDataSet.cubicIntensity = 0.2
                
                chartDataSet.colors = [UIColor(rgba:0x447AFEFF)]
                let gradientColors = [UIColor(rgba:0x447AFEFF).cgColor,
                                      UIColor(rgba:0x447AFEFF).withAlphaComponent(0).cgColor]
                let colorLocations: [CGFloat] = [1.0, 0.0] // 渐变位置
                
                let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors as CFArray, locations: colorLocations)!
                
                chartDataSet.fill = LinearGradientFill(gradient: gradient,angle: 90)
                chartDataSet.drawFilledEnabled = true
                let nextMultipleOfFive = (ceil(maxY / 5) * 5) + 5
                chartDataSet.drawCirclesEnabled = false
                chartDataSet.drawIconsEnabled = true
                let data = LineChartData(dataSet: chartDataSet)
                
                self.cabinetDetailContentView.chartView.contentView.data = data
                self.cabinetDetailContentView.chartView.contentView.rightAxis.enabled = false
                self.cabinetDetailContentView.chartView.contentView.leftAxis.axisMaximum = nextMultipleOfFive
                self.cabinetDetailContentView.chartView.contentView.leftAxis.axisMinimum = 0
                self.cabinetDetailContentView.chartView.contentView.leftAxis.granularity = 5
                self.cabinetDetailContentView.chartView.contentView.leftAxis.granularityEnabled = true
                self.cabinetDetailContentView.chartView.contentView.leftAxis.labelFont = UIFont.systemFont(ofSize: 10, weight: .light)
                self.cabinetDetailContentView.chartView.contentView.leftAxis.labelTextColor = UIColor(rgba:0x4D4D4DFF)
                self.cabinetDetailContentView.chartView.contentView.xAxis.axisMaximum = 24
                self.cabinetDetailContentView.chartView.contentView.xAxis.axisMinimum = 0
                self.cabinetDetailContentView.chartView.contentView.xAxis.labelFont = UIFont.systemFont(ofSize: 10, weight: .light)
                self.cabinetDetailContentView.chartView.contentView.xAxis.drawGridLinesEnabled = false
                self.cabinetDetailContentView.chartView.contentView.xAxis.axisLineColor = UIColor(rgba:0x447AFEFF).withAlphaComponent(0.3) .withAlphaComponent(0.3)
                self.cabinetDetailContentView.chartView.contentView.xAxis.granularity = 4
                self.cabinetDetailContentView.chartView.contentView.xAxis.granularityEnabled = true
                self.cabinetDetailContentView.chartView.contentView.xAxis.valueFormatter = TimeValueFormatter()
                self.cabinetDetailContentView.chartView.contentView.xAxis.labelPosition = .bottom
                self.cabinetDetailContentView.chartView.contentView.xAxis.labelTextColor = UIColor(rgba:0x4D4D4DFF)
                self.cabinetDetailContentView.chartView.contentView.leftAxis.drawAxisLineEnabled = false
                self.cabinetDetailContentView.chartView.contentView.leftAxis.drawGridLinesEnabled = false
                
                
                
                
            }
        }
    }
    // MARK: - Subviews
    lazy var cabinetDetailContentView:CabinetDetailContentView = {
        let view = CabinetDetailContentView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupNavbar()
        setupSubviews()
        setupLayout()
    }
    
}

// MARK: - Setup
private extension CabinetDetailContentViewController {
    
    private func setupNavbar() {
        
    }
    
    private func setupSubviews() {
        self.view.addSubview(self.cabinetDetailContentView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            cabinetDetailContentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            cabinetDetailContentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            cabinetDetailContentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            cabinetDetailContentView.topAnchor.constraint(equalTo: self.view.topAnchor),
        ])
    }
}

// MARK: - Public
extension CabinetDetailContentViewController {
    
}

// MARK: - Request
private extension CabinetDetailContentViewController {
    
}

// MARK: - Action
@objc private extension CabinetDetailContentViewController {
    
}

// MARK: - Private
private extension CabinetDetailContentViewController {
    
}
// 自定义 X 轴格式化程序
class TimeValueFormatter: AxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let hour = Int(value) / 4 * 4 // 这里假设每个数据点间隔为 4 小时
        let minute = Int(value) % 4 * 15 // 每个数据点间隔为 4 小时
        return String(format: "%02d:%02d", hour, minute)
    }
}
