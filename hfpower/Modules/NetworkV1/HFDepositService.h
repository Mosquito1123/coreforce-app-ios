//
//  HFDepositService.h
//  hfpower
//
//  Created by EDY on 2024/9/13.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>
NS_ASSUME_NONNULL_BEGIN

@interface HFDepositService : NSObject
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSNumber *selected;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSNumber *authOrder;

@end

NS_ASSUME_NONNULL_END
