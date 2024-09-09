//
//  HFBatteryDepositOrderInfo.m
//  hfpower
//
//  Created by EDY on 2024/9/9.
//

#import "HFBatteryDepositOrderInfo.h"

@interface HFBatteryDepositOrderInfo ()

@end

@implementation HFBatteryDepositOrderInfo
+ (BOOL)supportsSecureCoding {
    return YES;
}
#pragma mark - Accessor

#pragma mark - Lifecycle

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - Public
MJCodingImplementation
#pragma mark - Private
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
@end
