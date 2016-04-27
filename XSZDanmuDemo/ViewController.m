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
    [startBtn setTitle:@"开始吧" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startAction) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:startBtn];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
