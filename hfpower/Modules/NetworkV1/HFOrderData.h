//
//  HFOrderData.h
//  hfpower
//
//  Created by EDY on 2024/9/10.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFOrderData : NSObject
@property (nonatomic, strong) NSNumber *paidCount;
@property (nonatomic, strong) NSNumber *payingCount;

@end

NS_ASSUME_NONNULL_END
