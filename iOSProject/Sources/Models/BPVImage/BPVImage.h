//
//  BPVImage.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/11/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVObservableObject.h"

#import "UIKit/UIKit.h"

typedef enum {
    BPVImageUnloaded,
    BPVImageLoading,
    BPVImageLoaded,
    BPVImageLoadingFailed
} BPVImageState;

@protocol BPVImageStateObservation <NSObject>

- (void)imageUnloaded:(UIImage *)image;

@end

@interface BPVImage : BPVObservableObject
@property (nonatomic, readonly) UIImage *image;
@property (nonatomic, readonly) NSURL   *url;

@property (nonatomic, readonly, getter=isLoaded) BOOL loaded;

+ (instancetype)imageFromUrl:(NSURL *)url;

- (void)load;
- (void)dump;

NSCoding

@end
