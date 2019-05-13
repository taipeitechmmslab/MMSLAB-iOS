//
//  AppDelegate.m
//  Lab14-Cloud Message
//
//  Created by 張力元 on 2019/5/3.
//  Copyright © 2019 張力元. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
#import <Firebase.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //===向使用者要求推播的權限===
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert |
    UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
    [[UNUserNotificationCenter currentNotificationCenter]
     requestAuthorizationWithOptions:authOptions
     completionHandler:^(BOOL granted, NSError * _Nullable error) {
         if (granted)
             NSLog(@"允許");
         else
             NSLog(@"不允許");
     }];
    //========================
    //註冊APNs
    [application registerForRemoteNotifications];
    //註冊Firebase
    [FIRApp configure];
    return YES;
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

//接收到Firebase推播後執行的函式，可透過notification參數讀取夾帶資料，completionHandler參數設定顯示的內容，
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    //設定推播要顯示的內容，「Sound」為開啟推播的聲音，「Alert」為顯示內容
    completionHandler(UNNotificationPresentationOptionSound|
                      UNNotificationPresentationOptionAlert);
    //顯示Firebase後台通知設定「其他選項」內的自訂資料，使用「userInfo」字典參數，並透過「valueForKey:」函式取得資料
    NSLog(@"%@",[notification.request.content.userInfo valueForKey:@"key"]);
}

@end
