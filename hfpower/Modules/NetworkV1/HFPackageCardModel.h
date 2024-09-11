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

@end

NS_ASSUME_NONNULL_END
