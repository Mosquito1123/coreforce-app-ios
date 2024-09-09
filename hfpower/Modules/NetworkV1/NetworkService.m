//
//  NetworkService.m
//  hfpower
//
//  Created by EDY on 2024/9/9.
//

#import "NetworkService.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "HFHttpTool.h"
#import "HFKeyedArchiverTool.h"
#import <MJExtension/MJExtension.h>
#import "URLString.h"
@implementation NSUserDefaults (Extensions)

+ (nullable NSDate *)lastDailyVisitDate {
    NSString *accessToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"account_name"];;
    NSString *aKey = [NSString stringWithFormat:@"lastDailyVisitDate_%@",accessToken];
    return [[NSUserDefaults standardUserDefaults] objectForKey:aKey];
}

+ (void)setLastDailyVisitDate:(NSDate *)date {
    NSString *accessToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"account_name"];;
    NSString *aKey = [NSString stringWithFormat:@"lastDailyVisitDate_%@",accessToken];
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:aKey];
}

+ (void)setHiddenFloatButton:(BOOL)hidden {
    NSString *accessToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"account_name"];;
    NSString *aKey = [NSString stringWithFormat:@"hiddenFloatButton_%@",accessToken];
    [[NSUserDefaults standardUserDefaults] setBool:hidden forKey:aKey];
}

+ (BOOL)hiddenFloatButton {
    NSString *accessToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"account_name"];;
    NSString *aKey = [NSString stringWithFormat:@"hiddenFloatButton_%@",accessToken];
    return [[NSUserDefaults standardUserDefaults] boolForKey:aKey];
}

@end
@implementation UIViewController (HF)


