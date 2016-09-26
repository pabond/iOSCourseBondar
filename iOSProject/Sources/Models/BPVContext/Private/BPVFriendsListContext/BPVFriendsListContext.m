//
//  BPVFriendsListContext.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/24/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVFriendsListContext.h"

#import "BPVUser.h"
#import "BPVUsers.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "BPVMacro.h"

@implementation BPVFriendsListContext

- (void)execute {
    NSDictionary *paremters = @{@"fields":@"id,first_name,last_name,picture.type(large)"};
    NSString *path = [self.userID stringByAppendingString:@"/friends"];
    FBSDKGraphRequest *request = nil;
    request = [[FBSDKGraphRequest alloc] initWithGraphPath:path
                                                parameters:paremters
                                                HTTPMethod:@"GET"];
    
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, NSDictionary *result, NSError *error) {
        if (error || !result) {
            NSLog(@"Faild data load with error: %@", error);
            return;
        }

        NSArray *friendsList = result[@"data"];
        NSMutableArray *array = [NSMutableArray array];
        BPVUser *user = nil;
        
        if (friendsList) {
            for (NSDictionary *friend in friendsList) {
                 user = [BPVUser new];
                
                user.name = friend[@"first_name"];
                user.surname = friend[@"last_name"];
                user.ID = friend[@"id"];
                NSDictionary *picture = friend[@"picture"][@"data"];
                user.imageURL = [NSURL URLWithString:picture[@"url"]];
                
                [array addObject:user];
            }
            
            NSLog(@"[LOADING] Array loaded from Internet");
        } else {
            [array addObjectsFromArray:[self.arrayModel cachedArray]];
            NSLog(@"[LOADING] Array will load from file");
        }
        
        BPVWeakify(self)
        [self.arrayModel performBlockWithoutNotification:^{
            BPVStrongifyAndReturnIfNil(self)
            [self.arrayModel addModels:array];
        }];
        
        self.arrayModel.state = BPVModelDidLoad;
    }];
}

@end
