//
//  lycAppDelegate.m
//  scollogin
//
//  Created by aotuman on 13-8-22.
//  Copyright (c) 2013年 aotuman. All rights reserved.
//

#import "lycAppDelegate.h"

#import "lycLogin.h"
#import "lycMy.h"
#import "lycReg.h"

@implementation lycAppDelegate

- (void)dealloc
{   
    [_window release];


    [super dealloc];
}
//

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
   
   // NSLog(@"didFinishLaunchingWithOption 加载完成!");
    lycLogin *loginview=[[[lycLogin alloc] init] autorelease];
    UINavigationController *loginpage=[[[UINavigationController alloc] initWithRootViewController:loginview] autorelease];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
  
    self.window.rootViewController=loginpage;
 
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
   // NSLog(@"applicationWillResignActive 失去焦点");
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
   // NSLog(@"applicationDidEnterBackground 进入后台");
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
   // NSLog(@"applicationWillEnterForeground 进入前台");
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
   // NSLog(@"applicationDidBecomeActive 获取焦点");
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    //NSLog(@"applicationWillTerminate 应用销毁");
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
