//
//  AppDelegate.m
//  翻版新浪微博
//
//  Created by mac on 15-2-20.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "AppDelegate.h"
#import "WBTabBarController.h"
#import "WBNewFeatureController.h"
#import "WBOAuthController.h"
#import "WBAccountTool.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *win = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window = win;
    if ( [WBAccountTool account] ) {
        [self switchToMainViewController];
    } else {
        win.rootViewController = [[WBOAuthController alloc] init];
    }
    [win makeKeyAndVisible];
    [self setUpBangeNumberRegist];
    return YES;
}

#pragma mark - 注册应用图标的权限
- (void)setUpBangeNumberRegist{
    if ( iOS8 ) {
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    }
}

#pragma mark - 跳转控制器
- (void)switchToMainViewController{
    NSNumber *storeVersionNumber = [[NSUserDefaults standardUserDefaults] valueForKeyPath:@"CFBundleVersion"];
    NSNumber *currVersionNumer = [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];
    UIViewController *showViewController = nil;
    if ( storeVersionNumber == nil || storeVersionNumber.floatValue < currVersionNumer.floatValue ) {
        [[NSUserDefaults standardUserDefaults] setValue:currVersionNumer forKeyPath:@"CFBundleVersion"];
        showViewController = [[WBNewFeatureController alloc] init];
    } else {
        showViewController = [[WBTabBarController alloc] init];
    }
    self.window.rootViewController = showViewController;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
