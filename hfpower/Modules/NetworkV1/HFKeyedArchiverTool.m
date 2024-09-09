//
//  HFKeyedArchiverTool.m
//  hfpower
//
//  Created by EDY on 2024/9/9.
//

#import "HFKeyedArchiverTool.h"
#import "URLString.h"
@interface HFKeyedArchiverTool ()

@end
@implementation HFKeyedArchiverTool

+(BOOL)saveAccount:(HFAccount *)account{
    NSError *error = nil;
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:account requiringSecureCoding:YES error:&error];
    
    if (archivedData) {
        NSURL *fileURL = [NSURL fileURLWithPath:HFInformationFileName];
        BOOL success = [archivedData writeToURL:fileURL options:NSDataWritingAtomic error:&error];
        
        if (success) {
            NSLog(@"Archiving root object to file succeeded");
            return YES;
        } else {
            NSLog(@"Failed to write archived data to file: %@", error);
        }
    } else {
        NSLog(@"Failed to archive root object: %@", error);
    }
    
    return NO;
}
+(HFAccount*)account{
    NSError *error = nil;
    NSURL *fileURL = [NSURL fileURLWithPath:HFInformationFileName];
    NSData *archivedData = [NSData dataWithContentsOfURL:fileURL options:NSDataReadingMappedIfSafe error:&error];
    
    if (archivedData) {
        HFAccount *unarchivedArray = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithArray:@[[NSNumber class],[NSString class],[HFAccount class]]] fromData:archivedData error:&error];
        
        if (unarchivedArray) {
            NSLog(@"Unarchiving object from file succeeded");
            return unarchivedArray;
        } else {
            NSLog(@"Failed to unarchive object from data: %@", error);
        }
    } else {
        NSLog(@"Failed to read archived data from file: %@", error);
    }
    
    return [[HFAccount alloc]init];
}
+(BOOL)saveBatteryDataList:(NSArray<HFBatteryDetail*>*)dataList{
    NSError *error = nil;
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:dataList requiringSecureCoding:NO error:&error];
    
    if (archivedData) {
        NSURL *fileURL = [NSURL fileURLWithPath:HFBatteryDetailFile];
        BOOL success = [archivedData writeToURL:fileURL options:NSDataWritingAtomic error:&error];
        
        if (success) {
            NSLog(@"Archiving root object to file succeeded");
            return YES;
        } else {
            NSLog(@"Failed to write archived data to file: %@", error);
        }
    } else {
        NSLog(@"Failed to archive root object: %@", error);
    }
    
    return NO;
}
+(NSArray<HFBatteryDetail*>*)batteryDataList{
    NSError *error = nil;
    NSURL *fileURL = [NSURL fileURLWithPath:HFBatteryDetailFile];
    NSData *archivedData = [NSData dataWithContentsOfURL:fileURL options:NSDataReadingMappedIfSafe error:&error];
    
    
    if (archivedData) {
        NSArray<HFBatteryDetail*> *unarchivedArray = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithArray:@[[NSArray class],[NSDictionary class],[NSNumber class],[NSString class],[HFBatteryDetail class]]] fromData:archivedData error:&error];
        
        if (unarchivedArray) {
            NSLog(@"Unarchiving object from file succeeded");
            return unarchivedArray;
        } else {
            NSLog(@"Failed to unarchive object from data: %@", error);
        }
    } else {
        NSLog(@"Failed to read archived data from file: %@", error);
    }
    
    return [NSArray array];
}
+(BOOL)saveBikeContentList:(NSArray<HFBikeDetail*>*)bikeDetailList{
    NSError *error = nil;
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:bikeDetailList requiringSecureCoding:NO error:&error];
    
    if (archivedData) {
        NSURL *fileURL = [NSURL fileURLWithPath:HFBikeDetailFile];
        BOOL success = [archivedData writeToURL:fileURL options:NSDataWritingAtomic error:&error];
        
        if (success) {
            NSLog(@"Archiving root object to file succeeded");
            return YES;
        } else {
            NSLog(@"Failed to write archived data to file: %@", error);
        }
    } else {
        NSLog(@"Failed to archive root object: %@", error);
    }
    
    return NO;
}
+(NSArray<HFBikeDetail*> *)bikeDetailList{
    NSError *error = nil;
    NSURL *fileURL = [NSURL fileURLWithPath:HFBikeDetailFile];
    NSData *archivedData = [NSData dataWithContentsOfURL:fileURL options:NSDataReadingMappedIfSafe error:&error];
    
    if (archivedData) {
        NSArray<HFBikeDetail*> *unarchivedArray = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithArray:@[[NSArray class],[NSDictionary class],[NSNumber class],[NSString class],[HFBikeDetail class]]] fromData:archivedData error:&error];
        
        if (unarchivedArray) {
            NSLog(@"Unarchiving object from file succeeded");
            return unarchivedArray;
        } else {
            NSLog(@"Failed to unarchive object from data: %@", error);
        }
    } else {
        NSLog(@"Failed to read archived data from file: %@", error);
    }
    
    return [NSArray array];
}
+(BOOL)saveActivityList:(NSArray<HFActivityListModel *> *)activityList{
    NSError *error = nil;
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:activityList requiringSecureCoding:NO error:&error];
    
    if (archivedData) {
        NSURL *fileURL = [NSURL fileURLWithPath:HFActivityListFile];
        BOOL success = [archivedData writeToURL:fileURL options:NSDataWritingAtomic error:&error];
        
        if (success) {
            NSLog(@"Archiving root object to file succeeded");
            return YES;
        } else {
            NSLog(@"Failed to write archived data to file: %@", error);
        }
    } else {
        NSLog(@"Failed to archive root object: %@", error);
    }
    
    return NO;
}
+(NSArray<HFActivityListModel *>*)activityList{
    NSError *error = nil;
    NSURL *fileURL = [NSURL fileURLWithPath:HFActivityListFile];
    NSData *archivedData = [NSData dataWithContentsOfURL:fileURL options:NSDataReadingMappedIfSafe error:&error];
    
    if (archivedData) {
        NSArray<HFActivityListModel *> *unarchivedArray = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithArray:@[[NSArray class],[NSDictionary class],[NSNumber class],[NSString class],[HFActivityListModel class]]] fromData:archivedData error:&error];
        
        if (unarchivedArray) {
            NSLog(@"Unarchiving object from file succeeded");
            return unarchivedArray;
        } else {
            NSLog(@"Failed to unarchive object from data: %@", error);
        }
    } else {
        NSLog(@"Failed to read archived data from file: %@", error);
    }
    
    return [NSArray array];
}
+ (BOOL)saveBatteryDepositOrderInfo:(HFBatteryDepositOrderInfo *)batteryDepositOrderInfo {
    NSError *error = nil;
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:batteryDepositOrderInfo requiringSecureCoding:NO error:&error];
    
    if (archivedData) {
        NSURL *fileURL = [NSURL fileURLWithPath:HFBatteryDepositOrderInfoFile];
        BOOL success = [archivedData writeToURL:fileURL options:NSDataWritingAtomic error:&error];
        
        if (success) {
            NSLog(@"Archiving root object to file succeeded");
            return YES;
        } else {
            NSLog(@"Failed to write archived data to file: %@", error);
        }
    } else {
        NSLog(@"Failed to archive root object: %@", error);
    }
    
    return NO;
}

