//
//  Utils.m
//  XSZDanmuDemo
//
//  Created by aplle on 16/4/28.
//  Copyright © 2016年 hestrong. All rights reserved.
//

#import "Utils.h"
#import "NSDate+YYAdd.h"

@implementation Utils


+(NSInteger)howManyDaysInThisMonth:(NSInteger)year month:(NSInteger)imonth {
    if((imonth == 1)||(imonth == 3)||(imonth == 5)||(imonth == 7)||(imonth == 8)||(imonth == 10)||(imonth == 12))
        return 31;
    if((imonth == 4)||(imonth == 6)||(imonth == 9)||(imonth == 11))
        return 30;
    if((year%4 == 1)||(year%4 == 2)||(year%4 == 3))
    {
        return 28;
    }
    if(year%400 == 0)
        return 29;
    if(year%100 == 0)
        return 28;
    return 29;
}

+ (NSDate *)getFirstDayBaseDate:(NSDate *) date{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps = [cal
                               components:NSCalendarUnitYear | NSCalendarUnitMonth
                               fromDate:date];
    comps.day = 1;
    NSDate *firstDay = [cal dateFromComponents:comps];
    return firstDay;
}
@end
