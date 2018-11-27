//
//  SVPFilesItem.m
//  SimpleVideoPlayer
//
//  Created by Yoshimasa Niwa on 11/27/18.
//  Copyright © 2018 Yoshimasa Niwa. All rights reserved.
//

#import "SVPFilesItem.h"

@import MobileCoreServices;

NS_ASSUME_NONNULL_BEGIN

@implementation SVPFilesItem

- (instancetype)init
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (instancetype)initWithName:(NSString *)name directory:(BOOL)directory
{
    if (self = [super init]) {
        _name = [name copy];

        CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)_name.pathExtension, nil);
        _audioVisualContent = UTTypeConformsTo(UTI, kUTTypeAudio) || UTTypeConformsTo(UTI, kUTTypeMovie);

        _directory = directory;
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
