//
//  WaterDialogView.m
//  XSZDanmuDemo
//
//  Created by aplle on 16/5/20.
//  Copyright © 2016年 hestrong. All rights reserved.
//

#import "WaveView.h"

@interface WaveView(){
    CGFloat waveCycle;
    CGFloat offsetX;
    CGFloat waveSpeed;
    UIColor *oneLayerColor;
    UIColor *twoLayerColor;
}

@end

@implementation WaveView

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        self.layer.cornerRadius=self.frame.size.width/2;
        self.layer.borderColor=[UIColor yellowColor].CGColor;
        self.layer.borderWidth=1;
        self.layer.masksToBounds=YES;
        [self initData];
        [self initView];
    }
    return self;
}

- (void)initView{
    [self.layer addSublayer:self.oneLayer];
    [self.layer addSublayer:self.twoLayer];
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)initData{
    waveCycle=1.29 * M_PI / self.frame.size.width;
    waveSpeed=0.4/M_PI;
    oneLayerColor = [UIColor colorWithRed:223/255.0 green:83/255.0 blue:64/255.0 alpha:1];
    twoLayerColor = [UIColor colorWithRed:236/255.0f green:90/255.0f blue:66/255.0f alpha:1];
}

- (void)displaylinkAction{
    offsetX+=waveSpeed;
    [self oneLayerAction];
    [self twoLayerAction];
}

- (void)oneLayerAction{
    CGMutablePathRef path=CGPathCreateMutable();
    CGFloat y=0;
    CGPathMoveToPoint(path, nil, 0, 0);
    for (int x=0; x<self.frame.size.width; x++) {
        y=2*sin(waveCycle*x+offsetX)+self.frame.size.height/2;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathAddLineToPoint(path,nil,  self.bounds.size.width,  self.bounds.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.bounds.size.height);
    CGPathCloseSubpath(path);
    self.oneLayer.path=path;
    CGPathRelease(path);
}

- (void)twoLayerAction{
    CGMutablePathRef path=CGPathCreateMutable();
    CGFloat y=0;
    CGPathMoveToPoint(path, nil, 0, y);
    for (int x=0; x<self.frame.size.width; x++) {
        y=2*cos(waveCycle*x+offsetX)+self.frame.size.height/2;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathAddLineToPoint(path, nil, self.frame.size.width, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.width);
    CGPathCloseSubpath(path);
    self.twoLayer.path=path;
    CGPathRelease(path);
}

- (CAShapeLayer *)oneLayer{
    if (!_oneLayer) {
        _oneLayer=[CAShapeLayer layer];
        _oneLayer.backgroundColor=oneLayerColor.CGColor;
        _oneLayer.fillColor=oneLayerColor.CGColor;
    }
    return _oneLayer;
}

- (CAShapeLayer *)twoLayer{
    if (!_twoLayer) {
        _twoLayer=[CAShapeLayer layer];
        _twoLayer.backgroundColor=twoLayerColor.CGColor;
        _twoLayer.fillColor=twoLayerColor.CGColor;
        _twoLayer.opacity=0.5;
    }
    return _twoLayer;
}

- (CADisplayLink *)link{
    if (!_link) {
        _link=[CADisplayLink displayLinkWithTarget:self selector:@selector(displaylinkAction)];
    }
    return _link;
}
@end
