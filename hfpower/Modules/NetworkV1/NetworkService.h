//
//  NetworkService.h
//  hfpower
//
//  Created by EDY on 2024/9/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSUserDefaults (Extensions)
+ (BOOL)hiddenFloatButton;
+ (void)setHiddenFloatButton:(BOOL)hidden;
+ (nullable NSDate *)lastDailyVisitDate;
+ (void)setLastDailyVisitDate:(NSDate *)date;

@end
@interface UIViewController (HF)
-(void)postData:(NSString*)url param:(NSDictionary*)param isLoading:(BOOL)isLoading success:(void(^)(id responseObject))returnSuccess
error:(void(^)(NSError *error))returnError;
-(void)getData:(NSString *)url
          param:(NSDictionary *)param isLoading:(BOOL)isLoading
        success:(void(^)(id responseObject))returnSuccess
          error:(void(^)(NSError *error))returnError;
-(void)uploadData:(NSString*)url param:(NSDictionary*)param image:(UIImage*)image name:(NSString*)name fileName:(NSString*)fileName success:(void(^)(id responseObject))returnSuccess error:(void(^)(NSError *error))returnError;
-(void)showToastMessage:(NSString *)toast;
//刷新电池列表接口
-(void)refreshBatteryDataList:(void (^)(void))batteryDataBlock bikeDataBlock:(void (^)(void))bikeDataBlock batteryDepositDataBlock:(void (^)(void))batteryDepositDataBlock completeBlock:(void (^)(id result))completion;
@end

NS_ASSUME_NONNULL_END
