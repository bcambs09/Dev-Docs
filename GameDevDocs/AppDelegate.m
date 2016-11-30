//
//  AppDelegate.m
//  GameDevDocs
//
//  Created by Brendan Campbell on 11/26/14.
//  Copyright (c) 2014 Wolverine Games LLC. All rights reserved.
//

#import "AppDelegate.h"
#import "DocumentViewController.h"
#import "ViewController.h"
#import "DocDatabase.h"
#import "AppsFlyerTracker.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSMutableArray *loadedDocs = [DocDatabase loadGameDocs];
    ViewController *controller = (ViewController*) self.window.rootViewController;
    controller.files = loadedDocs;
    
    [AppsFlyerTracker sharedTracker].appsFlyerDevKey = @"vKcG5u92uJa4bMvcQ3eYA";
    [AppsFlyerTracker sharedTracker].appleAppID = @"1000915481";
    
    UIColor *modernRed = [UIColor colorWithRed:207.0/255.0 green:17.0/255.0 blue:45.0/255.0 alpha:1.0f];
    
    
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowColor = [UIColor blackColor];
    shadow.shadowOffset = CGSizeMake(-1, -1);
    
    [[UINavigationBar appearance] setBarTintColor:modernRed];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                               [UIColor whiteColor], NSForegroundColorAttributeName,
                                               [UIFont fontWithName:@"Exo-Regular" size:24.0], NSFontAttributeName,
                                               shadow, NSShadowAttributeName, nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    //[[UIBarButtonItem appearance] setTitleTextAttributes:navbarTitleTextAttributes forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    
    NSDictionary *barButtonAppearanceDict = @{NSFontAttributeName : [UIFont fontWithName:@"Exo-Regular" size:18.0], NSForegroundColorAttributeName: [UIColor whiteColor]};
    [[UIBarButtonItem appearance] setTitleTextAttributes:barButtonAppearanceDict forState:UIControlStateNormal];
    
    [[UITabBar appearance] setBarTintColor:modernRed];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor whiteColor], NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    
    UIColor * titleHighlightedColor = [UIColor colorWithRed:243.0/255.0 green:154.0/255.0 blue:150.0/255.0 alpha:1.0f];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       titleHighlightedColor, NSForegroundColorAttributeName, [UIFont fontWithName:@"Exo-Regular" size:12.0], NSFontAttributeName,
                                                       nil] forState:UIControlStateNormal];
    
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // Track Installs, updates & sessions(app opens) (You must include this API to enable tracking)
    [[AppsFlyerTracker sharedTracker] trackAppLaunch];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
