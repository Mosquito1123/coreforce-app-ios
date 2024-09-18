//
//  HFMember.h
//  hfpower
//
//  Created by EDY on 2024/9/10.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFMember : NSObject
@property(nonatomic,assign)int agreement;
@property(nonatomic,copy)NSString* agreementAt;
@property(nonatomic,copy)NSString* authAt;
@property(nonatomic,copy)NSString* customStore;
@property(nonatomic,strong)NSNumber *ID;
@property(nonatomic,strong)NSNumber *isAuth;
@property(nonatomic,copy)NSString* phoneNum;
@property(nonatomic,copy)NSString* nickname;
@property(nonatomic,copy)NSString* realName;
@property(nonatomic,copy)NSNumber* status;
@property(nonatomic,copy)NSString* wxOpenid;
@end

NS_ASSUME_NONNULL_END
