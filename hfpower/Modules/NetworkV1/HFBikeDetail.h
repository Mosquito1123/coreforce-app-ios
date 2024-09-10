//
//  HFBikeDetail.h
//  hfpower
//
//  Created by EDY on 2024/9/9.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFBikeDetail : NSObject<NSSecureCoding>
@property(nonatomic,assign)NSInteger agentId;
@property(nonatomic,assign)NSInteger memberId;
@property(nonatomic,strong)NSNumber *ID;
@property(nonatomic,assign)NSInteger rentStatus;
@property(nonatomic,assign)NSInteger type;
//@property(nonatomic,assign)int vin;
@property(nonatomic,copy)NSString* vin;
@property(nonatomic,assign)NSInteger memberPhoneNum;
@property(nonatomic,assign)NSInteger originalOrderId;
@property(nonatomic,assign)NSInteger planId;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,copy)NSString* agentName;
@property(nonatomic,copy)NSString* locomotiveEndDate;
@property(nonatomic,copy)NSString* locomotiveStartDate;
@property(nonatomic,copy)NSString* memberNickname;
@property(nonatomic,copy)NSString* planName;
@property(nonatomic,copy)NSString* storeName;
@property(nonatomic,copy)NSString* memberRealName;
@property(nonatomic,copy)NSString* number;
@property(nonatomic,assign)double planDeposit;
@property(nonatomic,assign)double planRent;
@property(nonatomic,assign)double orderDeposit;
@property(nonatomic,assign)double orderRent;
@property(nonatomic,assign)double mileage;
@property(nonatomic,strong,nullable)NSNumber *gdLat;
@property(nonatomic,strong,nullable)NSNumber *gdLon;
@property(nonatomic,strong,nullable)NSNumber *lastLat;
@property(nonatomic,strong,nullable)NSNumber *lastLon;
@end

NS_ASSUME_NONNULL_END
