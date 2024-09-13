//
//  HFBatteryRentalTypeInfo.m
//  hfpower
//
//  Created by EDY on 2024/9/13.
//

#import "HFBatteryRentalTypeInfo.h"

@interface HFBatteryRentalTypeInfo ()

@end

@implementation HFBatteryRentalTypeInfo

#pragma mark - Accessor
//关键词替换
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
#pragma mark - Lifecycle

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - Public

#pragma mark - Private

@end
