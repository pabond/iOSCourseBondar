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