//
//  HFMessageData.m
//  hfpower
//
//  Created by EDY on 2024/9/14.
//

#import "HFMessageData.h"

@interface HFMessageData ()

@end

@implementation HFMessageData

#pragma mark - Accessor
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
