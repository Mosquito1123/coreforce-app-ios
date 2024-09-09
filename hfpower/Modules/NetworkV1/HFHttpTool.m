//
//  HFHttpTool.m
//  hfpower
//
//  Created by EDY on 2024/9/9.
//

#import "HFHttpTool.h"
#import "URLString.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "HFKeyedArchiverTool.h"
#import "hfpower-Swift.h"
@implementation HFUpLoadContent

@end
@interface HFHttpTool ()
@property(nonatomic,strong)NSDateFormatter* formatter;
@end
@implementation HFHttpTool
+ (instancetype)share{
    static HFHttpTool *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HFHttpTool alloc]initWithBaseURL:[NSURL URLWithString:rootRequest]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/plain", @"text/javascript",@"text/html",@"image/png",@"image/jpeg", nil];
        AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        //是否允许CA不信任的证书通过
        policy.allowInvalidCertificates = YES;
        //是否验证主机名
        policy.validatesDomainName = NO;
        manager.securityPolicy = policy;
        manager.requestSerializer.timeoutInterval = 10;
    });
    return manager;
}
+(void)NetworkData:(NSString *)request url:(NSString *)url param:(NSDictionary *)param success:(requestSuccessBlock)returnSuccess error:(requestErrorBlock)returnError{
    NSMutableDictionary* header=[NSMutableDictionary dictionary];
    header[@"createTime"]=[HFKeyedArchiverTool getCurrentTimes];
    NSInteger requestNo=arc4random();
    header[@"requestNo"]=[NSString stringWithFormat:@"%ld",(long)requestNo];
    if ([HFKeyedArchiverTool account].accessToken) {
        header[@"access_token"]=[HFKeyedArchiverTool account].accessToken;
    }
    NSMutableDictionary* getParam=[NSMutableDictionary dictionary];
    [getParam addEntriesFromDictionary:header];
    [getParam addEntriesFromDictionary:param];
    if ([request isEqual:@"GET"]) {
        [[HFHttpTool share]GET:url parameters:getParam headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
            switch (urlResponse.statusCode) {
                case 200:
                    if (returnSuccess) {
                        NSLog(@"😁😁😁😁返回值%@",responseObject);
                        returnSuccess(responseObject);
                    }
                    break;
                case 401:
                    [self code401];
                    break;
                default:
                    [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"请求失败，状态码是: %ld",urlResponse.statusCode]];
                    break;
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
            switch (urlResponse.statusCode) {
                case 401:
                    [self code401];
                    break;
                default:
                    if (returnError) {
                        NSLog(@"😭😭😭😭返回值%@",error);
                        returnError(error);
                    }
                    break;
            }
        }];
    }
    NSMutableDictionary* params=[NSMutableDictionary dictionary];
    params[@"body"]=param;
    params[@"head"]=header;
    if ([HFKeyedArchiverTool account].accessToken) {
        url=[NSString stringWithFormat:@"%@?requestNo=%ld&createTime=%@&access_token=%@",url,(long)requestNo,[HFKeyedArchiverTool getCurrentTimes],[HFKeyedArchiverTool account].accessToken];
        url=[url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    if ([request isEqual:@"POST"]) {
        [[HFHttpTool share]POST:url parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
            switch (urlResponse.statusCode) {
                case 200:
                    if (returnSuccess) {
                        //                        NSLog(@"😁😁😁😁返回值%@",responseObject);
                        returnSuccess(responseObject);
                    }
                    break;
                case 401:
                    [self code401];
                    break;
                default:
                    [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"Request failed with status: %ld",urlResponse.statusCode]];
                    break;
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
            
            switch (urlResponse.statusCode) {
                case 401:
                    [self code401];
                    break;
                default:
                    if (returnError) {
                        NSLog(@"😭😭😭😭网络请求失败，返回值%@",error);
                        returnError(error);
                    }
                    break;
            }
        }];
    }
}
+(void)uploadData:(NSString *)url parameter:(id)parameters uploadParam:(HFUpLoadContent *)uploadParam progress:(void (^)(id _Nonnull))progress success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure{
    NSMutableDictionary* header=[NSMutableDictionary dictionary];
    header[@"createTime"]=[HFKeyedArchiverTool getCurrentTimes];
    NSInteger requestNo=arc4random();
    header[@"requestNo"]=[NSString stringWithFormat:@"%ld",(long)requestNo];
    if ([HFKeyedArchiverTool account].accessToken) {
        header[@"access_token"]=[HFKeyedArchiverTool account].accessToken;
    }
    NSMutableDictionary* params=[NSMutableDictionary dictionary];
    params[@"body"]=parameters;
    NSString* urls=[NSString stringWithFormat:@"%@?requestNo=%ld&createTime=%@&access_token=%@",url,(long)requestNo,[HFKeyedArchiverTool getCurrentTimes],[HFKeyedArchiverTool account].accessToken];
    urls=[urls stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [[HFHttpTool share]POST:urls parameters:params headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.fileName mimeType:uploadParam.mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
        switch (urlResponse.statusCode) {
            case 200:
                if (success) {
                    //                            NSLog(@"😁😁😁返回值%@",responseObject);
                    success(responseObject);
                }
                break;
            case 401:
                [self code401];
                break;
            default:
                [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"请求失败 状态码是: %ld",urlResponse.statusCode]];
                break;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)task.response;
        switch (urlResponse.statusCode) {
            case 401:
                [self code401];
                break;
            default:
                if (failure) {
                    NSLog(@"😭😭😭😭返回值%@",error);
                    failure(error);
                }
                break;
        }
    }];
}
+(void)code401{
    [SVProgressHUD showInfoWithStatus:@"登录信息已过期，请重新登陆"];
    [HFKeyedArchiverTool removeData];
    
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:loginVC];
    // 获取当前活跃的 UIWindowScene
    UIWindow *window = [HFHttpTool getCurrentWindow];
    
    // 设置根视图控制器
    window.rootViewController = navigationController;
    [window makeKeyAndVisible];
}

+ (UIWindow *)getCurrentWindow {
    // 获取当前的活跃场景
    UIWindow *keyWindow = nil;
    for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes) {
        if (windowScene.activationState == UISceneActivationStateForegroundActive) {
            for (UIWindow *window in windowScene.windows) {
                if (window.isKeyWindow) {
                    keyWindow = window;
                    break;
                }
            }
        }
    }
    return keyWindow;
}
//+(NSString*)dataString{
//    NSDate *currentDate = [NSDate date];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"];
//    NSString *formattedDate = [dateFormatter stringFromDate:currentDate];
//    return formattedDate;
//}
@end

