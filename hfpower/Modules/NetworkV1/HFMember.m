//
//  HFMember.m
//  hfpower
//
//  Created by EDY on 2024/9/10.
//

#import "HFMember.h"

@interface HFMember ()

@end

@implementation HFMember
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
#pragma mark - Accessor
MJCodingImplementation
#pragma mark - Lifecycle

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark - Public

#pragma mark - Private

@end
