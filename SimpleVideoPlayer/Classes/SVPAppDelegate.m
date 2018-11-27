//
//  SVPAppDelegate.m
//  SimpleVideoPlayer
//
//  Created by Yoshimasa Niwa on 11/27/18.
//  Copyright © 2018 Yoshimasa Niwa. All rights reserved.
//

#import "SVPAppDelegate.h"
#import "SVPAppNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SVPAppDelegate ()

@property (nonatomic, nullable) SVPAppNavigationController *appNavigationController;

@end

@implementation SVPAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions
{
    SVPAppNavigationController * const appNavigationController = [[SVPAppNavigationController alloc] init];

    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = UIColor.whiteColor;
    self.window.rootViewController = appNavigationController;
    [self.window makeKeyAndVisible];

    self.appNavigationController = appNavigationController;

    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    NSAssert(self.appNavigationController, @"appNavigationController should be initialized.");
    if (!self.appNavigationController) {
        return YES;
    }

    [self.appNavigationController presentAVPlayerWithItemAtURL:url];

    return YES;
}

@end

NS_ASSUME_NONNULL_END
