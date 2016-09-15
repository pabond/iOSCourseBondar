//
//  NSData+NSKeyedArchiver.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/23/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (NSKeyedArchiver)

+ (NSData *)archivateObject:(id)object;

@end
