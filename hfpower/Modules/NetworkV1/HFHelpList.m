//
//  HFHelpList.m
//  hfpower
//
//  Created by EDY on 2024/9/12.
//

#import "HFHelpList.h"
@interface HFHelpDict ()

@end

@implementation HFHelpDict

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
@interface HFHelpList ()

@end

@implementation HFHelpList

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
