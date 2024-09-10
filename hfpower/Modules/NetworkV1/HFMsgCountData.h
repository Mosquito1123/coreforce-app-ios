//
//  HFMsgCountData.h
//  hfpower
//
//  Created by EDY on 2024/9/10.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFMsgCountData : NSObject
@property (nonatomic,strong) NSNumber *unreadCount;
@property (nonatomic,strong) NSNumber *allCount;
@end

NS_ASSUME_NONNULL_END
