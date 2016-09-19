//
//  BPVFileSystemImage.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/13/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVImage.h"

@interface BPVFileSystemImage : BPVImage

- (BOOL)imageLoaded;
- (UIImage *)imageFromFileSystem;

@end
