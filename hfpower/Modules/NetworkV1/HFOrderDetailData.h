//
//  HFOrderDetailData.h
//  hfpower
//
//  Created by EDY on 2024/9/11.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFOrderDetailData : NSObject
@property(nonatomic,assign)int agentId;
@property(nonatomic,copy)NSNumber *authOrderStatus;//支付宝预授权
@property(nonatomic,assign)int batteryChargeTimes;
@property(nonatomic,assign)int batteryId;
@property(nonatomic,assign)int cabinetId;
@property(nonatomic,assign)int channelOrderNo;
@property(nonatomic,assign)int deviceType;
@property(nonatomic,assign)int duration;
@property(nonatomic,assign)int gridId;
@property(nonatomic,assign)int gridNum;
@property(nonatomic,strong)NSNumber *ID;
@property(nonatomic,assign)int leaseDuration;
@property(nonatomic,assign)double lossAmount;
@property(nonatomic,assign)double couponDiscountAmount;
@property(nonatomic,assign)double couponLimitAmount;
@property(nonatomic,assign)int couponId;
@property(nonatomic,assign)int memberId;
@property(nonatomic,assign)int memberPhoneNum;
@property(nonatomic,copy)NSString* orderNo;
@property(nonatomic,assign)int originalOrderId;
@property(nonatomic,assign)int overdueAmount;
@property(nonatomic,assign)int payMethod;
@property(nonatomic,assign)int payStatus;
@property(nonatomic,assign)int pid;
@property(nonatomic,assign)int planId;
@property(nonatomic,assign)int refundChannel;
@property(nonatomic,assign)int refundRent;
@property(nonatomic,assign)int refundStatus;
@property(nonatomic,assign)int name;
@property(nonatomic,assign)int storeId;
@property(nonatomic,assign)int type;
@property(nonatomic,assign)int unfreeze;
@property(nonatomic,copy)NSString* agentName;
@property(nonatomic,copy)NSString* appid;
@property(nonatomic,copy)NSString* batteryNumber;
@property(nonatomic,copy)NSString* batteryTypeName;
@property(nonatomic,copy)NSString* buyerId;
@property(nonatomic,copy)NSString* createAt;
@property(nonatomic,copy)NSString* endDate;
@property(nonatomic,copy)NSString* forceAt;
@property(nonatomic,copy)NSString* forceUserName;
@property(nonatomic,copy)NSString* fundChannel;
@property(nonatomic,copy)NSString* memberRealName;
@property(nonatomic,copy)NSString* nickname;
@property(nonatomic,copy)NSString* payDate;
@property(nonatomic,copy)NSString* planName;
@property(nonatomic,copy)NSString* refundDate;
@property(nonatomic,copy)NSString* refundLaunchDate;
@property(nonatomic,copy)NSString* refundMemo;
@property(nonatomic,copy)NSString* reviewName;
@property(nonatomic,copy)NSString* startDate;
@property(nonatomic,copy)NSString* storeName;
@property(nonatomic,copy)NSString* tradeType;
@property(nonatomic,copy)NSString* locomotiveNumber;
@property(nonatomic,assign)double batteryMileage;
@property(nonatomic,assign)double deposit;
@property(nonatomic,assign)double paidAmount;
@property(nonatomic,assign)double paidRefundAmount;
@property(nonatomic,assign)double payableAmount;
@property(nonatomic,assign)double refundAmount;
@property(nonatomic,assign)double refundDeposit;
@property(nonatomic,assign)double rent;
@property(nonatomic,assign)double totalAmount;
@property(nonatomic,assign)int payVoucherDays;

@end

NS_ASSUME_NONNULL_END
