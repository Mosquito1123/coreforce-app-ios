//
//  HFPayData.h
//  hfpower
//
//  Created by EDY on 2024/9/12.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFPayData : NSObject
@property(nonatomic,copy)NSString* appid;
@property(nonatomic,copy)NSString* noncestr;
@property(nonatomic,copy)NSString* package;
@property(nonatomic,copy)NSString* prepayId;
@property(nonatomic,copy)NSString* sign;
@property(nonatomic,assign)int partnerid;
@property(nonatomic,assign)int timestamp;
@end

NS_ASSUME_NONNULL_END
