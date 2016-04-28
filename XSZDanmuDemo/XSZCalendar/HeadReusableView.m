//
//  HeadReusableView.m
//  XSZDanmuDemo
//
//  Created by aplle on 16/4/28.
//  Copyright © 2016年 hestrong. All rights reserved.
//

#import "HeadReusableView.h"

@interface HeadReusableView(){
    NSArray *weeksList;
    CGFloat itemWidth;
}

@end

@implementation HeadReusableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        weeksList=[NSArray arrayWithObjects:@"一",@"二",@"三",@"四",@"五",@"六",@"日", nil];
        itemWidth=[UIScreen mainScreen].bounds.size.width/weeksList.count;
        [self initView];
    }
    return self;
}

- (void)initView{
    _dateLab=[[UILabel alloc] initWithFrame:CGRectMake(0,10, [UIScreen mainScreen].bounds.size.width, 15)];
    _dateLab.font=[UIFont systemFontOfSize:15];
    _dateLab.textColor=[UIColor whiteColor];
    _dateLab.textAlignment=NSTextAlignmentCenter;
    _dateLab.text=@"2016年4月20日";
    [self addSubview:_dateLab];
    [self createWeek];
}

- (void)createWeek{
    for (int i=0; i<weeksList.count; i++) {
        UILabel *weekLab=[[UILabel alloc] initWithFrame:CGRectMake(i*itemWidth, CGRectGetMaxY(_dateLab.frame)+10, itemWidth, 15)];
        weekLab.font=[UIFont systemFontOfSize:15];
        weekLab.textColor=[UIColor whiteColor];
        weekLab.textAlignment=NSTextAlignmentCenter;
        weekLab.text=weeksList[i];
        [self addSubview:weekLab];
    }
}
@end
