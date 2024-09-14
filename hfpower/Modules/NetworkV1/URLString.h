//
//  URLString.h
//  hfpower
//
//  Created by EDY on 2024/9/9.
//

#ifndef URLString_h
#define URLString_h
#define HFInformationFileName [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"information.data"]
#define HFBatteryDetailFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"HFBatteryDetailFile.data"]
#define HFBikeDetailFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"HFBikeDetailFile.data"]
#define HFActivityListFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"HFActivityListFile.data"]
#define HFBatteryDepositOrderInfoFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"HFBatteryDepositOrderInfoFile.data"]
#define rootRequest @"http://www.coreforce.cn"//根目录请求
#define inviteRequest @"http://www.coreforce.cn"//活动根目录请求
//#define inviteRequest @"http://192.168.110.105:5173"//活动测试根目录

#define batteryListUrl @"/app/api/battery/list"//电池列表接口
#define locomotiveListUrl @"/app/api/locomotive/list"//机车列表接口
#define cabinetScanUrl @"/app/api/cabinet/scan"//电池柜扫码接口
#define cabinetScanReturnUrl @"/app/api/cabinet/scanReturn"//扫换电柜码退电接口
#define replaceConfirmUrl @"/app/api/cabinet/replace/confirm"//换电柜柜换电接口
#define cabinetUrl @"/app/api/cabinet" //查询电柜接口
#define memberUrl @"/app/api/member"//手机号查询接口

#define batteryStorageInitiateUrl @"/app/api/battery/storage/initiate"//发起暂存判断
#define batteryTempOrderInfoUrl @"/app/api/batteryTemp/order/info"//寄存详情接口
#define cabinetScanTempUrl @"/app/api/cabinet/scanTemp" //电柜扫码寄存
#define cabinetScanReliefUrl @"/app/api/cabinet/scanRelief"//电柜扫码解除寄存
#define batteryScanReliefUrl @"/app/api/battery/scanRelief"//电池扫码解除寄存
#define cabinetScanTempConfirmUrl @"/app/api/cabinet/temp/confirm" //电柜扫码寄存确认
#define cabinetScanReliefConfirmUrl @"/app/api/cabinet/relief/confirm"//电柜扫码解除寄存确认
#define batteryScanReliefConfirmUrl @"/app/api/battery/relief/confirm"//电池扫码解除寄存确认

//套餐卡
#define packageCardListUrl @"/app/api/payVoucher/list"//电池扫码解除寄存确认
#define packageCardCountUrl @"/app/api/payVoucher/count"//套餐券数量

#define memberAgreementUrl @"/app/api/member/agreement"//同意协议接口
#define activityListUrl @"/app/api/activity/list"//活动弹窗接口
#define cabinetListUrl @"/app/api/v2/cabinet/list"//电柜列表接口
#define cabinetScanRentUrl @"/app/api/cabinet/scanRent"//换电柜扫码租电
#define batteryLockUrl @"/app/api/battery/lock"//电池上锁接口
#define batteryUnlockUrl @"/app/api/battery/unlock"//电池解锁接口
#define batteryRingUrl @"/app/api/battery/ring"//电池响铃接口

#define lockStatusUrl @"/app/api/battery/lock/status"//电池上锁状态接口
#define cabinetStatusUrl @"/app/api/cabinet/status" //查询换电状态接口
#define couponMatchingCountUrl @"/app/api/coupon/matching/count"//查询电池优惠券数量接口
#define batteryUrl @"/app/api/battery"//查询电池接口
#define renewalUrl @"app/api/renewal"//下单详情接口
#define orderUrl @"/app/api/order"//订单详情接口
#define orderAuthUrl @"/app/api/order/auth"//订单预授权详情接口
#define orderCancelUrl @"/app/api/order/cancel"//取消订单接口
#define batteryTimeChangeCardCancelUrl @"/app/api/batteryTimeChangeCard/cancel"//换点卡取消订单接口
#define orderPayUrl @"/app/api/order/pay"//支付接口
#define batteryTimeChangeCardPayUrl @"/app/api/batteryTimeChangeCard/pay"//换点卡支付接口"
#define locomotiveCouponCountUrl @"/app/api/locomotive/coupon/matching/count"//电车查询优惠券数量接口
#define locomotiveUrl @"/app/api/locomotive"//查询机车接口"
#define batteryReturnUrl @"/app/api/battery/return"//退电接口
#define memberUrl @"/app/api/member"//个人信息详情页面
#define logoffUrl @"/app/api/logoff"//注销账号接口"
#define logoutUrl @"/app/api/logout"//退出接口"
#define headPicUrl @"/app/api/member/headPic"//上传头像接口
#define nicknameUrl @"/app/api/member/nickname"//更改昵称
#define changePwdUrl @"/app/api/changePwd"//修改密码接口
#define forgetPwdUrl @"/app/api/changePwdBySms"//忘记密码接口
#define pinSendUrl @"/app/api/pin/send"//换绑手机号接口
#define memberBindUrl @"/app/api/member/bind"//绑定手机号
#define memberMsgUrl @"/app/api/member/msg"//消息列表接口
#define memberMsgReadUrl @"/app/api/member/msg/read"//消息已读接口
#define orderListUrl @"/app/api/order/list"//订单列表接口"
#define batteryTimeChangeCardListUrl @"/app/api/batteryTimeChangeCard/list"//换点卡订单列表
#define couponMatchingUrl @"/app/api/coupon/matching"//电池匹配优惠券
#define locomotiveCouponMatchingUrl @"/app/api/locomotive/coupon/matching"//机车匹配优惠券
#define changeCardCouponMatchingUrl @"/app/api/changeCard/coupon/matching"//换点卡匹配优惠券
#define couponListUrl @"/app/api/coupon/list"//优惠券列表
#define couponReceiveUrl @"/app/api/coupon/receive"//使用优惠券接口
#define memberRpInitUrl @"/app/api/member/rp/init"//初始化实名认证
#define memberRpDescribeUrl @"/app/api/member/rp/describe"//第三方实名认证接口
#define feedbackUrl @"/app/api/feedback"//提交反馈接口
#define memberInviteCodeUrl @"/app/api/member/inviteCode"//获取邀请码接口
#define batteryTimeChangeCardPlanListUrl @"/app/api/batteryTimeChangeCardPlan/list"//换点卡列表接口
#define loginUrl @"/app/api/login"//登录接口"
#define regUrl @"/app/api/reg"//注册接口
#define returnCheckUrl @"/app/api/battery/return/check"//运营商扫码退租状态
#define buyPackageCardUrl @"/app/api/payVoucher/main/order"//套餐卡下单
#define ourPackageCardUrl @"/app/api/payVoucher/main/list"//在售套餐卡列表
#define gridOpenUrl @"/app/api/grid/open"//卡仓取电
#define mileageUrl @"/app/api/member/mileage"
#define largeTypeParentUrl @"/app/api/largeTypeParent/list"
#define largeTypeUrl @"/app/api/largeType/list"
#define helpDictListUrl @"/app/api/dict/list"
#define helpListUrl @"/app/api/help/list"

#endif /* URLString_h */
