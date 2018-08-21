//
//  ABDevicesInfo.h
//  anbang_ios
//
//  Created by 张艳能 on 2017/12/27.
//  Copyright © 2017年 ch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABDevicesInfo : NSObject

//手机型号
+ (NSString *)phoneModel;

//设备名称
+ (NSString *)deviceName;

//手机系统版本
+ (NSString *)phoneVersion;

//手机别名：用户定义的名称  
+ (NSString *)userPhoneName;

//IP地址
+ (NSString *)IPAdress;

@end
