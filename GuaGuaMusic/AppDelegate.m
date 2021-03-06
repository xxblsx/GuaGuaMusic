//
//  AppDelegate.m
//  呱呱音乐
//
//  Created by xxb on 15/12/15.
//  Copyright © 2015年 xxb. All rights reserved.
//

#import "AppDelegate.h"
#import "SearchViewController.h"
#import "GlobalPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GlobalPlayer player];
    SearchViewController *singersTableViewController = [[SearchViewController alloc] init];
    singersTableViewController.title = @"GGMusic";
    UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:singersTableViewController];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = naviVC;
    [self.window makeKeyAndVisible];
    NSString* path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSLog(@"%@", path);
    //后台播放音乐设置
    NSError* error;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    if ([GlobalPlayer state] == STKAudioPlayerStatePlaying||[GlobalPlayer state] == STKAudioPlayerStateBuffering||[GlobalPlayer state] == STKAudioPlayerStatePaused ||[GlobalPlayer state] == STKAudioPlayerStateStopped) {
        //有音乐播放时，才给后台权限，不做流氓应用。
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        [self becomeFirstResponder];
    }
    else
    {
        [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
        [self resignFirstResponder];
    }
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
