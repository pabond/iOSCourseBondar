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
@property (nonatomic, strong)   UIImage *image;
@property (nonatomic, strong)   NSURL   *url;

+ (instancetype)imageWithUrl:(NSURL *)url;

- (void)finishLoadingImage:(UIImage *)image;

@end
