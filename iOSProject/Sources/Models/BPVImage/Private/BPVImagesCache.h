//
//  BPVImagesCache.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/9/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UIKit/UIKit.h"

@interface BPVImagesCache : NSObject

+ (instancetype)cache;

- (void)addImage:(UIImage *)image withURL:(NSURL *)url;
- (void)removeImageWithURL:(NSURL *)url;
- (BOOL)containsImageWithURL:(NSURL *)url;
- (BOOL)containsImage:(UIImage *)image;
- (UIImage *)imageWithURL:(NSURL *)url;

@end
