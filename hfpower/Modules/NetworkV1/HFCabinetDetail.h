//
//  HFCabinetDetail.h
//  hfpower
//
//  Created by EDY on 2024/9/10.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>
#import "HFCabinet.h"
#import "HFCabinetExchangeForecast.h"
#import "HFGridList.h"
NS_ASSUME_NONNULL_BEGIN

@interface HFCabinetDetail : NSObject
@property (nonatomic,strong)HFCabinet *cabinet;
@property (nonatomic,strong)NSArray<HFGridList *> *gridList;
@property (nonatomic,strong)NSArray<HFCabinetExchangeForecast *> *cabinetExchangeForecast;

@end

NS_ASSUME_NONNULL_END
