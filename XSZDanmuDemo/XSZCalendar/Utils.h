//
//  Utils.h
//  XSZDanmuDemo
//
//  Created by aplle on 16/4/28.
//  Copyright © 2016年 hestrong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (NSInteger)howManyDaysInThisMonth:(NSInteger)year month:(NSInteger)imonth;
+ (NSDate *)getFirstDayBaseDate:(NSDate *) date;
@end
