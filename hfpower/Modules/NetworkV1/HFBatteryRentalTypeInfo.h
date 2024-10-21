//
//  HFBatteryRentalTypeInfo.h
//  hfpower
//
//  Created by EDY on 2024/9/13.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFBatteryRentalTypeInfo : NSObject
@property (nonatomic, strong) NSNumber *agentId;
@property (nonatomic, strong) NSNumber *batteryCapacityPercent;
@property (nonatomic, copy) NSString *batteryDeposit;
@property (nonatomic, copy) NSString *batteryHeartAt;
@property (nonatomic, strong) NSNumber *batteryId;
@property (nonatomic, strong) NSNumber *batteryLock;
@property (nonatomic, copy) NSString *batteryMac;
@property (nonatomic, copy) NSString *batteryNumber;
@property (nonatomic, strong) NSNumber *batteryPlanChangeFeeStatus;
@property (nonatomic, strong) NSNumber *batteryPlanDuration;
@property (nonatomic, strong) NSNumber *batteryPlanId;
@property (nonatomic, copy) NSString *batteryPlanName;
@property (nonatomic, copy) NSString *batteryRent;
@property (nonatomic, strong) NSNumber *batteryStatus;
@property (nonatomic, strong) NSNumber *batteryTemp;
@property (nonatomic, strong) NSNumber *batteryTypeId;
@property (nonatomic, copy) NSString *batteryTypeName;
@property (nonatomic, copy) NSString *batteryVoltage;
@property (nonatomic, copy) NSString *bindBatteryNumber;
@property (nonatomic, copy) NSString *cabinetHeartbeatAt;
@property (nonatomic, strong) NSNumber *cabinetId;
@property (nonatomic, copy) NSString *cabinetMac;
@property (nonatomic, copy) NSString *cabinetNum;
@property (nonatomic, strong) NSNumber *cabinetOnLine;
@property (nonatomic, strong) NSNumber *cabinetStatus;
@property (nonatomic, copy) NSString *charger;
@property (nonatomic, copy) NSString *createAt;
@property (nonatomic, strong) NSNumber *errStatus;
@property (nonatomic, copy) NSString *extinguisher;
@property (nonatomic, copy) NSString *faultCode;
@property (nonatomic, strong) NSNumber *gridNum;
@property (nonatomic, copy) NSString *heat;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSNumber *largeTypeId;
@property (nonatomic, copy) NSString *largeTypeName;
@property (nonatomic, copy) NSString *lastUnlockCmdTime;
@property (nonatomic, copy) NSString *lastUnlockTime;
@property (nonatomic, copy) NSString *light;
@property (nonatomic, copy) NSString *lock;
@property (nonatomic, copy) NSString *mac;
@property (nonatomic, strong) NSNumber *mcuAmbientTemp;
@property (nonatomic, strong) NSNumber *mcuBatteryTemp;
@property (nonatomic, strong) NSNumber *mcuBatteryTemp2;
@property (nonatomic, strong) NSString *memo;
@property (nonatomic, strong) NSNumber *parentGroupId;
@property (nonatomic, copy) NSString *parentTypeName;
@property (nonatomic, strong) NSNumber *specs;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSNumber *statusUpdateBy;
@property (nonatomic, copy) NSString *statusUpdaterName;
@property (nonatomic, strong) NSNumber *temperature;
@property (nonatomic, copy) NSString *updateAt;
@property (nonatomic, strong) NSString *typeName;
@property (nonatomic, strong) NSNumber *parentId;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSString *batteryIcon;
@property (nonatomic, strong) NSString *enduranceMemo;
@property (nonatomic, strong) NSNumber *level;
@property (nonatomic, strong) NSNumber *minMileage;
@property (nonatomic, strong) NSString *batteryMemo;
@property (nonatomic, strong) NSNumber *maxMileage;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *parentName;

@end

NS_ASSUME_NONNULL_END
