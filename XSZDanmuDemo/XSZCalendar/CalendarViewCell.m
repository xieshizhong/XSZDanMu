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
    
    _selectedView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,width*2/3, width*2/3)];
    _selectedView.image=[UIImage imageNamed:@"selected"];
    [self addSubview:_selectedView];
    
    _dateLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 0,width, width)];
    _dateLab.font=[UIFont systemFontOfSize:15];
    _dateLab.textColor=[UIColor blackColor];
    _dateLab.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_dateLab];
    _selectedView.center=_dateLab.center;
}

@end
