//
//  HFCabinetDetail.m
//  hfpower
//
//  Created by EDY on 2024/9/10.
//

#import "HFCabinetDetail.h"

@interface HFCabinetDetail ()

@end

@implementation HFCabinetDetail

#pragma mark - Accessor
+ (NSDictionary *)mj_objectClassInArray {
    return @{
        @"gridList" : [HFGridList class],
        @"cabinetExchangeForecast" : [HFCabinetExchangeForecast class]
    };
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
