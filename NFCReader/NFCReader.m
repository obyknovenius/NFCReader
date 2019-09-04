//
//  NFCReader.m
//  NFCReader
//
//  Created by Vitaly Dyachkov on 9/4/19.
//  Copyright © 2019 Vitaly Dyachkov. All rights reserved.
//

#import <CoreNFC/CoreNFC.h>

#import "NFCReader.h"

@implementation NFCReader

+ (NSString *)readMessage:(NFCNDEFMessage *)message {
    NFCNDEFPayload *record = message.records[0];

    NSLog(@"Format: %d", record.typeNameFormat);

    NSString *type = [[NSString alloc] initWithData:record.type encoding:NSUTF8StringEncoding];
    NSLog(@"Type: %@", type);

    if ([type isEqualToString:@"T"]) {
        return [NFCReader readText:record.payload];
    }
    if ([type isEqualToString:@"U"]) {
        return [NFCReader readURI:record.payload];
    }

    return nil;
}

+ (NSString *)readText:(NSData *)payload {
    Byte flag;
    [payload getBytes:&flag length:1];

    Byte langMask = 0b00111111;
    NSUInteger langLength = flag & langMask;

    NSUInteger textOffset = 1 + langLength;
    NSRange textRange = NSMakeRange(textOffset, payload.length - textOffset);
    NSUInteger textLength = textRange.length;

    Byte bytes[textLength];
    [payload getBytes:&bytes range:textRange];

    return [[NSString alloc] initWithBytes:bytes length:textLength encoding:NSUTF8StringEncoding];
}

+ (NSString *)readURI:(NSData *)payload {
    Byte prefixCode;
    [payload getBytes:&prefixCode length:1];

    NSString *prefix;
    switch (prefixCode) {
        case 0x01:
            prefix = @"http://www.";
            break;
        case 0x02:
            prefix = @"https://www.";
            break;
        case 0x03:
            prefix = @"http://";
            break;
        case 0x04:
            prefix = @"https://";
            break;
        default:
            prefix = @"";
            break;
    }

    NSUInteger contentOffset = 1;
    NSRange contentRange = NSMakeRange(contentOffset, payload.length - contentOffset);
    NSUInteger contentLength = contentRange.length;

    Byte bytes[contentLength];
    [payload getBytes:&bytes range:contentRange];

    NSString *content = [[NSString alloc] initWithBytes:bytes length:contentLength encoding:NSUTF8StringEncoding];

    return [prefix stringByAppendingString:content];
}

@end
