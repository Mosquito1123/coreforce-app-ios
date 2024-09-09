//
//  HFActivityListModel.h
//  hfpower
//
//  Created by EDY on 2024/9/9.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFActivityListModel : NSObject<NSSecureCoding>
@property(nonatomic,copy)NSString* endTime;
@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* serialNo;
@property(nonatomic,copy)NSString* startTime;
@property(nonatomic,copy)NSString* url;
@property(nonatomic,copy)NSNumber* type;//0邀请活动；1消息公告；
@property(nonatomic,copy)NSString* photo;
@property(nonatomic,copy)NSString* introduction;
@end

NS_ASSUME_NONNULL_END
