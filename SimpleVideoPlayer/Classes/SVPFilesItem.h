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

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, readonly, getter=isAudiovisualContent) BOOL audioVisualContent;
@property (nonatomic, readonly, getter=isDirectory) BOOL directory;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithName:(NSString *)name directory:(BOOL)directory NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
