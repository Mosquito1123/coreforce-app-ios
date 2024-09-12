//
//  HFHelpList.h
//  hfpower
//
//  Created by EDY on 2024/9/12.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN
@interface HFHelpDict : NSObject
@property(nonatomic,strong)NSNumber* ID;
@property(nonatomic,strong)NSString* title;
@end
@interface HFHelpList : NSObject
@property(nonatomic,strong)NSNumber* ID;
@property(nonatomic,strong)NSString* typeName;
@property(nonatomic,strong)NSString* title;
@property(nonatomic,strong)NSString* content;
@end

NS_ASSUME_NONNULL_END
