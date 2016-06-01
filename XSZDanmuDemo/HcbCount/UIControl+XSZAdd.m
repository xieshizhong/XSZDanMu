//
//  UIControl+XSZAdd.m
//  XSZDanmuDemo
//
//  Created by 谢忠 on 16/6/1.
//  Copyright © 2016年 hestrong. All rights reserved.
//

#import "UIControl+XSZAdd.h"
#import "NSObject+XDAdd.h"

@implementation UIControl (XSZAdd)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSelector:@selector(sendAction:to:forEvent:) withSwizzledSelector:@selector(xsz_sendAction:to:forEvent:)];
    });
}

- (void)xsz_sendAction:(nullable SEL)action to:(nullable id)target forEvent:(UIEvent *)event{
    [self xsz_sendAction:action to:target forEvent:event];
    if (!action||!target) return;
    NSDictionary *countConfig=[[NSUserDefaults standardUserDefaults] objectForKey:@"hcb_countConfig"];
    if (!countConfig) return;
    NSArray *classList=countConfig[@"classList"];
    if (!classList) return;
    NSArray *methodList=countConfig[@"methodList"];
    if (!methodList) return;
    NSString *className=NSStringFromClass([target class]);
    NSString *methodName=NSStringFromSelector(action);
    if ([classList containsObject:className]&&[methodList containsObject:methodName]) {
        NSString *description=[NSString stringWithFormat:@"%ld",self.tag];
        if ([description integerValue]==0) {
            if ([self isKindOfClass:[UIButton class]]) {
                description=((UIButton *)self).titleLabel.text;
                
            }
        }
        if (!description) {
            description=@"无描述信息";
        }
        [self uploadActionInfo:className methodName:methodName description:description];
    }
}

- (void)uploadActionInfo:(NSString *)className methodName:(NSString *)methodName description:(NSString *)description{
   //上传或者保存对应数据
    NSLog(@"className=%@/////methodName=%@/////description=%@",className,methodName,description);
}
@end
