//
//  HFBatteryDetail.h
//  hfpower
//
//  Created by EDY on 2024/9/9.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFBatteryDetail : NSObject<NSSecureCoding>
@property(nonatomic,assign)int ambientTemperature;
@property(nonatomic,assign)int batteryTemperature2;
@property(nonatomic,assign)int clientLock;
@property(nonatomic,assign)int ID;
@property(nonatomic,assign)int lockStatus;
@property(nonatomic,assign)int mcuAmbientTemp;
@property(nonatomic,assign)int mcuBatteryTemp;
@property(nonatomic,assign)int mcuBatteryTemp2;
@property(nonatomic,strong,nullable)NSNumber *mcuCapacityPercent;
@property(nonatomic,assign)int mcuLock;
@property(nonatomic,assign)int memberPhoneNum;
@property(nonatomic,strong)NSNumber *onLine;
@property(nonatomic,assign)int originalOrderId;
@property(nonatomic,assign)int planId;
@property(nonatomic,assign)int ratedMileage;
@property(nonatomic,assign)int remainCapacity;
@property(nonatomic,assign)int startChargeTimes;
@property(nonatomic,assign)int status;
@property(nonatomic,copy)NSString* batteryEndDate;
@property(nonatomic,copy)NSString* batteryName;
@property(nonatomic,copy)NSString* batteryStartDate;
@property(nonatomic,copy)NSString* batteryStartMileage;
@property(nonatomic,copy)NSString* generalParamsAt;
@property(nonatomic,copy)NSString* gpsAt;
@property(nonatomic,copy)NSString* lastMcuTime;
@property(nonatomic,copy)NSString* memberNickname;
@property(nonatomic,copy)NSString* memberRealName;
@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* agentName;
@property(nonatomic,copy)NSNumber* agentId;
@property(nonatomic,copy)NSString* number;
@property(nonatomic,strong,nullable)NSNumber *gdLat;
@property(nonatomic,strong,nullable)NSNumber *gdLon;
@property(nonatomic,strong,nullable)NSNumber *lastLat;
@property(nonatomic,strong,nullable)NSNumber *lastLon;
@property(nonatomic,assign)double mcuCurrent;
@property(nonatomic,assign)double mcuVoltage;
@property(nonatomic,assign)double mileage;
@property(nonatomic,assign)BOOL changeFeeStatus;//换电状态
@property(nonatomic,assign)double changeFeeAmount;//换电金额
@property(nonatomic,assign)int changeCountLimit;
@property(nonatomic,assign)double singleChangeFeeAmount;//单次换电金额
@property(nonatomic,assign)BOOL isRefundChangeFee;//是否退换换电费
@property(nonatomic,copy)NSString* changeEndDateMember;//换电有效期
@property(nonatomic,assign)int changeRemainTimesMember;//剩余换电次数
@end

NS_ASSUME_NONNULL_END
