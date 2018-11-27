//
//  SVPAppNavigationController.m
//  SimpleVideoPlayer
//
//  Created by Yoshimasa Niwa on 11/27/18.
//  Copyright © 2018 Yoshimasa Niwa. All rights reserved.
//

#import "SVPAppNavigationController.h"
#import "SVPFilesViewController.h"

@import AVFoundation;
@import AVKit;

NS_ASSUME_NONNULL_BEGIN

@interface SVPAppNavigationController ()

@end

@implementation SVPAppNavigationController

static NSString * _Nullable UserDocumentDirectory()
{
    NSArray<NSString *> * const directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return directories.firstObject;
}

- (instancetype)init
{
    if (self = [super init]) {
        SVPFilesViewController * const rootViewController = [[SVPFilesViewController alloc] init];
        rootViewController.path = UserDocumentDirectory();
        self.viewControllers = @[rootViewController];
    }
    return self;
}

- (void)presentAVPlayerWithItemAtURL:(NSURL *)URL
{
    if (self.presentedViewController) {
        [self dismissViewControllerAnimated:NO completion:NULL];
    }

    AVPlayerItem * const playerItem = [[AVPlayerItem alloc] initWithURL:URL];
    AVPlayer * const player = [[AVPlayer alloc] initWithPlayerItem:playerItem];

    AVPlayerViewController * const playerViewController = [[AVPlayerViewController alloc] init];
    playerViewController.player = player;

    [self presentViewController:playerViewController animated:YES completion:NULL];
    [player play];
}

@end

NS_ASSUME_NONNULL_END
