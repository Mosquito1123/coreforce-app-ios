//
//  HFDepositData.h
//  hfpower
//
//  Created by EDY on 2024/9/10.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFDepositData : NSObject
@property(nonatomic,assign)double batteryDeposit;
@property(nonatomic,assign)double batteryRefundDeposit;
@property(nonatomic,assign)double locomotiveDeposit;
@property(nonatomic,assign)double locomotiveRefundDeposit;
@end

NS_ASSUME_NONNULL_END
