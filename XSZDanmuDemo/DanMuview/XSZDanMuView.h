//
//  XszDanMuView.h
//  PeopleLife
//
//  Created by aplle on 16/4/26.
//  Copyright © 2016年 aplle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSZDanMuView : UIView

@property(assign,nonatomic) CGFloat marginHeight;//弹幕上下间距
@property(assign,nonatomic) CGFloat danMuFontSize;//字体大小
@property(copy,nonatomic) UIColor *danMuTextColor;//字体颜色
@property(assign,nonatomic) NSUInteger maxRoadCount;//view范围内最大通道数

@property(strong,nonatomic) NSMutableArray *danMuInfos;//弹幕信息

-(void)xsz_addDanMuInfos:(NSMutableArray *)danMuInfos;//添加弹幕信息
@end
