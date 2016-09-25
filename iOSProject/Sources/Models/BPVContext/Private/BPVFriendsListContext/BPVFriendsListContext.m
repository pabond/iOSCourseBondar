//
//  BPVFriendsListContext.m
//  iOSProject
//
//  Created by Bondar Pavel on 9/24/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVFriendsListContext.h"

#import "BPVUser.h"
#import "BPVArrayModel.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "BPVMacro.h"

@implementation BPVFriendsListContext

- (void)execute {
    NSDictionary *paremters = @{@"fields":@"id,first_name,last_name,picture"};
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
        BPVUser *user = [BPVUser new];
        
        for (NSDictionary *friend in friendsList) {
            user.name = friend[@"first_name"];
            user.surname = friend[@"last_name"];
            user.ID = friend[@"id"];
            NSDictionary *picture = friend[@"picture"][@"data"];
            user.imageURL = [NSURL URLWithString:picture[@"url"]];
            
            [array addObject:user];
        }
        
        BPVWeakify(self)
        [self performBlockWithoutNotification:^{
            BPVStrongifyAndReturnIfNil(self)
            [self.arrayModel addModels:array];
        }];
        
        self.state = BPVModelDidLoad;
    }];
}

@end
