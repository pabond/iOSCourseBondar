//
//  BPVImageView.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/15/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVView.h"

#import "BPVModel.h"

@class BPVImage;

@interface BPVImageView : BPVView <BPVModelObserver>
@property (nonatomic, strong)   UIImageView *imageView;
@property (nonatomic, strong)   BPVImage    *image;

@end
