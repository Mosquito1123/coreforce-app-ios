//
//  PersonalDevicesViewCell.swift
//  hfpower
//
//  Created by EDY on 2024/6/24.
//

import UIKit

class PersonalDevicesViewCell: PersonalContentViewCell {
    
    // MARK: - Accessor
    var batteryDetailAction:((UITapGestureRecognizer)->Void)?{
        didSet{
            if let batteryNextIconView = self.batteryStackView.arrangedSubviews.last as? PersonalIconView{
                batteryNextIconView.nextAction = batteryDetailAction
            }
        }
    }
    var batteryRentAction:ButtonActionBlock?{
        didSet{
            self.batteryRentalView.sureAction = batteryRentAction
        }
    }
    var batteryRenewAction:ButtonActionBlock?{
        didSet{
            self.batteryExpirationView.sureAction = batteryRenewAction

        }
    }
    var bikeDetailAction:((UITapGestureRecognizer)->Void)?{
        didSet{
            if let bikeNextIconView = self.bikeStackView.arrangedSubviews.last as? PersonalIconView{
                bikeNextIconView.nextAction = bikeDetailAction
            }
        }
    }
    var bikeRentAction:ButtonActionBlock?{
        didSet{
            self.bikeRentalView.sureAction = bikeRentAction
        }
    }
    var bikeRenewAction:ButtonActionBlock?{
        didSet{
            self.bikeExpirationView.sureAction = bikeRenewAction
        }
    }
    var deviceTuple:(HFBatteryDetail?,HFBikeDetail?)?{
        didSet{
            for subview in self.stackView.arrangedSubviews {
                self.stackView.removeArrangedSubview(subview)
                subview.removeFromSuperview()
            }
            if let batteryDetail = deviceTuple?.0{
             
                self.stackView.addArrangedSubview(batteryStackView)
                if let view10 = batteryStackView.arrangedSubviews[0] as? PersonalIconView{
                    let percent = batteryDetail.mcuCapacityPercent?.doubleValue ?? 0

                      let imageName: String
                      switch percent {
                      case 80..<100:
                          imageName = "battery_4"
                      case 20..<80:
                          imageName = "battery_3"
                      case 0..<20:
                          imageName = "battery_2"
                      default:
                          imageName = "battery_5" // Handle unexpected values (optional)
                      }
                    view10.iconImageView.image = UIImage(named: imageName)
                }
                if let view11 = batteryStackView.arrangedSubviews[1] as? PersonalElementView{
                    view11.titleLabel.text = "\(batteryDetail.mcuCapacityPercent?.stringValue ?? "")%"
                    view11.subTitleLabel.text = "剩余电量"
                }
                if let view12 = batteryStackView.arrangedSubviews[2] as? PersonalElementView{
                    view12.titleLabel.text = "\(batteryDetail.ratedMileage)km"
                    view12.subTitleLabel.text = "预计骑行"
                }
                if let view13 = batteryStackView.arrangedSubviews[3] as? PersonalElementView{
                    view13.titleLabel.text = HFKeyedArchiverTool.pleaseEndTime(batteryDetail.batteryEndDate)
                    view13.subTitleLabel.text = "剩余租期"
                }
                if HFKeyedArchiverTool.pleaseStarTimes(HFKeyedArchiverTool.getCurrentTimes(), andEndTime: batteryDetail.batteryEndDate, isDay: true) < 3{
                    self.stackView.addArrangedSubview(batteryExpirationView)
                    self.batteryExpirationView.remainingDays = HFKeyedArchiverTool.pleaseEndTime(batteryDetail.batteryEndDate)
                }else{
                    
                }
            }else{
                self.stackView.addArrangedSubview(batteryRentalView)

            }
            if let bikeDetail = deviceTuple?.1{
                self.stackView.addArrangedSubview(bikeStackView)
                if let view21 = bikeStackView.arrangedSubviews[1] as? PersonalElementView{
                    view21.titleLabel.text = bikeDetail.number
                    view21.subTitleLabel.text = "电车编号"

                }
                if let view23 = bikeStackView.arrangedSubviews[3] as? PersonalElementView{
                    view23.titleLabel.text = HFKeyedArchiverTool.pleaseEndTime(bikeDetail.locomotiveEndDate)
                    view23.subTitleLabel.text = "剩余租期"
                }
                if HFKeyedArchiverTool.pleaseStarTimes(HFKeyedArchiverTool.getCurrentTimes(), andEndTime: bikeDetail.locomotiveEndDate, isDay: true) < 3{
                    self.stackView.addArrangedSubview(bikeExpirationView)
                    self.bikeExpirationView.remainingDays = HFKeyedArchiverTool.pleaseEndTime(bikeDetail.locomotiveEndDate)


                }else{
                    
                }
            }else{
                self.stackView.addArrangedSubview(bikeRentalView)

            }
        }
    }
    
    
    // MARK: - Subviews
    lazy var batteryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    lazy var bikeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    lazy var batteryRentalView: PersonalRentalView = {
        let rentalView = PersonalRentalView()
        rentalView.titleLabel.text = "骑行无忧，单电续航超百公里！！"
        rentalView.titleLabel.textColor = UIColor(hex:0x12B858FF)
        rentalView.backgroundColor = UIColor(hex:0x39D97CFF).withAlphaComponent(0.1)
        rentalView.sureButton.setBackgroundImage(UIColor(hex:0x39D97CFF).toImage(), for: .normal)
        rentalView.sureButton.setBackgroundImage(UIColor(hex:0x39D97CFF).withAlphaComponent(0.5).toImage(), for: .highlighted)
        rentalView.sureButton.setTitle("扫码租电", for: .normal)
        rentalView.sureButton.setTitle("扫码租电", for: .highlighted)

        rentalView.translatesAutoresizingMaskIntoConstraints = false
        return rentalView
    }()
    lazy var bikeRentalView: PersonalRentalView = {
        let rentalView = PersonalRentalView()
        rentalView.translatesAutoresizingMaskIntoConstraints = false
        return rentalView
    }()
    lazy var batteryExpirationView: PersonalExpirationView = {
        let view = PersonalExpirationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var bikeExpirationView: PersonalExpirationView = {
        let view = PersonalExpirationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    // MARK: - Static
    override class func cellIdentifier() -> String {
        return String(describing: self)
    }
    
    override class func cell(with tableView: UITableView) -> PersonalDevicesViewCell {
        let identifier = cellIdentifier()
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? PersonalDevicesViewCell { return cell }
        return PersonalDevicesViewCell(style: .default, reuseIdentifier: identifier)
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.backgroundColor = .clear
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

// MARK: - Setup
private extension PersonalDevicesViewCell {
    
    private func setupSubviews() {
        let view10 = PersonalIconView()
        view10.iconImageView.image = UIImage(named: "battery_5")
        view10.tag = 10
        let view11 = PersonalElementView()
        view11.tag = 11
        let view12 = PersonalElementView()
        view12.tag = 12
        let view13 = PersonalElementView()
        view13.tag = 13
        let view14 = PersonalIconView()
        view14.iconWidth.constant = 8
        view14.iconHeight.constant = 15
        view14.iconImageView.image = UIImage(named: "arrow_right")
        view14.tag = 14
        view14.nextAction = self.batteryDetailAction
        self.batteryStackView.addArrangedSubview(view10)
        self.batteryStackView.addArrangedSubview(view11)
        self.batteryStackView.addArrangedSubview(view12)
        self.batteryStackView.addArrangedSubview(view13)
        self.batteryStackView.addArrangedSubview(view14)

        
        let view20 = PersonalIconView()
        view20.iconImageView.image = UIImage(named: "motorcycle")
        view20.tag = 20
        let view21 = PersonalElementView()
        view21.tag = 21
        let view22 = PersonalElementView()
        view22.titleLabel.isHidden = true
        view22.subTitleLabel.isHidden = true
        view22.tag = 22
        let view23 = PersonalElementView()
        view23.tag = 23
        let view24 = PersonalIconView()
        view24.iconWidth.constant = 8
        view24.iconHeight.constant = 15
        view24.iconImageView.image = UIImage(named: "arrow_right")
        view24.tag = 23
        view24.nextAction = self.bikeDetailAction
        self.bikeStackView.addArrangedSubview(view20)
        self.bikeStackView.addArrangedSubview(view21)
        self.bikeStackView.addArrangedSubview(view22)
        self.bikeStackView.addArrangedSubview(view23)
        self.bikeStackView.addArrangedSubview(view24)

        self.bikeExpirationView.deviceType = "电车"
        
    }
    
    private func setupLayout() {
       
        
    }
    
}

// MARK: - Public
extension PersonalDevicesViewCell {
    
}

// MARK: - Action
@objc private extension PersonalDevicesViewCell {
    
}

// MARK: - Private
private extension PersonalDevicesViewCell {
    
}
class PersonalRentalView:UIView{
    var sureAction:ButtonActionBlock?
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "核蜂动力向每一位骑士致敬！！"
        label.textColor = UIColor(hex:0x447AFEFF)
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var sureButton:UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 82, height: 31)
        button.tintAdjustmentMode = .automatic
        button.setBackgroundImage(UIColor(hex:0x447AFEFF).toImage(), for: .normal)
        button.setBackgroundImage(UIColor(hex:0x447AFEFF).withAlphaComponent(0.5).toImage(), for: .highlighted)
        button.setImage(UIImage(named: "ic_arrow_right"), for: .normal)
        button.setImage(UIImage(named: "ic_arrow_right"), for: .highlighted)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.white, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.setTitle("扫码租车", for: .normal)
        button.setTitle("扫码租车", for: .highlighted)
        button.layer.cornerRadius = 15.5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(sureButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupLayout()
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    private func setupSubviews() {
        self.backgroundColor = UIColor(hex:0x447AFEFF).withAlphaComponent(0.1)
        self.layer.cornerRadius = 12
        self.addSubview(titleLabel)
        self.addSubview(sureButton)
    }
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 12),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.sureButton.leadingAnchor, constant: -12),
            titleLabel.centerYAnchor.constraint(equalTo: self.sureButton.centerYAnchor),
            self.sureButton.topAnchor.constraint(equalTo: self.topAnchor,constant: 8),
            self.sureButton.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -8),
            self.sureButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10),
            self.sureButton.widthAnchor.constraint(equalToConstant: 82),
            self.sureButton.heightAnchor.constraint(equalToConstant: 31),

        
        ])
    }
    @objc func sureButtonTapped(_ sender:UIButton){
        self.sureAction?(sender)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.sureButton.setImagePosition(type: .imageRight, Space: 6)
    }
}
class PersonalExpirationView:UIView{
    var sureAction:ButtonActionBlock?
    var deviceType = "电池"{
        didSet{
            let fullText = "您的\(deviceType)租期剩余\(remainingDays)，为了不影响您正常使用，请尽快续租。"
            let attributedString = NSMutableAttributedString(string: fullText,attributes: [.font:UIFont.systemFont(ofSize: 12)])

            // 定义颜色
            let defaultColor = UIColor(hex:0x333333FF)
            let specialColor = UIColor(hex:0xFF4D4FFF)

            // 设置默认颜色
            attributedString.addAttribute(.foregroundColor, value: defaultColor, range: NSRange(location: 0, length: fullText.count))

            // 设置特殊文本的颜色
            let nsRange = (fullText as NSString).range(of: remainingDays)
            attributedString.addAttribute(.foregroundColor, value: specialColor, range: nsRange)

            // 使用 attributedString，例如设置到一个 UILabel 上
            titleLabel.attributedText = attributedString
        }
    }
    var remainingDays = "1天17小时"{
        didSet{
            let fullText = "您的\(deviceType)租期剩余\(remainingDays)，为了不影响您正常使用，请尽快续租。"
            let attributedString = NSMutableAttributedString(string: fullText,attributes: [.font:UIFont.systemFont(ofSize: 12)])

            // 定义颜色
            let defaultColor = UIColor(hex:0x333333FF)
            let specialColor = UIColor(hex:0xFF4D4FFF)

            // 设置默认颜色
            attributedString.addAttribute(.foregroundColor, value: defaultColor, range: NSRange(location: 0, length: fullText.count))

            // 设置特殊文本的颜色
            let nsRange = (fullText as NSString).range(of: remainingDays)
            attributedString.addAttribute(.foregroundColor, value: specialColor, range: nsRange)

            // 使用 attributedString，例如设置到一个 UILabel 上
            titleLabel.attributedText = attributedString
        }
    }
    private(set) lazy var titleLabel: UILabel = {
        // 创建文本
        let remainingDays = "1天17小时"
        let fullText = "您的电池租期剩余\(remainingDays)，为了不影响您正常使用，请尽快续租。"
        let attributedString = NSMutableAttributedString(string: fullText,attributes: [.font:UIFont.systemFont(ofSize: 12)])

        // 定义颜色
        let defaultColor = UIColor(hex:0x333333FF)
        let specialColor = UIColor(hex:0xFF4D4FFF)

        // 设置默认颜色
        attributedString.addAttribute(.foregroundColor, value: defaultColor, range: NSRange(location: 0, length: fullText.count))

        // 设置特殊文本的颜色
        let nsRange = (fullText as NSString).range(of: remainingDays)
        attributedString.addAttribute(.foregroundColor, value: specialColor, range: nsRange)

        // 使用 attributedString，例如设置到一个 UILabel 上
        let label = UILabel()
        label.attributedText = attributedString

        // 显示 Label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var sureButton:UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 82, height: 31)
        button.tintAdjustmentMode = .automatic
        let layerView = UIView()
        layerView.frame = CGRect(x: 0, y: 0, width: 82, height: 31)

        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [UIColor(red: 0.98, green: 0.91, blue: 0.76, alpha: 1).cgColor, UIColor(red: 0.99, green: 0.79, blue: 0.45, alpha: 1).cgColor]
        bgLayer1.locations = [0, 1]
        bgLayer1.frame = layerView.bounds
        bgLayer1.startPoint = CGPoint(x: 0.96, y: 0.5)
        bgLayer1.endPoint = CGPoint(x: 0.5, y: 0.5)
        layerView.layer.addSublayer(bgLayer1)
        button.setBackgroundImage(layerView.asImage(), for: .normal)
        button.setBackgroundImage(layerView.asImage(), for: .highlighted)
        button.setImage(UIImage(named: "ic_arrow_right_brown"), for: .normal)
        button.setImage(UIImage(named: "ic_arrow_right_brown"), for: .highlighted)
        button.setTitleColor(UIColor(hex:0x6C4627FF), for: .normal)
        button.setTitleColor(UIColor(hex:0x6C4627FF), for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.setTitle("立即续租", for: .normal)
        button.setTitle("立即续租", for: .highlighted)
        button.layer.cornerRadius = 15.5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(sureButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupLayout()
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    private func setupSubviews() {
        self.backgroundColor = UIColor(hex:0xFFEBE9FF)
        self.layer.cornerRadius = 10
        self.addSubview(titleLabel)
        self.addSubview(sureButton)
    }
    private func setupLayout() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: self.sureButton.leadingAnchor, constant: -12),
            self.sureButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            self.sureButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10),
            self.sureButton.widthAnchor.constraint(equalToConstant: 82),
            self.sureButton.heightAnchor.constraint(equalToConstant: 31),
        ])
    }
    @objc func sureButtonTapped(_ sender:UIButton){
        self.sureAction?(sender)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.sureButton.setImagePosition(type: .imageRight, Space: 10)
    }
}
