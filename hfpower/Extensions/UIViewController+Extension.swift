//
//  UIViewController+Extension.swift
//  hfpower
//
//  Created by EDY on 2024/6/6.
//

import UIKit
import SDCAlertView
extension UIViewController{
    func showPrivacyAlertController(cancelBlock:((AlertAction)->Void)? = nil,sureBlock:((AlertAction) -> Void)? = nil){
        let textView = UITextView()
         textView.backgroundColor = .clear
         let attributedString = NSMutableAttributedString(string: "阅读并同意《核蜂换电隐私政策》和《租赁协议》", attributes: [
             .font: UIFont.systemFont(ofSize: 15),
             .foregroundColor: UIColor(named: "666666") ?? UIColor.black
         ])
         
         let privacyPolicyRange = (attributedString.string as NSString).range(of: "《核蜂换电隐私政策》")
         attributedString.addAttribute(.link, value: "http://www.coreforce.cn/privacy/index.html", range: privacyPolicyRange)
         attributedString.addAttribute(.foregroundColor, value: UIColor(named: "3171EF") ?? UIColor.blue, range: privacyPolicyRange)
         
         let rentalAgreementRange = (attributedString.string as NSString).range(of: "《租赁协议》")
         attributedString.addAttribute(.link, value: "http://www.coreforce.cn/privacy/member.html", range: rentalAgreementRange)
         attributedString.addAttribute(.foregroundColor, value: UIColor(named: "3171EF") ?? UIColor.blue, range: rentalAgreementRange)
         
         textView.attributedText = attributedString
         textView.translatesAutoresizingMaskIntoConstraints = false
         let alert = AlertController(attributedTitle: NSAttributedString(string: "隐私政策和租赁协议",attributes: [.font:UIFont.systemFont(ofSize: 15, weight: .medium)]), attributedMessage: nil)
         alert.visualStyle.verticalElementSpacing = 12
         alert.contentView.addSubview(textView)

         textView.leadingAnchor.constraint(equalTo: alert.contentView.leadingAnchor).isActive = true
         textView.trailingAnchor.constraint(equalTo: alert.contentView.trailingAnchor).isActive = true

         textView.topAnchor.constraint(equalTo: alert.contentView.topAnchor).isActive = true
         textView.bottomAnchor.constraint(equalTo: alert.contentView.bottomAnchor).isActive = true
         textView.heightAnchor.constraint(equalToConstant: 50).isActive = true
         alert.addAction(AlertAction(attributedTitle: NSAttributedString(string: "不同意",attributes: [.font:UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor(named: "333333") ?? UIColor.blue]), style: .normal, handler: cancelBlock))
         alert.addAction(AlertAction(attributedTitle: NSAttributedString(string: "同意",attributes: [.font:UIFont.systemFont(ofSize: 16),.foregroundColor:UIColor(named: "447AFE") ?? UIColor.blue]), style: .normal, handler: sureBlock))
         alert.present()
    }
  
}
