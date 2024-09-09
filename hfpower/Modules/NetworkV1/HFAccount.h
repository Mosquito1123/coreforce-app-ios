//
//  HFAccount.h
//  hfpower
//
//  Created by EDY on 2024/9/9.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFAccount : NSObject<NSSecureCoding>
@property(nonatomic,strong)NSString *accessToken;//用户登录的token
@property(nonatomic,strong)NSString *accessTokenExpiration;//登录时间
@property(nonatomic,strong)NSString *refreshToken;//刷新token
@property(nonatomic,strong)NSString *refreshTokenExpiration;//刷新时间
@end

NS_ASSUME_NONNULL_END
