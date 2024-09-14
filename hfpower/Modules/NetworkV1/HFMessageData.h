//
//  HFMessageData.h
//  hfpower
//
//  Created by EDY on 2024/9/14.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFMessageData : NSObject
@property(nonatomic,copy)NSString* createAt;
@property(nonatomic,copy)NSString* memberRealName;
@property(nonatomic,copy)NSString* msg;
@property(nonatomic,copy)NSNumber *ID;
@property(nonatomic,copy)NSNumber *memberId;
@property(nonatomic,copy)NSNumber *memberPhoneNum;
@property(nonatomic,copy)NSNumber *status;
@end

NS_ASSUME_NONNULL_END
