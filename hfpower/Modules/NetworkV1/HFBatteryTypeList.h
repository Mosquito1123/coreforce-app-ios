//
//  HFBatteryTypeList.h
//  hfpower
//
//  Created by EDY on 2024/9/11.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFBatteryTypeList : NSObject
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSString *typeName;
@property (nonatomic, strong) NSNumber *parentId;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSString *batteryIcon;
@property (nonatomic, strong) NSString *memo;
@property (nonatomic, strong) NSString *createAt;
@property (nonatomic, strong) NSString *enduranceMemo;
@property (nonatomic, strong) NSNumber *level;
@property (nonatomic, strong) NSNumber *minMileage;
@property (nonatomic, strong) NSString *updateAt;
@property (nonatomic, strong) NSString *batteryMemo;
@property (nonatomic, strong) NSNumber *maxMileage;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *parentName;
@property (nonatomic, strong) NSNumber *largeTypeId;
@property (nonatomic, copy) NSString *largeTypeName;
@property (nonatomic, strong) NSNumber *batteryTypeId;
@property (nonatomic, copy) NSString *batteryTypeName;

@end

NS_ASSUME_NONNULL_END
