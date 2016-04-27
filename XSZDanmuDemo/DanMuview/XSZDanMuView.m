//
//  XszDanMuView.m
//
//
//  Created by aplle on 16/4/26.
//  Copyright © 2016年 aplle. All rights reserved.
//

#import "XszDanMuView.h"

@interface XSZDanMuView(){
    NSMutableArray *danMuRoads;
}

@end

@implementation XSZDanMuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.userInteractionEnabled=NO;
    }
    return self;
}

-(void)setDanMuFontSize:(CGFloat)danMuFontSize{
    _danMuFontSize=danMuFontSize;
    _maxRoadCount=(NSUInteger)(self.frame.size.height/(danMuFontSize+2*_marginHeight));
    [self countRoads];
}

-(void)countRoads{
    if (!danMuRoads) danMuRoads=[NSMutableArray array];
    for (int i=0; i<_maxRoadCount; i++) {
        [danMuRoads addObject:[NSString stringWithFormat:@"%f",(_danMuFontSize+2*_marginHeight)*i]];
    }
}

-(void)xsz_addDanMuInfos:(NSMutableArray *)danMuInfos{
    if (!_danMuInfos) _danMuInfos=[NSMutableArray array];
    if (!_danMuTextColor) _danMuTextColor=[UIColor redColor];
    if (!_marginHeight) _marginHeight=5;
    if (!_danMuFontSize) {
        _danMuFontSize=15;
        [self setDanMuFontSize:_danMuFontSize];
    }
    [_danMuInfos addObjectsFromArray:danMuInfos];
    [self countLayerframe];
    
}

- (void)changeDanMuRoads{
    for (NSUInteger i = danMuRoads.count-1; i > 0; i--)
    {
        NSUInteger randomindex=arc4random_uniform((u_int32_t)i+1);
        [danMuRoads exchangeObjectAtIndex:i withObjectAtIndex:randomindex];
    }
}

- (void)countLayerframe{
    while (_danMuInfos.count) {
        NSInteger count=_danMuInfos.count;
        if (_danMuInfos.count>_maxRoadCount)  count=_maxRoadCount;
        for (int i=0; i<count; i++) {
            if (danMuRoads.count==0) [self countRoads];
            [self changeDanMuRoads];
            [self createDanMuLayer:_danMuInfos[0] topY:[danMuRoads[0] floatValue]];
            [_danMuInfos removeObjectAtIndex:0];
            [danMuRoads removeObjectAtIndex:0];
        }
    }
}

- (void)createDanMuLayer:(NSString *)textString topY:(CGFloat )topY{
    if (!textString||[textString isEqualToString:@""]) return;
    CGSize textsize=[self sizeWithFont:[UIFont systemFontOfSize:_danMuFontSize] maxSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, _danMuFontSize) infoStr:textString];
    CATextLayer *textLayer=[CATextLayer layer];
    textLayer.contentsScale = [[UIScreen mainScreen] scale];
    textLayer.foregroundColor=_danMuTextColor.CGColor;
    textLayer.fontSize=_danMuFontSize;
    textLayer.alignmentMode=@"center";
    textLayer.string=textString;
    textLayer.font=(__bridge CFTypeRef _Nullable)([UIFont systemFontOfSize:15]);
    textLayer.frame=CGRectMake([UIScreen mainScreen].bounds.size.width, topY, textsize.width+_marginHeight*2, textsize.height);
    [self.layer addSublayer:textLayer];
    [self layerAnimation:textLayer];
}

- (void)layerAnimation:(CALayer *)textLayer{
    CABasicAnimation *textanimation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    textanimation.duration=[self getRandomfloat:300 to:600];
    textanimation.delegate=self;
    textanimation.beginTime=CACurrentMediaTime() + [self getRandomfloat:0 to:200];
    textanimation.toValue=[NSValue valueWithCGPoint:CGPointMake(-[UIScreen mainScreen].bounds.size.width-textLayer.bounds.size.width, textLayer.bounds.origin.y)];
    NSMutableDictionary *pararms=[[NSMutableDictionary alloc] init];
    [pararms setObject:textLayer forKey:@"layer"];
    [pararms setObject:@(textLayer.frame.origin.y) forKey:@"layertop"];
    [textanimation setValue:pararms forKey:@"animationName"];
    [textLayer addAnimation:textanimation forKey:nil];
}

- (CGFloat)getRandomfloat:(int)from to:(int)to{
    int frandom =  (int)(from + (arc4random() % (to-from + 1)));
    return frandom/100.0;
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag==YES) {
         NSMutableDictionary *pararms=[anim valueForKey:@"animationName"];
        if (![danMuRoads containsObject:pararms[@"layertop"]]) {
            [danMuRoads addObject:pararms[@"layertop"]];
        }
        CALayer *textLayer=(CALayer *)pararms[@"layer"];
        [textLayer removeFromSuperlayer];
    }
}

-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize infoStr:(NSString *)infoStr
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [infoStr boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
