//
//  UITapGestureRecognizer+XSZAdd.m
//  XSZDanmuDemo
//
//  Created by 谢忠 on 16/6/1.
//  Copyright © 2016年 hestrong. All rights reserved.
//

#import "UITapGestureRecognizer+XSZAdd.h"
#import "NSObject+XDAdd.h"
#import <objc/runtime.h>

@implementation UITapGestureRecognizer (XSZAdd)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSelector:@selector(addTarget:action:) withSwizzledSelector:@selector(xsz_addTarget:action:)];
        [self swizzleSelector:@selector(setState:) withSwizzledSelector:@selector(xsz_setState:)];
    });
}

- (void)xsz_addTarget:(id)target action:(SEL)action{
    [self xsz_addTarget:target action:action];
    objc_setAssociatedObject(self, @"className", NSStringFromClass([target class]), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, @"methodName", NSStringFromSelector(action), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)xsz_setState:(UIGestureRecognizerState) state{
    [self xsz_setState:state];
    if (state==UIGestureRecognizerStateEnded) {
        NSDictionary *countConfig=[[NSUserDefaults standardUserDefaults] objectForKey:@"hcb_countConfig"];
        if (!countConfig) return;
        NSArray *classList=countConfig[@"classList"];
        if (!classList) return;
        NSArray *methodList=countConfig[@"methodList"];
        if (!methodList) return;
        NSString *className=objc_getAssociatedObject(self, @"className");
        NSString *methodName=objc_getAssociatedObject(self, @"methodName");
        if ([classList containsObject:className]&&[methodList containsObject:methodName]) {
            [self uploadActionInfo:className methodName:methodName description:@"暂无描述信息"];
        }
    }
}

- (void)uploadActionInfo:(NSString *)className methodName:(NSString *)methodName description:(NSString *)description{
    //上传或者保存对应数据
    NSLog(@"className=%@/////methodName=%@/////description=%@",className,methodName,description);
}
@end
