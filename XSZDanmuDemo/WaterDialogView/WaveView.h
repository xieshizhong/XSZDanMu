//
//  WaveView.h
//  XSZDanmuDemo
//
//  Created by aplle on 16/5/20.
//  Copyright © 2016年 hestrong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaveView : UIView

@property(nonatomic,strong)CAShapeLayer *oneLayer;
@property(nonatomic,strong)CAShapeLayer *twoLayer;
@property(nonatomic,strong)CADisplayLink *link;
@end
