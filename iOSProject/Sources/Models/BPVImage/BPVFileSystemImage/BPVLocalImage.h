//
//  BPVLocalImage.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/13/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVImage.h"

@interface BPVLocalImage : BPVImage
@property (nonatomic, readonly) NSURL    *localURL;
@property (nonatomic, readonly) NSString    *path;

- (BOOL)cached;
- (UIImage *)performLoadingWithURL:(NSURL *)url;

@end
