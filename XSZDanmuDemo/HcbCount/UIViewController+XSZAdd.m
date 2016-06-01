//
//  UIViewController+XSZAdd.m
//  XSZDanmuDemo
//
//  Created by 谢忠 on 16/6/1.
//  Copyright © 2016年 hestrong. All rights reserved.
//

#import "UIViewController+XSZAdd.h"
#import "NSObject+XDAdd.h"
#import <objc/runtime.h>

@implementation UIViewController (XSZAdd)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSelector:@selector(viewWillAppear:) withSwizzledSelector:@selector(xsz_viewWillAppear:)];
        [self swizzleSelector:@selector(viewWillDisappear:) withSwizzledSelector:@selector(xsz_viewWillDisappear:)];
    });
}

- (void)xsz_viewWillAppear:(BOOL)animated{
    [self xsz_viewWillAppear:animated];
    objc_setAssociatedObject(self, @"enterTime", [NSDate date], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)xsz_viewWillDisappear:(BOOL)animated{
    [self xsz_viewWillDisappear:animated];
    NSDate *enterTime=objc_getAssociatedObject(self, @"enterTime");
    NSDate *leftTime=[NSDate date];
    NSTimeInterval liveTime=[leftTime timeIntervalSinceDate:enterTime];
    [self uploadActionInfo:liveTime];
}

- (void)uploadActionInfo:(NSTimeInterval)liveTime{
    NSLog(@"className=%@/////liveTime=%f",NSStringFromClass([self class]),liveTime);
}
@end
