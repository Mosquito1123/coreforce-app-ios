//
//  HFPackageCardModel.m
//  hfpower
//
//  Created by EDY on 2024/9/11.
//

#import "HFPackageCardModel.h"

@interface HFPackageCardModel ()

@end

@implementation HFPackageCardModel
//关键词替换
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
