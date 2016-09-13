//
//  BPVArrayChange+BPVFilteredModel.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/16/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVFilteredModel.h"

#import "BPVArrayChange.h"

@interface BPVArrayChange (BPVFilteredModel)

//sholuld be launched from child classes
- (void)applyToModel:(id)model withObject:(id)object;

@end
