//
//  BPVFacebookContext.h
//  iOSProject
//
//  Created by Bondar Pavel on 9/26/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVContext.h"

#import "BPVMacro.h"

@class BPVUser;

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
BPVStringConstantWithValue(kBPVFriends, friends);
BPVStringConstantWithValue(kBPVFields, fields);
static NSString * const kBPVId = @"id";

@interface BPVFacebookContext : BPVContext
@property (nonatomic, strong)   BPVUser         *user;
@property (nonatomic, readonly) BPVUser         *defaultModel;
@property (nonatomic, readonly) NSString        *applicationModelsPath;
@property (nonatomic, readonly) NSString        *filePath;
@property (nonatomic, readonly) BOOL            isCached;

//this getters should be implemented in subclasses
@property (nonatomic, readonly) NSString        *fileName;
@property (nonatomic, readonly) NSString        *path;
@property (nonatomic, readonly) NSDictionary    *paremeters;

- (void)saveObject:(id)object;

//this method should be implemented in subclasses
- (void)fillModelWithInfo:(NSDictionary *)info;
- (void)fillModelWithCachedModel:(id)model;

// youShould never call this method directly, only from subclasses
- (id)cachedModel;

//this method can be implemented in subclasses if needed
- (id)modelToLoad;
- (NSUInteger)willLoadState;
- (NSUInteger)didLoadState;
- (NSUInteger)failLoadingState;
- (BOOL)shouldNotifyOfState:(NSUInteger)state;
- (NSString *)HTTPMethod;
- (void)fillUser:(BPVUser *)user withUserInfo:(NSDictionary *)userInfo;

- (void)fillUser:(BPVUser *)user withUser:(BPVUser *)cachedUser;

@end
