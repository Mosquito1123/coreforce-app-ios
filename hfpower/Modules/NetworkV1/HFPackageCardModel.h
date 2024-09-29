//
//  HFPackageCardModel.h
//  hfpower
//
//  Created by EDY on 2024/9/11.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFPackageCardModel : NSObject
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, strong) NSNumber *originalPrice;
@property (nonatomic, copy) NSString *provinceCode;
@property (nonatomic, strong) NSNumber *days;
@property (nonatomic, strong) NSNumber *deviceType;
@property (nonatomic, strong) NSNumber *sort;
@property (nonatomic, copy) NSString *createAt;
@property (nonatomic, copy) NSString *updateAt;
@property (nonatomic, strong) NSNumber *category;
@property (nonatomic, strong) NSNumber *largeTypeId;
@property (nonatomic, strong) NSNumber *ID;  // ID
@property (nonatomic, copy) NSString *provinceName;
@property (nonatomic, copy) NSString *createBy;
@property (nonatomic, copy) NSString *updateBy;
@property (nonatomic, copy) NSString *cityCode;
@property (nonatomic, copy) NSString *saleToDate;
@property (nonatomic, copy) NSString *saleFromDate;
@property (nonatomic, strong) NSNumber *expirationDays;
@property (nonatomic, strong) NSNumber *price;   // 改为 NSNumber
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, strong) NSNumber *orderCount;
@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, strong) NSNumber *memberId;
@property (nonatomic, strong) NSNumber *frontEndStatus;
@property (nonatomic, strong) NSNumber *usedDays;
@property (nonatomic, strong) NSNumber *recoveryDays;
@property (nonatomic, strong) NSNumber *remainDays;
@property (nonatomic, strong) NSString *refundLaunchDate;
@property (nonatomic, strong) NSString *phoneNum;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) NSNumber *refundStatus;
@property (nonatomic, strong) NSNumber *payVoucherOrderId;
@property (nonatomic, strong) NSNumber *mainId;
@property (nonatomic, strong) NSString *orderStartDate;
@property (nonatomic, strong) NSNumber *webStatus;
@property (nonatomic, strong) NSString *startDate;
@property (nonatomic, strong) NSString *orderEndDate;
@property (nonatomic, strong) NSString *endDate;
@property (nonatomic, strong) NSString *orderPayDate;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) NSNumber *selected;
@property (nonatomic, strong) NSNumber *cellType;
@property (nonatomic, strong) NSNumber *count;

@end

NS_ASSUME_NONNULL_END
