//
//  HFKeyedArchiverTool.h
//  hfpower
//
//  Created by EDY on 2024/9/9.
//

#import <Foundation/Foundation.h>
#import "HFBatteryDetail.h"
#import "HFActivityListModel.h"
#import "HFBatteryDepositOrderInfo.h"
#import "HFBikeDetail.h"
#import "HFAccount.h"
#import "HFCouponData.h"
#import "HFMember.h"
#import "HFDepositData.h"
#import "HFChangeCardInfo.h"
#import "HFOrderData.h"
#import "HFCouponCountData.h"
#import "HFMsgCountData.h"
#import "HFCabinetDetail.h"

NS_ASSUME_NONNULL_BEGIN

@interface HFKeyedArchiverTool : NSObject
//存储token
+(BOOL)saveAccount:(HFAccount*)account;
//读取token
+(HFAccount*)account;
//存储电池列表
+(BOOL)saveBatteryDataList:(NSArray<HFBatteryDetail*>*)dataList;
//读取电池列表
+(NSArray<HFBatteryDetail*>*)batteryDataList;

//存储电车信息
+(BOOL)saveBikeContentList:(NSArray<HFBikeDetail*>*)bikeDetailList;
//读取电车信息
+(NSArray<HFBikeDetail*>*)bikeDetailList;

//储存活动信息
+(BOOL)saveActivityList:(NSArray<HFActivityListModel*>*)activityList;
//读取活动信息
+(NSArray<HFActivityListModel*>*)activityList;

//储存寄存订单详情
+(BOOL)saveBatteryDepositOrderInfo:(HFBatteryDepositOrderInfo *)batteryDepositOrderInfo;
//读取寄存订单详情
+(HFBatteryDepositOrderInfo *)batteryDepositOrderInfo;

//删除存储的本地token
+(void)removeData;
//删除本地的电池数据
+(void)removeBatteryData;

//获取当前时间
+(NSString*)getCurrentTimes;
//计算优惠券时间差
+(NSInteger)pleaseStarTimes:(NSString*)starTime andEndTime:(NSString*)endTime isDay:(BOOL)isDay;
//计算电池机车过期时间
+(NSString*)pleaseEndTime:(NSString*)endTime;

@end

NS_ASSUME_NONNULL_END

