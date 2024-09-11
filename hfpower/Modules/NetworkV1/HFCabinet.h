//
//  HFCabinet.h
//  hfpower
//
//  Created by EDY on 2024/9/10.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

NS_ASSUME_NONNULL_BEGIN

@interface HFCabinet : NSObject
@property(nonatomic,assign)NSInteger agentId;
@property(nonatomic,assign)NSInteger agentPhoneNum;
@property(nonatomic,assign)NSInteger batteryCount;
@property(nonatomic,assign)NSInteger cabinetType;
@property(nonatomic,assign)NSInteger gridCount;
@property(nonatomic,strong)NSNumber *ID;
@property(nonatomic,strong)NSNumber *onLine;
@property(nonatomic,strong)NSNumber *status;
@property(nonatomic,copy)NSString* agentName;
@property(nonatomic,copy)NSString* heartbeatAt;
@property(nonatomic,copy)NSString* location;
@property(nonatomic,strong,nullable)NSString* number;
@property(nonatomic,strong,nullable)NSNumber *bdLat;
@property(nonatomic,strong,nullable)NSNumber *bdLon;
@property(nonatomic,strong,nullable)NSNumber *gdLat;
@property(nonatomic,strong,nullable)NSNumber *gdLon;
@property(nonatomic,strong,nullable)NSNumber *lat;
@property(nonatomic,strong,nullable)NSNumber *lon;
@property(nonatomic,strong,nullable)NSString* photo1;
@property(nonatomic,strong,nullable)NSString* photo2;
@property(nonatomic,strong,nullable)NSString* photo3;
@property(nonatomic,strong)NSNumber *rentReturnBattery;
@end

NS_ASSUME_NONNULL_END
