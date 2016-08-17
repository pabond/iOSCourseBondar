//
//  BPVMacro.h
//  iOSProject
//
//  Created by Bondar Pavel on 7/21/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

#define BPVDefineBaseViewProrety(propertyName, viewClass) \
    @property (nonatomic, readonly) viewClass *propertyName;

#define BPVBaseViewGetterSyntesize(selector, viewClass) \
    - (viewClass *)selector { \
        if ([self isViewLoaded] && [self.view isKindOfClass:[viewClass class]]) { \
            return (viewClass *)self.view; \
        } \
        \
        return nil; \
    }

#define BPVViewControllerBaseViewPropertyWithGetter(viewControllerClass, propertyName, baseViewClass) \
    @interface viewControllerClass (__BPVPrivatBaseView) \
    BPVDefineBaseViewProrety(propertyName, baseViewClass)\
    \
    @end \
    \
    @implementation viewControllerClass (__BPVPrivatBaseView) \
    \
    @dynamic propertyName; \
    \
    BPVBaseViewGetterSyntesize(propertyName, baseViewClass)\
    \
    @end


#define BPVPerformBlock(block) \
    if (block) { \
        block(); \
    }


#define BPVTableViewUpdates(updatesBlock, tableView) \
    [tableView beginUpdates]; \
    updatesBlock(); \
    [tableView endUpdates];


#define BPVWeakify(variable) \
    __weak __typeof(variable) __BPVWeakified_##variable = variable;

//should be called only after BPVWeakify call
#define BPVStrongify(variable) \
    __strong __typeof(variable) variable = __BPVWeakified_##variable;


#define BPVEmptyResult

#define BPVStrongifyIfNilReturn(variable) \
    BPVStrongifyIfNilReturnResult(variable, BPVEmptyResult)

#define BPVStrongifyIfNilReturnNil(variable) \
    BPVStrongifyIfNilReturnResult(variable, nil)

#define BPVStrongifyIfNilReturnResult(variable, result) \
    BPVStrongify(variable); \
    if (!variable) { \
        return result; \
    }
