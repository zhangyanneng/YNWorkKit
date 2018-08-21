//
//  CLLocation+ABExtend.h
//  anbang_ios
//
//  Created by 张艳能 on 2017/7/5.
//  Copyright © 2017年 ch. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>



/**
 
 API                坐标系
 百度地图API         百度坐标
 腾讯搜搜地图API      火星坐标
 搜狐搜狗地图API      搜狗坐标
 阿里云地图API       火星坐标
 图吧MapBar地图API   图吧坐标
 高德MapABC地图API   火星坐标
 灵图51ditu地图API   火星坐标
 
 */
@interface CLLocation (ABExtend)

//从地图坐标转化到火星坐标
- (CLLocation*)locationMarsFromEarth;

//从火星坐标转化到百度坐标
- (CLLocation*)locationBaiduFromMars;

//从百度坐标到火星坐标
- (CLLocation*)locationMarsFromBaidu;

//从火星坐标到地图坐标
- (CLLocation*)locationEarthFromMars;

//从百度坐标到地图坐标
- (CLLocation*)locationEarthFromBaidu;

@end