+ (HFBatteryDepositOrderInfo *)batteryDepositOrderInfo {
    NSError *error = nil;
    NSURL *fileURL = [NSURL fileURLWithPath:HFBatteryDepositOrderInfoFile];
    NSData *archivedData = [NSData dataWithContentsOfURL:fileURL options:NSDataReadingMappedIfSafe error:&error];
    
    if (archivedData) {
        HFBatteryDepositOrderInfo *unarchivedArray = [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithArray:@[[NSNumber class],[NSString class],[HFBatteryDepositOrderInfo class]]] fromData:archivedData error:&error];
        
        if (unarchivedArray) {
            NSLog(@"Unarchiving object from file succeeded");
            return unarchivedArray;
        } else {
            NSLog(@"Failed to unarchive object from data: %@", error);
        }
    } else {
        NSLog(@"Failed to read archived data from file: %@", error);
    }
    
    return [[HFBatteryDepositOrderInfo alloc]init];
}


//时间戳转换
+(NSString*)getCurrentTimes{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
}
//优惠券时间判断
+(NSInteger)pleaseStarTimes:(NSString*)starTime andEndTime:(NSString*)endTime isDay:(BOOL)isDay{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"];
    NSDate *date1 = [formatter dateFromString:starTime];
    NSDate *date2 = [formatter dateFromString:endTime];
    //    NSString* dateStr;
    NSTimeInterval time=[date2 timeIntervalSinceDate:date1];
    int daySeconds = 60;
    if(isDay){
        daySeconds = 24 * 60 * 60;
    }
    NSInteger day=time/daySeconds;
    return day;
}

//剩余时间的判断
+(NSString*)pleaseEndTime:(NSString*)endTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"];
    NSDate *date2 = [formatter dateFromString:endTime];
    NSTimeInterval now = [[NSDate date]timeIntervalSince1970];
    NSTimeInterval beTime=[date2 timeIntervalSince1970];
    double time=beTime - now;
    if (time < 0) {
        return @"已过期";
    } else if (time < 24 * 60 * 60) {
        int hours = floor(fabs(time) / (60 * 60));
        return [NSString stringWithFormat:@"%d小时", hours];
    } else {
        int days = floor(fabs(time) / (24 * 60 * 60));
        return [NSString stringWithFormat:@"%d天", days];
    }
}

+(void)removeData{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:HFInformationFileName error:nil];
    [fileManager removeItemAtPath:HFBatteryDetailFile error:nil];
    [fileManager removeItemAtPath:HFBikeDetailFile error:nil];
    [fileManager removeItemAtPath:HFActivityListFile error:nil];
    [fileManager removeItemAtPath:HFBatteryDepositOrderInfoFile error:nil];
    
}
+(void)removeBatteryData{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:HFBatteryDetailFile error:nil];
}
@end
