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

- (void)presentAVPlayerWithItemAtURL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
