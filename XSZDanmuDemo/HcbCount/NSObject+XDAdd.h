//
//  NSObject+XDAdd.h
//  XSZDanmuDemo
//
//  Created by 谢忠 on 16/6/1.
//  Copyright © 2016年 hestrong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (XDAdd)

+ (void)swizzleSelector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector;
@end
