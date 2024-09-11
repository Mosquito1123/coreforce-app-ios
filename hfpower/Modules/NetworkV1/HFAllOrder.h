//
//  HFAllOrder.h
//  hfpower
//
//  Created by EDY on 2024/9/11.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFAllOrder : NSObject
@property(nonatomic,copy)NSString* agentName;
@property(nonatomic,copy)NSString* batteryNumber;
@property(nonatomic,copy)NSString* batteryTypeName;
@property(nonatomic,copy)NSString* createAt;
@property(nonatomic,copy)NSString* endDate;
@property(nonatomic,copy)NSString* memberRealName;
@property(nonatomic,copy)NSString* nickname;
@property(nonatomic,copy)NSString* planName;
@property(nonatomic,copy)NSString* startDate;
@property(nonatomic,copy)NSString* storeName;
@property(nonatomic,strong)NSNumber *agentId;
@property(nonatomic,assign)int batteryChargeTimes;
@property(nonatomic,strong)NSNumber *batteryId;
@property(nonatomic,assign)int deviceType;
@property(nonatomic,assign)int duration;
@property(nonatomic,strong)NSNumber *ID;
@property(nonatomic,assign)int leaseDuration;
@property(nonatomic,assign)int memberId;
@property(nonatomic,assign)int memberPhoneNum;
@property(nonatomic,copy)NSString* orderNo;
@property(nonatomic,assign)int payStatus;
@property(nonatomic,assign)int planId;
@property(nonatomic,assign)int storeId;
@property(nonatomic,assign)int type;
@property(nonatomic,assign)double batteryMileage;
@property(nonatomic,assign)double deposit;
@property(nonatomic,assign)double payableAmount;
@property(nonatomic,assign)double payableRent;
@property(nonatomic,assign)double rent;
@property(nonatomic,assign)double totalAmount;
@property(nonatomic,assign)double couponDiscountAmount;
@end

NS_ASSUME_NONNULL_END
