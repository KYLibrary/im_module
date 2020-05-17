//
//  IMAppDelegate+IM.h
//  im_module_Example
//
//  Created by kyleboy on 2020/5/17.
//  Copyright © 2020 kyleboy. All rights reserved.
//

#import "IMAppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface IMAppDelegate (IM)<EMChatManagerDelegate>

- (void)initIM;
- (void)initHyphenate;

- (void)im_application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
- (void)im_application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;
- (void)im_application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;
- (void)im_application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification;
- (void)im_userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler;
- (void)im_userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler;
@end

NS_ASSUME_NONNULL_END
