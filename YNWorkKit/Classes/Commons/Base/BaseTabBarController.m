//
//  BaseTabBarController.m
//  YNWorkKit
//
//  Created by zyn on 2016/11/15.
//  Copyright © 2016年 张艳能. All rights reserved.
//

#import "BaseTabBarController.h"
#import "YALCustomHeightTabBar.h"
@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YALCustomHeightTabBar *tabBar = [[YALCustomHeightTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
    
//    [self setupTabBarController];
    
    [self addViewController:@"NearbyViewController"];
    [self addViewController:@"HomeViewController"];
    [self addViewController:@"ChatViewController"];
    [self addViewController:@"SettingViewController"];
    
    self.automaticallyAdjustsScrollViewInsets = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addViewController:(NSString *)childVC {
    Class clase = NSClassFromString(childVC);
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[clase alloc] init]];
    [self addChildViewController:nav];
}


@end
