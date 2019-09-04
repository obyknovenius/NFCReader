//
//  ViewController.m
//  NFCReader
//
//  Created by Vitaly Dyachkov on 8/26/19.
//  Copyright © 2019 Vitaly Dyachkov. All rights reserved.
//

#import <CoreNFC/CoreNFC.h>

#import "ViewController.h"

#import "NFCReader.h"
#import "DownloadManager.h"

@interface ViewController () <NFCNDEFReaderSessionDelegate>

@property (nonatomic, strong) NFCNDEFReaderSession *session;

@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)scan:(id)sender {
    [self.imageView setImage:nil];

    self.session = [[NFCNDEFReaderSession alloc] initWithDelegate:self queue:nil invalidateAfterFirstRead:YES];
    [self.session beginSession];
}

- (void)readerSession:(NFCNDEFReaderSession *)session didDetectNDEFs:(NSArray<NFCNDEFMessage *> *)messages {
    NFCNDEFMessage *message = messages[0];

    NSURL *url = [NFCReader readURL:message];
    if (url != nil) {
        [DownloadManager downloadImage:url completionHandler:^(UIImage * _Nonnull image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setImage:image];
            });
        }];
    }
}

- (void)readerSession:(NFCNDEFReaderSession *)session didInvalidateWithError:(NSError *)error {
    NSLog(@"Error %@", error);
}

- (void)setImage:(UIImage *)image {
    [self.imageView setImage:image];
}

@end