-(void)postData:(NSString *)url param:(NSDictionary *)param isLoading:(BOOL)isLoading success:(void(^)(id responseObject))returnSuccess error:(void(^)(NSError *error))returnError{
    if(isLoading){
        [SVProgressHUD show];
    }
    [HFHttpTool NetworkData:@"POST" url:url param:param success:^(id  _Nonnull responseObject) {
        if(isLoading){
            [SVProgressHUD dismiss];
        }
        if (returnSuccess) {
            if ([responseObject[@"head"][@"retFlag"]isEqualToString:@"00000"]) {
                returnSuccess(responseObject);
            }else{
                if([responseObject[@"head"][@"retFlag"]isEqualToString:@"401"]){
                    [self showToastMessage:@"客户端错误"];

                    NSDictionary *userInfo = @{
                        NSLocalizedDescriptionKey: @"客户端错误",
                        NSLocalizedFailureReasonErrorKey: @"请求参数或者token错误",
                        NSLocalizedRecoverySuggestionErrorKey: @"请检查请求参数或者token是否正确并重试"
                    };

                    NSError *error = [NSError errorWithDomain:NSNetServicesErrorDomain
                                                         code:401
                                                     userInfo:userInfo];
                    returnError(error);
                }else{
                    
                    NSDictionary *userInfo = @{
                        NSLocalizedDescriptionKey: responseObject[@"head"][@"retMsg"],
                        NSLocalizedFailureReasonErrorKey: responseObject[@"head"][@"retMsg"],
                        NSLocalizedRecoverySuggestionErrorKey: responseObject[@"head"][@"retMsg"],
                        @"data":responseObject[@"body"],
                        @"head":responseObject[@"head"]
                    };

                    NSNumber *flag = responseObject[@"head"][@"retFlag"];
                    NSError *error = [NSError errorWithDomain:NSNetServicesErrorDomain
                                                         code:[flag integerValue]
                                                     userInfo:userInfo];
                    returnError(error);

                }
            }
        }
    } error:^(NSError * _Nonnull error) {
        if(isLoading){
            [SVProgressHUD dismiss];
        }
        if (returnError) {
            [self showToastMessage:@"无法访问网络，请检查网络"];
            returnError(error);
        }
    }];
}
-(void)getData:(NSString *)url param:(NSDictionary *)param isLoading:(BOOL)isLoading success:(void(^)(id responseObject))returnSuccess error:(void(^)(NSError *error))returnError{
    if(isLoading){
        [SVProgressHUD show];
    }
    [HFHttpTool NetworkData:@"GET" url:url param:param success:^(id  _Nonnull responseObject) {
        if(isLoading){
            [SVProgressHUD dismiss];
        }
        if (returnSuccess) {
            if ([responseObject[@"head"][@"retFlag"]isEqualToString:@"00000"]) {
                returnSuccess(responseObject);
            }else{
                if([responseObject[@"head"][@"retFlag"]isEqualToString:@"401"]){
                    [self showToastMessage:@"客户端错误"];

                    NSDictionary *userInfo = @{
                        NSLocalizedDescriptionKey: @"客户端错误",
                        NSLocalizedFailureReasonErrorKey: @"请求参数或者token错误",
                        NSLocalizedRecoverySuggestionErrorKey: @"请检查请求参数或者token是否正确并重试"
                    };

                    NSError *error = [NSError errorWithDomain:NSNetServicesErrorDomain
                                                         code:401
                                                     userInfo:userInfo];
                    returnError(error);
                }else{
                    
                    NSDictionary *userInfo = @{
                        NSLocalizedDescriptionKey: responseObject[@"head"][@"retMsg"],
                        NSLocalizedFailureReasonErrorKey: responseObject[@"head"][@"retMsg"],
                        NSLocalizedRecoverySuggestionErrorKey: responseObject[@"head"][@"retMsg"],
                        @"data":responseObject[@"body"]

                    };

                    NSNumber *flag = responseObject[@"head"][@"retFlag"];
                    NSError *error = [NSError errorWithDomain:NSNetServicesErrorDomain
                                                         code:[flag integerValue]
                                                     userInfo:userInfo];
                    returnError(error);

                }
            }
        }
    } error:^(NSError * _Nonnull error) {
        if(isLoading){
            [SVProgressHUD dismiss];
        }
        if (returnError) {
            [self showToastMessage:@"无法访问网络，请检查网络"];
            returnError(error);
        }
    }];
}
-(void)uploadData:(NSString *)url param:(NSDictionary *)param image:(UIImage *)image name:(NSString *)name fileName:(NSString *)fileName success:(void(^)(id responseObject))returnSuccess error:(void(^)(NSError *error))returnError{
    HFUpLoadContent* upLoadParam=[[HFUpLoadContent alloc]init];
    upLoadParam.data=UIImageJPEGRepresentation(image,1);
    upLoadParam.name=name;
    upLoadParam.fileName = fileName;
    upLoadParam.mimeType = @"image/png";
    [SVProgressHUD show];
    [HFHttpTool uploadData:url parameter:param uploadParam:upLoadParam progress:^(id  _Nonnull upLoadData) {
    } success:^(id  _Nonnull responseObject) {
        [SVProgressHUD dismiss];
        if (returnSuccess) {
            if ([responseObject[@"head"][@"retFlag"]isEqualToString:@"00000"]) {
                returnSuccess(responseObject);
            }else{
                [self showToastMessage:responseObject[@"head"][@"retMsg"]];
            }
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        if (returnError) {
            [self showToastMessage:@"无法访问网络，请检查网络"];
            returnError(error);
        }
    }];
}
//中间tos封装
-(void)showToastMessage:(NSString *)toast{
    [SVProgressHUD showInfoWithStatus:toast];
}
-(void)refreshBatteryDataList:(void (^)(void))batteryDataBlock bikeDataBlock:(void (^)(void))bikeDataBlock batteryDepositDataBlock:(void (^)(void))batteryDepositDataBlock completeBlock:(void (^)(id result))completion{
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    [self getData:batteryListUrl param:@{} isLoading:NO success:^(id  _Nonnull responseObject) {
        [HFKeyedArchiverTool saveBatteryDataList:[HFBatteryDetail mj_objectArrayWithKeyValuesArray:responseObject[@"body"][@"pageResult"][@"dataList"]]];
        batteryDataBlock();
        // 异步任务1完成后执行此处代码
        dispatch_group_leave(group);
    } error:^(NSError * _Nonnull error) {
        // 异步任务1完成后执行此处代码
        
        dispatch_group_leave(group);
    }];
    dispatch_group_enter(group);
    [self getData:locomotiveListUrl param:@{} isLoading:NO success:^(id  _Nonnull responseObject) {
        [HFKeyedArchiverTool saveBikeContentList:[HFBikeDetail mj_objectArrayWithKeyValuesArray:responseObject[@"body"][@"pageResult"][@"dataList"]]];
        bikeDataBlock();
        // 异步任务2完成后执行此处代码
        
        dispatch_group_leave(group);
    } error:^(NSError * _Nonnull error) {
        // 异步任务2完成后执行此处代码
        
        dispatch_group_leave(group);
    }];
    dispatch_group_enter(group);
    [self getData:batteryTempOrderInfoUrl param:@{} isLoading:NO success:^(id  _Nonnull responseObject) {
        [HFKeyedArchiverTool saveBatteryDepositOrderInfo:[HFBatteryDepositOrderInfo mj_objectWithKeyValues:responseObject[@"body"][@"batteryTempOrder"]]];
//        [self test];
        batteryDepositDataBlock();
        // 异步任务3完成后执行此处代码
        
        
        dispatch_group_leave(group);
    } error:^(NSError * _Nonnull error) {
        // 异步任务3完成后执行此处代码
        
        dispatch_group_leave(group);
        
    }];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 所有异步任务完成后执行此处代码，可以在这里返回结果
        completion(@[]);
    });
}
@end
