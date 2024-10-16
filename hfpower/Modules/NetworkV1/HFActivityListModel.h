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
@property (nonatomic, strong) NSNumber *ID;  // 活动ID
@property (nonatomic, copy) NSString *title;  // 活动标题
@property (nonatomic, copy) NSString *subtitle;  // 副标题
@property (nonatomic, copy) NSString *regionCode;  // 地区代码
@property (nonatomic, strong) NSNumber *createrType;  // 创建者类型
@property (nonatomic, strong) NSNumber *status;  // 状态
@property (nonatomic, copy) NSString *startAt;  // 开始时间
@property (nonatomic, strong) NSNumber *startBy;  // 开始人ID
@property (nonatomic, copy) NSString *content;  // 公告内容/拉新规则 (html 格式)

@property (nonatomic, strong) NSNumber *inviterAwardType;  // 邀请人奖励类型 (0 佣金, 1 优惠券)
@property (nonatomic, strong) NSNumber *inviterCommissionAmount;  // 邀请人佣金（元）
@property (nonatomic, strong) NSNumber *inviterAwardReceiveDuration;  // 邀请人奖励到账限制时间
@property (nonatomic, strong) NSNumber *inviterAwardLimitDuration;  // 邀请人奖励满足条件的限制时间
@property (nonatomic, copy) NSString *inviterPayVoucherType;  // 邀请人奖励限制的套餐卡类型 (0 普通, 1 限时销售, 2 新人专享)
@property (nonatomic, strong) NSNumber *inviterMinPurchaseDuration;  // 邀请人奖励最低的购买时长（天）
@property (nonatomic, strong) NSNumber *inviterMinUsedDuration;  // 邀请人奖励最低的使用时长（天）
@property (nonatomic, strong) NSNumber *inviterMinOrderQuantity;  // 邀请人奖励最低购买金额（元）

@property (nonatomic, strong) NSNumber *inviteeAwardType;  // 被邀请人奖励类型
@property (nonatomic, strong) NSNumber *inviteeCommissionAmount;  // 被邀请人佣金（元）
@property (nonatomic, strong) NSNumber *inviteeAwardReceiveDuration;  // 被邀请人奖励到账限制时间
@property (nonatomic, strong) NSNumber *inviteeAwardLimitDuration;  // 被邀请人奖励满足条件的限制时间
@property (nonatomic, copy) NSString *inviteePayVoucherType;  // 被邀请人奖励限制的套餐卡类型 (0 普通, 1 限时销售, 2 新人专享)
@property (nonatomic, strong) NSNumber *inviteeMinPurchaseDuration;  // 被邀请人奖励最低的购买时长（天）
@property (nonatomic, strong) NSNumber *inviteeMinUsedDuration;  // 被邀请人奖励最低的使用时长（天）
@property (nonatomic, strong) NSNumber *inviteeMinOrderQuantity;  // 被邀请人奖励最低购买金额（元）

@property (nonatomic, copy) NSString *createBy;  // 创建人
@property (nonatomic, copy) NSString *createAt;  // 创建时间
@property (nonatomic, copy) NSString *updateAt;  // 更新时间
@property (nonatomic, strong) NSNumber *inviteeCount;  // 被邀请人数量
@property (nonatomic, copy) NSString *createByName;  // 创建人名称
@property (nonatomic, copy) NSString *startByName;  // 开始人名称
@property (nonatomic, copy) NSString *areaName;  // 区域名称
@property (nonatomic, copy) NSString *interruptAt;  // 中断时间（可选）
@property (nonatomic, strong) NSNumber *interruptBy;  // 中断人ID（可选）
@property (nonatomic, copy) NSString *updateBy;  // 更新人（可选）
@property (nonatomic, copy) NSString *interruptByName;  // 中断人名称（可选）
@end

NS_ASSUME_NONNULL_END
