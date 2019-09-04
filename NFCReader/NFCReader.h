//
//  NFCReader.h
//  NFCReader
//
//  Created by Vitaly Dyachkov on 9/4/19.
//  Copyright © 2019 Vitaly Dyachkov. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NFCReader : NSObject

+ (NSString *)readMessage:(NFCNDEFMessage *)message;

@end

NS_ASSUME_NONNULL_END
