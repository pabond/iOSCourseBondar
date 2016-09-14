//
//  BPVArrayChange+BPVArrayModel.h
//  iOSProject
//
//  Created by Bondar Pavel on 8/16/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#import "BPVArrayModel.h"

#import "BPVArrayChange.h"

@interface BPVArrayChange (BPVArrayModel)

//sholuld be launched from child classes
- (void)applyToModel:(id)model withObject:(id)object;

@end
