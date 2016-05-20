//
//  ViewController.m
//  XSZDanmuDemo
//
//  Created by aplle on 16/4/27.
//  Copyright © 2016年 hestrong. All rights reserved.
//

#import "ViewController.h"
#import "XSZDanMuView.h"
#import "AppDelegate.h"
#import "CalendarViewController.h"
#import "RuoshuiAnimationViewController.h"
#import "WaveView.h"

@interface ViewController (){
    XSZDanMuView *danMuview;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *startBtn=[[UIButton alloc] init];
    startBtn.center=self.view.center;
    startBtn.backgroundColor=[UIColor redColor];
    startBtn.bounds=CGRectMake(0, 0, 100, 60);
    [startBtn setTitle:@"弹幕" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:startBtn];
    
    UIButton *canlendarBtn=[[UIButton alloc] initWithFrame:CGRectMake(startBtn.frame.origin.x, startBtn.frame.origin.y+70, 100, 60)];
    canlendarBtn.backgroundColor=[UIColor redColor];
    [canlendarBtn setTitle:@"日历" forState:UIControlStateNormal];
    [canlendarBtn addTarget:self action:@selector(canlendarAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:canlendarBtn];
    
    UIButton *animationBtn=[[UIButton alloc] initWithFrame:CGRectMake(startBtn.frame.origin.x, canlendarBtn.frame.origin.y+70, 100, 60)];
    animationBtn.backgroundColor=[UIColor redColor];
    [animationBtn setTitle:@"交互" forState:UIControlStateNormal];
    [animationBtn addTarget:self action:@selector(animationBtnAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:animationBtn];
    
    UIButton *waveBtn=[[UIButton alloc] initWithFrame:CGRectMake(startBtn.frame.origin.x, animationBtn.frame.origin.y+70, 100, 60)];
    waveBtn.backgroundColor=[UIColor redColor];
    [waveBtn setTitle:@"波纹" forState:UIControlStateNormal];
    [waveBtn addTarget:self action:@selector(waveBtnAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:waveBtn];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)startAction{
    if (!danMuview) {
        danMuview=[[XSZDanMuView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        AppDelegate *appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
        [appdelegate.window addSubview:danMuview];
        //            danMuview.danMuFontSize=30;
        //            danMuview.danMuTextColor=[UIColor blueColor];
        //            danMuview.marginHeight=5;
    }
    [danMuview xsz_addDanMuInfos:[NSMutableArray arrayWithObjects:@"我是弹幕啊。。",@"我是弹幕啊。。",@"我是弹幕啊。。",@"我是弹幕啊。。",@"我是弹幕啊。。", @"我是弹幕啊。。",@"我是弹幕啊。。",@"我是弹幕啊。。",nil]];
}

- (void)canlendarAction{
    CalendarViewController *canlendarCon=[[CalendarViewController alloc] init];
    [self.navigationController pushViewController:canlendarCon animated:YES];
}

- (void)animationBtnAction{
    RuoshuiAnimationViewController *animationCon=[[RuoshuiAnimationViewController alloc] init];
    [self.navigationController pushViewController:animationCon animated:YES];
}

- (void)waveBtnAction{
    WaveView *wave=[[WaveView alloc] initWithFrame:CGRectMake(100, 200, 40, 40)];
    [self.view addSubview:wave];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
