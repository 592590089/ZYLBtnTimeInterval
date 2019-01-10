//
//  UIControl+ZYLBtnTimeInterval.m
//  ZYLBtnTimeInterval
//
//  Created by gxd on 2019/1/10.
//  Copyright © 2019年 zyl. All rights reserved.
//

#import "UIControl+ZYLBtnTimeInterval.h"
#import <objc/runtime.h>

static char * const qi_eventIntervalKey = "qi_eventIntervalKey";
static char * const eventUnavailableKey = "eventUnavailableKey";

@interface UIControl ()
@property (nonatomic, assign) BOOL eventUnavailable;
@end

@implementation UIControl (ZYLBtnTimeInterval)

+ (void)load {
    
    Method method = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method qi_method = class_getInstanceMethod(self, @selector(qi_sendAction:to:forEvent:));
    method_exchangeImplementations(method, qi_method);
}


#pragma mark - Action functions

- (void)qi_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    if (self.eventUnavailable == NO) {
        self.eventUnavailable = YES;
        [self qi_sendAction:action to:target forEvent:event];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, self.qi_eventInterval * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
            
            [self setEventUnavailable:NO];
            
        });
    }
}


#pragma mark - Setter & Getter functions

- (NSTimeInterval)qi_eventInterval {
    
    return [objc_getAssociatedObject(self, qi_eventIntervalKey) doubleValue];
}

- (void)setQi_eventInterval:(NSTimeInterval)qi_eventInterval {
    
    objc_setAssociatedObject(self, qi_eventIntervalKey, @(qi_eventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)eventUnavailable {
    
    return [objc_getAssociatedObject(self, eventUnavailableKey) boolValue];
}

- (void)setEventUnavailable:(BOOL)eventUnavailable {
    
    objc_setAssociatedObject(self, eventUnavailableKey, @(eventUnavailable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
