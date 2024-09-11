//
//  HFBatteryTypeInfo.m
//  hfpower
//
//  Created by EDY on 2024/9/11.
//

#import "HFBatteryTypeInfo.h"

@interface HFBatteryTypeInfo ()

@end

@implementation HFBatteryTypeInfo
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
#pragma mark - Accessor

#pragma mark - Lifecycle

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - Public

#pragma mark - Private

@end
