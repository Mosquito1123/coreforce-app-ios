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
@property(nonatomic,strong)NSString* dictType;
@property(nonatomic,strong)NSString* dictInfo;
@property(nonatomic,strong)NSString* key;
@property(nonatomic,strong)NSString* value;

@property(nonatomic,strong)NSNumber* orderIndex;

@end
@interface HFHelpList : NSObject
@property(nonatomic,strong)NSNumber* ID;
@property(nonatomic,strong)NSString* title;
@property(nonatomic,strong)NSString* typeName;
@property(nonatomic,strong)NSNumber* type;
@end

NS_ASSUME_NONNULL_END
