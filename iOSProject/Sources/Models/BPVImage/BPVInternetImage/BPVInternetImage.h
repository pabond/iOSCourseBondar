//
//  BPVInternetImage.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/12/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVLocalImage.h"

typedef void(^BPVCompletionHandler)(NSURL *location, NSURLResponse *response, NSError *error);


@interface BPVInternetImage : BPVLocalImage

// setting task calls "resume" method
// these methods can be rewritten in subclasses
- (void)loadFromInternet;
- (NSURLSession *)session;
- (BPVCompletionHandler)downloadTaskCompletionHandler;

@end
