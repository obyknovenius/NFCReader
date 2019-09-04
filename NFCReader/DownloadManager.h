//
//  DownloadManager.h
//  NFCReader
//
//  Created by Vitaly Dyachkov on 9/4/19.
//  Copyright © 2019 Vitaly Dyachkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DownloadManager : NSObject

+ (void)downloadImage:(NSURL *)url completionHandler:(void (^)(UIImage *image))completionHandler;

@end

NS_ASSUME_NONNULL_END
