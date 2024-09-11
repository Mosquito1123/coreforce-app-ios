//
//  HFBatteryTypeInfo.h
//  hfpower
//
//  Created by EDY on 2024/9/11.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFBatteryTypeInfo : NSObject
@property (nonatomic, strong) NSString *batteryIcon;
@property (nonatomic, strong) NSString *batteryMemo;
@property (nonatomic, strong) NSString *createAt;
@property (nonatomic, strong) NSString *enduranceMemo;
@property (nonatomic, strong) NSNumber *ID;  // 注意 'id' 是关键字，改为 'batteryId'
@property (nonatomic, strong) NSNumber *level;
@property (nonatomic, strong) NSNumber *maxMileage;
@property (nonatomic, strong) NSString *memo;
@property (nonatomic, strong) NSNumber *minMileage;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *parentId;
@end

NS_ASSUME_NONNULL_END
