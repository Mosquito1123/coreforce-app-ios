//
//  HFCouponData.h
//  hfpower
//
//  Created by EDY on 2024/9/10.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFCouponData : NSObject
@property (nonatomic, copy) NSString *agentNames;
@property (nonatomic, copy) NSString *endDate;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *phoneNum;
@property (nonatomic, copy) NSString *realName;
@property (nonatomic, copy) NSString *startDate;
@property (nonatomic, copy) NSString *storeNames;
@property(nonatomic,assign)double discountAmount;
@property(nonatomic,assign)double limitAmount;
@property(nonatomic,copy)NSNumber *ID;
@property(nonatomic,assign)NSInteger couponType;
@property(nonatomic,assign)NSInteger couponTypeId;
@property(nonatomic,assign)NSInteger deviceType;
@property(nonatomic,assign)NSInteger freeDepositCount;
@property(nonatomic,assign)NSInteger freeDepositTimes;
@property(nonatomic,assign)NSInteger memberId;
@property(nonatomic,assign)NSInteger status;
@property (nonatomic, strong) NSNumber *selected;
@end

NS_ASSUME_NONNULL_END
