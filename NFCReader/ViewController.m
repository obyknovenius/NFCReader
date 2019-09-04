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

@interface ViewController () <NFCNDEFReaderSessionDelegate>

@property (nonatomic, strong) NFCNDEFReaderSession *session;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)read:(id)sender {
    [self.label setText:@""];

    self.session = [[NFCNDEFReaderSession alloc] initWithDelegate:self queue:nil invalidateAfterFirstRead:YES];
    [self.session setAlertMessage:@"Hello World"];
    [self.session beginSession];
}

- (void)readerSession:(NFCNDEFReaderSession *)session didDetectNDEFs:(NSArray<NFCNDEFMessage *> *)messages {
    NFCNDEFMessage *message = messages[0];

    NSString *text = [NFCReader readMessage:message];
    if (text != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.label setText:text];
        });
    }
}

- (void)readerSession:(NFCNDEFReaderSession *)session didInvalidateWithError:(NSError *)error {
    NSLog(@"Error %@", error);
}

@end
