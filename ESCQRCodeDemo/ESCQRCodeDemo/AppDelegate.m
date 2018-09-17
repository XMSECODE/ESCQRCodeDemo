//
//  AppDelegate.m
//  decode
//
//  Created by xiangmingsheng on 16/10/29.
//  Copyright © 2016年 xiangmingsheng. All rights reserved.
//

#import "AppDelegate.h"
#import "EncodeQrcodeViewController.h"
#import "XMSDeQRCodeViewController.h"
#import "UIImage+Scale.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions {
    
    [self setHomeViewController];
    
    return YES;
}

- (void)setHomeViewController {
    UIWindow* windoow = [[UIWindow alloc] init];
    
    UITabBarController* tabBarController = [[UITabBarController alloc] init];
    
    EncodeQrcodeViewController* createVC = [[EncodeQrcodeViewController alloc] init];
    UINavigationController* CreateNVC = [[UINavigationController alloc] initWithRootViewController:createVC];
    [tabBarController addChildViewController:CreateNVC];
    CreateNVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"解码" image:[UIImage imageNamed:@"main_tab_my"] selectedImage:[UIImage imageNamed:@"main_tab_my_checked"]];
    
    
    XMSDeQRCodeViewController* DeCodeVC = [[XMSDeQRCodeViewController alloc] init];
    UINavigationController* DeCodeNVC = [[UINavigationController alloc] initWithRootViewController:DeCodeVC];
    [tabBarController addChildViewController:DeCodeNVC];
    DeCodeNVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"扫码" image:[UIImage imageNamed:@"main_tab_search"] selectedImage:[UIImage imageNamed:@"main_tab_search_checked"]];
    
    tabBarController.tabBar.tintColor = [UIColor blackColor];
    windoow.rootViewController = tabBarController;
    
    self.window = windoow;
    [self.window makeKeyAndVisible];
}

@end
