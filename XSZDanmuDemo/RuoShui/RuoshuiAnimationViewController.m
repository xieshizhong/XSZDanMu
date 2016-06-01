//
//  RuoshuiAnimationViewController.m
//  XSZDanmuDemo
//
//  Created by aplle on 16/5/11.
//  Copyright © 2016年 hestrong. All rights reserved.
//

#import "RuoshuiAnimationViewController.h"

@interface RuoshuiAnimationViewController()<UIScrollViewDelegate>{
    UIScrollView *baseScollView;
    UIView *firstView;
    UIView *sencondView;
    UIView *osecondView;
    UIView *thirdView;
    
    UIImageView *CheadImageView;
    UILabel *CnameLab;
    UIButton *CstarBtn;
    CGFloat lastScrollviewy;
}

@end

@implementation RuoshuiAnimationViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor lightGrayColor];
    baseScollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    baseScollView.contentSize=CGSizeMake(ScreenWidth, 200+ScreenHeight);
    baseScollView.directionalLockEnabled = YES;
    baseScollView.delegate=self;
    [self.view addSubview:baseScollView];
    
    firstView=[[UIView alloc] initWithFrame:CGRectMake(20, 20, ScreenWidth-40, 44)];
    firstView.backgroundColor=[UIColor redColor];
    [baseScollView addSubview:firstView];
    
    sencondView=[self createHeadView:1000];
    sencondView.frame=CGRectMake(20, CGRectGetMaxY(firstView.frame)+10, ScreenWidth-40, 144);
    [baseScollView addSubview:sencondView];
    osecondView=[self createHeadView:2000];
    osecondView.frame=CGRectMake(20, 64,ScreenWidth-40, 144);
    osecondView.backgroundColor=[UIColor whiteColor];
    osecondView.hidden=YES;
    [self.view addSubview:osecondView];
    
    thirdView=[[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(sencondView.frame)+10, ScreenWidth-40, 400)];
    thirdView.backgroundColor=[UIColor yellowColor];
    [baseScollView addSubview:thirdView];

}

- (UIView *)createHeadView:(NSInteger) tag{
    UIView *baseView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-40, 144)];
    baseView.backgroundColor=[UIColor whiteColor];
    baseView.tag=tag;
    
    CGFloat headwidth=44;
    UIImageView *headView=[[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(baseView.frame)-44)/2, 10, headwidth, headwidth)];
    headView.backgroundColor=[UIColor blueColor];
    headView.tag=tag+1;
    UILabel *nameLab=[[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth-40-60)/2, CGRectGetMaxY(headView.frame)+10, 60, 20)];
    nameLab.text=@"楼兰晓月";
    nameLab.font=[UIFont systemFontOfSize:15];
    nameLab.textAlignment=NSTextAlignmentCenter;
    nameLab.textColor=[UIColor blackColor];
    nameLab.tag=tag+2;
    
    UIButton *startBtn=[[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(nameLab.frame)+10, CGRectGetWidth(baseView.frame)-20, 40)];
    [startBtn setTitle:@"开始咨询" forState:UIControlStateNormal];
    startBtn.backgroundColor=[UIColor blueColor];
    startBtn.tag=tag+3;
    
    [baseView addSubview:headView];
    [baseView addSubview:nameLab];
    [baseView addSubview:startBtn];
    return baseView;
}

// scrollView 结束拖动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGPoint offset = scrollView.contentOffset;
    if (offset.y>10) {
        CGPoint position=CGPointMake(0, 100);
        [scrollView setContentOffset:position animated:YES];
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    osecondView.frame=CGRectMake(20, 64,ScreenWidth-40, 64);
    CheadImageView.center=CGPointMake(30, CheadImageView.center.y);
    CnameLab.center=CGPointMake(94 , 32);
    CstarBtn.frame=CGRectMake(ScreenWidth-40-10-100, 10, 100, 40);
}


