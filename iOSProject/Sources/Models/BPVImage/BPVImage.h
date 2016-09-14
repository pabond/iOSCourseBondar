//
//  BPVImage.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/11/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVModel.h"

#import "UIKit/UIKit.h"

@interface BPVImage : BPVModel
@property (nonatomic, readonly) UIImage     *image;
@property (nonatomic, readonly) NSURL       *url;
@property (nonatomic, readonly) NSString    *path;
@property (nonatomic, readonly) NSString    *fileName;

+ (instancetype)imageWithUrl:(NSURL *)url;

@end
