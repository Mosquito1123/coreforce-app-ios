//
//  UIImageView+Extension.swift
//  hfpower
//
//  Created by EDY on 2024/10/16.
//

import UIKit
import Kingfisher
extension UIImageView{
    //HF 加载头像
    func setHeaderImage(placeholder: UIImage? = nil) {
        let accessToken = HFKeyedArchiverTool.account().accessToken
        // 自定义缓存 key，去掉动态参数（如时间戳）
        let cacheKey = "\(rootRequest)/app/api/member/headPic?access_token=\(accessToken)"
        let iconURLString = "\(rootRequest)/app/api/member/headPic?access_token=\(accessToken)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        self.kf.setImage(with: KF.ImageResource(downloadURL: URL(string: iconURLString) ?? URL(fileURLWithPath: ""), cacheKey: cacheKey),placeholder:placeholder,options: [
            .cacheOriginalImage,  // 缓存原始图片
            .targetCache(KingfisherManager.shared.cache),  // 可选：指定自定义缓存
            .memoryCacheExpiration(.days(7)),  // 可选：设置缓存时间为7天
            .diskCacheExpiration(.days(30)),   // 可选：磁盘缓存30天
        ])
    }
    //HF 加载电柜图片
    func setCabinetImage(id:Int,index:Int,placeholder: UIImage? = nil) {
        let accessToken = HFKeyedArchiverTool.account().accessToken
        // 自定义缓存 key，去掉动态参数（如时间戳）
        let cacheKey = "\(rootRequest)/app/api/cabinet/photo?id=\(id)&photo=\(index)"
        let iconURLString = "\(rootRequest)/app/api/cabinet/photo?access_token=\(accessToken)&id=\(id)&photo=\(index)&requestNo=\(Int.requestNo)&createTime=\(Date().currentTimeString)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        self.kf.setImage(with: KF.ImageResource(downloadURL: URL(string: iconURLString) ?? URL(fileURLWithPath: ""), cacheKey: cacheKey),placeholder:placeholder,options: [
            .cacheOriginalImage,  // 缓存原始图片
            .targetCache(KingfisherManager.shared.cache),  // 可选：指定自定义缓存
            .memoryCacheExpiration(.days(7)),  // 可选：设置缓存时间为7天
            .diskCacheExpiration(.days(30)),   // 可选：磁盘缓存30天
        ])
    }
    //HF ImageView 加载并缓存图片
    func setImage(photoName:String,placeholder: UIImage? = nil) {
        let accessToken = HFKeyedArchiverTool.account().accessToken
        let icon = photoName
        // 自定义缓存 key，去掉动态参数（如时间戳）
        let cacheKey = "\(rootRequest)/app/api/normal/read/photo?photo=\(icon)"
        let iconURLString = "\(rootRequest)/app/api/normal/read/photo?access_token=\(accessToken)&photo=\(icon)&requestNo=\(Int.requestNo)&createTime=\(Date().currentTimeString)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        
        self.kf.setImage(with: KF.ImageResource(downloadURL: URL(string: iconURLString) ?? URL(fileURLWithPath: ""), cacheKey: cacheKey),placeholder:placeholder,options: [
            .cacheOriginalImage,  // 缓存原始图片
            .targetCache(KingfisherManager.shared.cache),  // 可选：指定自定义缓存
            .memoryCacheExpiration(.days(7)),  // 可选：设置缓存时间为7天
            .diskCacheExpiration(.days(30)),   // 可选：磁盘缓存30天
        ])
    }
}