// scrollView 已经滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    if (offset.y>10) {
        osecondView.hidden=NO;
        sencondView.hidden=YES;
        if (offset.y>100) {
            osecondView.frame=CGRectMake(20, 64,ScreenWidth-40, 64);
            CheadImageView.center=CGPointMake(30, CheadImageView.center.y);
            CnameLab.center=CGPointMake(94 , 32);
            CstarBtn.frame=CGRectMake(ScreenWidth-40-10-100, 10, 100, 40);
            return;
        }
        CGFloat movedistance=offset.y-lastScrollviewy;
        [self osencondBseviewAnimation:movedistance];
        [self heaviewAnimation:movedistance];
        [self namelabAnimation:movedistance];
        [self startbtnAnimation:movedistance];
    }else{
        osecondView.frame=CGRectMake(20, 64,ScreenWidth-40, 144);
        CheadImageView.center=CGPointMake((ScreenWidth-40)/2, CheadImageView.center.y);
        CnameLab.center=CGPointMake((ScreenWidth-40)/2 , 74);
        CstarBtn.frame=CGRectMake(10, 94, CGRectGetWidth(osecondView .frame)-20, 40);
        osecondView.hidden=YES;
        sencondView.hidden=NO;
    }
    lastScrollviewy=offset.y;
}

- (void)osencondBseviewAnimation:(CGFloat)movedistance{
    CGFloat cury=osecondView.frame.size.height-movedistance;
    if (cury<64) {
        cury=64;
    }
    if (cury>144) {
        cury=144;
    }
    osecondView.frame=CGRectMake(osecondView.frame.origin.x, osecondView.frame.origin.y, ScreenWidth-40, cury);
}

- (void)heaviewAnimation:(CGFloat)movedistance {
    if (!CheadImageView) {
        CheadImageView=[osecondView viewWithTag:2001];
    }
    CGFloat offsetx=(((ScreenWidth-40)/2-32)*movedistance)/80;
    CGFloat centx=CheadImageView.center.x -offsetx;
    if (centx<30) {
        centx=30;
    }
    if (centx>(ScreenWidth-40)/2) {
        centx=(ScreenWidth-40)/2;
    }
    CheadImageView.center=CGPointMake(centx, CheadImageView.center.y);
}

- (void)namelabAnimation:(CGFloat)movedistance {
    if (!CnameLab) {
        CnameLab=[osecondView viewWithTag:2002];
    }
    CGFloat offsetx=(((ScreenWidth-40)/2-94)*movedistance)/80;
    CGFloat offsety=((74-32)*movedistance)/80;
    CGFloat centx=CnameLab.center.x-offsetx;
    CGFloat centy=CnameLab.center.y-offsety;
    if (centx<94) {
        centx=94;
    }
    if (centx>(ScreenWidth-40)/2) {
        centx=(ScreenWidth-40)/2;
    }
    if (centy<32) {
        centy=32;
    }
    if (centy>74) {
        centy=74;
    }
    CnameLab.center=CGPointMake(centx, centy);
}

- (void)startbtnAnimation:(CGFloat)movedistance {
    
    if (!CstarBtn) {
        CstarBtn=[osecondView viewWithTag:2003];
    }
    CGFloat offsetx=((ScreenWidth-190)*movedistance)/80;
    CGFloat offsety=((94-10)*movedistance)/80;
    CGFloat rectx=CstarBtn.frame.origin.x+offsetx;
    CGFloat recty=CstarBtn.frame.origin.y-offsety;
    CGFloat width=CstarBtn.frame.size.width-offsetx;
    if (rectx<10) {
        rectx=10;
    }
    if (rectx>ScreenWidth-40-10-100) {
        rectx=ScreenWidth-40-10-100;
    }
    if (recty<10) {
        recty=10;
    }
    if (recty>94) {
        recty=94;
    }
    if (width<100) {
        width=100;
    }
    if (width>ScreenWidth-40-20) {
        width=ScreenWidth-40-20;
    }
    CstarBtn.frame=CGRectMake(rectx, recty, width, 40);
}

@end
