//
//  HFGridList.h
//  hfpower
//
//  Created by EDY on 2024/9/10.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFGridList : NSObject
@property(nonatomic,copy)NSString* batteryNumber;
@property(nonatomic,copy)NSString* batteryTypeName;
@property(nonatomic,copy)NSString* createAt;
@property(nonatomic,copy)NSString* extinguisher;
@property(nonatomic,copy)NSString* memo;
@property(nonatomic,copy)NSString* updateAt;
@property(nonatomic,strong)NSNumber *batteryCapacityPercent;
@property(nonatomic,strong)NSNumber *batteryId;
@property(nonatomic,strong)NSNumber *batteryStatus;
@property(nonatomic,strong)NSNumber *cabinetId;
@property(nonatomic,strong)NSNumber *cabinetOnLine;
@property(nonatomic,strong)NSString *charger;
@property(nonatomic,strong)NSNumber *errStatus;
@property(nonatomic,strong)NSNumber *gridNum;
@property(nonatomic,strong)NSNumber *ID;
@property(nonatomic,strong)NSNumber *light;
@property(nonatomic,strong)NSNumber *lock;
@property(nonatomic,strong)NSString *mac;
@property(nonatomic,strong)NSNumber *specs;
@property(nonatomic,strong)NSNumber *status;
@property(nonatomic,strong)NSString *statusUpdateBy;
@property(nonatomic,strong)NSString *temperature;
@end

NS_ASSUME_NONNULL_END
