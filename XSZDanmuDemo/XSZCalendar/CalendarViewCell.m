//
//  CalendarViewCell.m
//  XSZDanmuDemo
//
//  Created by aplle on 16/4/28.
//  Copyright © 2016年 hestrong. All rights reserved.
//

#import "CalendarViewCell.h"

@implementation CalendarViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView ];
        
    }
    return self;
}

- (void)initView{
    CGFloat width=[UIScreen mainScreen].bounds.size.width/7;
    
    _dateLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 10,width, 16)];
    _dateLab.font=[UIFont systemFontOfSize:15];
    _dateLab.textColor=[UIColor blackColor];
    _dateLab.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_dateLab];
    
    _descriptionLab=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_dateLab.frame)+5,width, 11)];
    _descriptionLab.font=[UIFont systemFontOfSize:10];
    _descriptionLab.textColor=[UIColor redColor];
    _descriptionLab.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_descriptionLab];
}

@end
