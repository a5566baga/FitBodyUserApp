//
//  AppDelegate.m
//  FItBodyUser
//
//  Created by ben on 17/3/5.
//  Copyright © 2017年 张增强. All rights reserved.
//

#import "AppDelegate.h"
#import "ZZQTabBarViewController.h"
#import "ZZQNetAlertView.h"

@interface AppDelegate ()

@property(nonatomic, strong)ZZQNetAlertView * alertView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [AVOSCloud setApplicationId:@"xqDPunJj8jQcQk8exktvw5UB-gzGzoHsz" clientKey:@"YqkYVhUj2pWRx4r7hQ3gmv1v"];
    self.window = [[UIWindow alloc] init];
    [self initNetTest];
    [self changeController];
    [self initThirdSDK];
    return YES;
}

#pragma 
#pragma mark =============== 网络验证
- (void)initNetTest{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
            //WIFI网络
            _alertView = [[ZZQNetAlertView alloc] initWithFrame:CGRectMake(0, 64, self.window.width, 25) title:@"WIFI网络,正常使用哦~"];
            [self.window addSubview:_alertView];
            [_alertView setViewForAnimal];
        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
            //3G/4G网络
            _alertView = [[ZZQNetAlertView alloc] initWithFrame:CGRectMake(0, 64, self.window.width, 25) title:@"3G/4G网络状态，注意流量哦~"];
            [self.window addSubview:_alertView];
            [_alertView setViewForAnimal];
        }else{
            //无网络
            _alertView = [[ZZQNetAlertView alloc] initWithFrame:CGRectMake(0, 64, self.window.width, 25) title:@"对不起，当前无网络，请查看。。。"];
            [self.window addSubview:_alertView];
            [_alertView setViewForAnimal];
        }
    }];
}

#pragma
#pragma mark =============== 控制器转换
- (void)changeController{
    ZZQTabBarViewController * tabBarVC = [[ZZQTabBarViewController alloc] init];
    self.window.rootViewController = tabBarVC;
    self.window.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

#pragma mark
#pragma mark ===========第三方内容
- (void)initThirdSDK{
    [SMSSDK registerApp:@"1c1f152fc5012" withSecret:@"84f696da3ae6856a957d43ca7f62c461"];
    [AMapServices sharedServices].apiKey =@"52f576984a548e7391b5f0820d88c22c";
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
