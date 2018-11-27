//
//  SVPFilesItem.h
//  SimpleVideoPlayer
//
//  Created by Yoshimasa Niwa on 11/27/18.
//  Copyright © 2018 Yoshimasa Niwa. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface SVPFilesItem : NSObject

@property (nonatomic, copy, readonly) NSString *path;
@property (nonatomic, readonly, getter=isAudiovisualContent) BOOL audioVisualContent;
@property (nonatomic, readonly, getter=isDirectory) BOOL directory;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithPath:(NSString *)path NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
