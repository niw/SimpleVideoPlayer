//
//  SVPAppNavigationController.h
//  SimpleVideoPlayer
//
//  Created by Yoshimasa Niwa on 11/27/18.
//  Copyright © 2018 Yoshimasa Niwa. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface SVPAppNavigationController : UINavigationController

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)init NS_DESIGNATED_INITIALIZER;

- (void)presentAVPlayerWithItemAtURL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
