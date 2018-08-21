//
//  WifiInfo.h
//  anbang_ios
//
//  Created by 张艳能 on 2017/11/9.
//  Copyright © 2017年 ch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WifiInfo : NSObject

+ (NSString *)macAddress; //BSSID

+ (NSString *)wifiName;  //SSID

@end
