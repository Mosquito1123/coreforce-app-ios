//
//  HFHttpTool.h
//  hfpower
//
//  Created by EDY on 2024/9/9.
//

#import "AFHTTPSessionManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface HFUpLoadContent : NSObject
/**
 *  上传文件的二进制数据
 */
@property (nonatomic, strong) NSData *data;
/**
 *  上传的参数名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  上传到服务器的文件名称
 */
@property (nonatomic, copy) NSString *fileName;
/**
 *  上传文件的类型
 */
@property (nonatomic, copy) NSString *mimeType;
@end
typedef void(^requestSuccessBlock)(id responseObject);
typedef void(^requestErrorBlock)(NSError *error);
typedef void(^upLoadDataBlock)(id upLoadData);
@interface HFHttpTool : AFHTTPSessionManager
@property(nonatomic,copy)NSString* access_token;
+(void)NetworkData:(NSString*)request url:(NSString*)url param:(NSDictionary *)param
       success:(requestSuccessBlock)returnSuccess
         error:(requestErrorBlock)returnError;
+(void)uploadData:(NSString*)url parameter:(id)parameters uploadParam:(HFUpLoadContent*)uploadParam progress:(void(^)(id upLoadData))progress success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END

