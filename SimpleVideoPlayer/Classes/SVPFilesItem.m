//
//  SVPFilesItem.m
//  SimpleVideoPlayer
//
//  Created by Yoshimasa Niwa on 11/27/18.
//  Copyright © 2018 Yoshimasa Niwa. All rights reserved.
//

#import "SVPFilesItem.h"

@import MobileCoreServices;
@import os.log;

NS_ASSUME_NONNULL_BEGIN

@implementation SVPFilesItem

- (instancetype)init
{
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (instancetype)initWithPath:(NSString *)path
{
    if (self = [super init]) {
        _path = [path copy];

        CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)path.pathExtension, nil);
        _audioVisualContent = UTTypeConformsTo(UTI, kUTTypeAudio) || UTTypeConformsTo(UTI, kUTTypeMovie);

        NSError *error = nil;
        NSDictionary * const attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:&error];
        if (error) {
            os_log_error(OS_LOG_DEFAULT, "Failed to read attributes of item at path: %@ error: %@", path, error);
        } else {
            NSString * const fileType = attributes[NSFileType];
            _directory = [fileType isEqualToString:NSFileTypeDirectory];
        }
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
