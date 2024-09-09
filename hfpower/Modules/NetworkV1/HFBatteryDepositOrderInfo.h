//
//  HFBatteryDepositOrderInfo.h
//  hfpower
//
//  Created by EDY on 2024/9/9.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFBatteryDepositOrderInfo : NSObject<NSSecureCoding>
@property(nonatomic,strong,nullable)NSNumber *ID;
@property(nonatomic,strong)NSNumber *deleted;
@property(nonatomic,strong)NSString *orderNo;
@property(nonatomic,strong)NSNumber *memberId;
@property(nonatomic,strong)NSNumber *originalOrderId;
@property(nonatomic,strong)NSNumber *batteryId;
@property(nonatomic,strong)NSNumber *agentId;
@property(nonatomic,strong)NSNumber *storeId;
@property(nonatomic,strong)NSNumber *batteryTypeId;
@property(nonatomic,strong)NSString *batteryNo;
@property(nonatomic,strong)NSNumber *tempStorageDailyPrice;
@property(nonatomic,strong)NSNumber *tempStorageMinimumDays;
@property(nonatomic,strong)NSNumber *remainDuration;
@property(nonatomic,strong)NSNumber *remainRent;
@property(nonatomic,strong)NSNumber *deposit;
@property(nonatomic,strong)NSNumber *authDeposit;
@property(nonatomic,strong)NSNumber *canTemporaryStorageDays;
@property(nonatomic,strong)NSString *startDate;
@property(nonatomic,strong)NSString *endDate;
@property(nonatomic,strong)NSNumber *status;
@property(nonatomic,strong)NSString *getBatteryDate;
@property(nonatomic,strong)NSString *actualTemporaryStorageDays;
@property(nonatomic,strong)NSNumber *tempStorageTotalPrice;
@property(nonatomic,strong)NSNumber *payMethod;
@property(nonatomic,strong)NSString *payDate;
@property(nonatomic,strong)NSString *refundDate;
@property(nonatomic,strong)NSString *agentName;
@property(nonatomic,strong)NSString *storeName;
@property(nonatomic,strong)NSString *batteryTypeName;
@property(nonatomic,strong)NSString *memberName;
@property(nonatomic,strong)NSString *memberPhone;
@end

NS_ASSUME_NONNULL_END
