//
//  BPVFacebookContext.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/26/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVContext.h"

#import "BPVMacro.h"

BPVStringConstantWithValue(kBPVGetMethod, GET);

//perameters

BPVStringConstantWithValue(kBPVName, first_name);
BPVStringConstantWithValue(kBPVSurname, last_name);
BPVStringConstantWithValue(kBPVLargePicture, picture.type(large));
BPVStringConstantWithValue(kBPVEmail, email);
BPVStringConstantWithValue(kBPVBirthday, birthday);
BPVStringConstantWithValue(kBPVPicture, picture);
BPVStringConstantWithValue(kBPVData, data);
BPVStringConstantWithValue(kBPVUrl, url);
BPVStringConstantWithValue(kBPVFriends, /friends);
BPVStringConstantWithValue(kBPVFields, @"fields");
static NSString * const kBPVId = @"id";

@interface BPVFacebookContext : BPVContext

@end
