//
//  CalendarViewController.h
//  XSZDanmuDemo
//
//  Created by aplle on 16/4/28.
//  Copyright © 2016年 hestrong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarViewController : UIViewController

@property(nonatomic,copy) UICollectionView *calendarCollectionview;
@property(nonatomic,copy) NSMutableArray *dateInfos;
@end
