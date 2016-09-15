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
@property (nonatomic, strong)   UIImage     *image;
@property (nonatomic, strong)   NSURL       *url;
@property (nonatomic, readonly) NSString    *path;
@property (nonatomic, readonly) NSString    *fileName;

+ (instancetype)imageWithUrl:(NSURL *)url;

- (instancetype)initWithUrl:(NSURL *)url;

// you should call this method anly from subclasses
- (UIImage *)specificLoadingOperation;
- (BOOL)imageExistInFileSystem;
- (BOOL)removeImageWithProblem;

- (void)saveDataToFileSystem:(NSData *)data;

@end
