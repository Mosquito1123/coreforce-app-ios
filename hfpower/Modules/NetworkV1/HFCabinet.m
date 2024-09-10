//
//  HFCabinet.m
//  hfpower
//
//  Created by EDY on 2024/9/10.
//

#import "HFCabinet.h"

@interface HFCabinet ()

@end

@implementation HFCabinet
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
