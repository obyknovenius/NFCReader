//
//  AppDelegate.m
//  NFCReader
//
//  Created by Vitaly Dyachkov on 8/26/19.
//  Copyright © 2019 Vitaly Dyachkov. All rights reserved.
//

#import <CoreNFC/CoreNFC.h>

#import "AppDelegate.h"

#import "ViewController.h"

#import "NFCReader.h"
#import "DownloadManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    if (![userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]) {
        return NO;
    }

    NFCNDEFMessage *message = userActivity.ndefMessagePayload;

    NSURL *url = [NFCReader readURL:message];
    if (url == nil) {
        return NO;
    }

    [DownloadManager downloadImage:url completionHandler:^(UIImage * _Nonnull image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
            ViewController *viewController = (ViewController *)navigationController.topViewController;
            [viewController setImage:image];
        });
    }];

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


@end
