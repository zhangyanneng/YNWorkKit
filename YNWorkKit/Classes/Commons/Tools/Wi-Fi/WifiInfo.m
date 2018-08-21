//
//  WifiInfo.m
//  anbang_ios
//
//  Created by 张艳能 on 2017/11/9.
//  Copyright © 2017年 ch. All rights reserved.
//

#import "WifiInfo.h"
#import <SystemConfiguration/CaptiveNetwork.h>

@implementation WifiInfo

#pragma mark - public
+ (NSString *)macAddress {
    NSDictionary *dict = [[self class] wifiInfo];
    NSString *bssid = [dict objectForKey:@"BSSID"];
    
    return bssid;
}

+ (NSString *)wifiName {
    NSDictionary *dict = [[self class] wifiInfo];
    NSString *ssid = [dict objectForKey:@"SSID"];
    
    return ssid;
}

#pragma mark - private

/**
 获取wifi信息，NSDictionary 信息格式：
 {
     BSSID = "ac:bc:32:79:18:95";
     SSID = zyn;
     SSIDDATA = <7a796e>;
  }
 */
+ (NSDictionary *)wifiInfo {
    NSArray *ifs = CFBridgingRelease(CNCopySupportedInterfaces());
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((CFStringRef)ifnam);
        if (info && [info count]) {
            break;
        }
    }
    NSDictionary *dict = (NSDictionary *)info;
    return dict;
}


@end
