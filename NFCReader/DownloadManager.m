//
//  DownloadManager.m
//  NFCReader
//
//  Created by Vitaly Dyachkov on 9/4/19.
//  Copyright © 2019 Vitaly Dyachkov. All rights reserved.
//

#import <UIkit/UIImage.h>

#import "DownloadManager.h"

@implementation DownloadManager

+ (void)downloadImage:(NSURL *)url completionHandler:(void (^)(UIImage *image))completionHandler {
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        UIImage *image = [UIImage imageWithData:data];
        completionHandler(image);
    }] resume];
}

@end
