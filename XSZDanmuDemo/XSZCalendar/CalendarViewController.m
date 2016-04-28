//
//  CalendarViewController.m
//  XSZDanmuDemo
//
//  Created by aplle on 16/4/28.
//  Copyright © 2016年 hestrong. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarViewCell.h"
#import "HeadReusableView.h"
#import "NSDate+YYAdd.h"
#import "Utils.h"
//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
static NSString *const cellId = @"cellId";
static NSString *const headerId = @"headerId";
static NSString *const footerId = @"footerId";

@interface CalendarViewController()<UICollectionViewDelegate,UICollectionViewDataSource>{
    
}

@end

@implementation CalendarViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    _dateInfos=[NSMutableArray array];
    [self createDateinfos];
    [self.view addSubview:self.calendarCollectionview];
}

- (void)createDateinfos{
    NSInteger curMonth=[NSDate date].month;
    for (int i=(int)curMonth; i<=(int)curMonth+12; i++) {
        NSMutableDictionary *pararms=[[NSMutableDictionary alloc] init];
        NSInteger year=[NSDate date].year;
        NSInteger month=i;
        if (month>12) {
            year++;
            month-=12;
        }
        [pararms setObject:[NSString stringWithFormat:@"%ld年%ld月",(long)year,(long)month] forKey:@"month"];
        NSMutableArray *dayArray=[[NSMutableArray alloc] init];
        NSInteger curdays=[Utils howManyDaysInThisMonth:[NSDate date].year month:i];
        NSDate *oneMonthDate=[NSDate date];
        NSDate *oneMonthFirstDay=[Utils getFirstDayBaseDate:oneMonthDate];
        NSInteger oneMonthWhicWeek;
        if (i!=(int)curMonth) {
            oneMonthDate=[oneMonthFirstDay dateByAddingMonths:i-curMonth];
            oneMonthFirstDay=[Utils getFirstDayBaseDate:oneMonthDate];
        }
        oneMonthWhicWeek=oneMonthFirstDay.weekday-1;
        if (oneMonthWhicWeek==0) {
            oneMonthWhicWeek=7;
        }
        for (int j=1; j<=curdays; j++) {
            NSMutableDictionary *infoPararms=[[NSMutableDictionary alloc] init];
            [infoPararms setObject:[NSString stringWithFormat:@"%d",j] forKey:@"day"];
            [infoPararms setObject:@"0" forKey:@"Selected"];
            [dayArray addObject:infoPararms];
        }
        if (oneMonthWhicWeek>1) {
            for (int k=0; k<oneMonthWhicWeek-1; k++) {
                [dayArray insertObject:@"" atIndex:0];
            }
        }
        [pararms setObject:dayArray forKey:@"dayinfo"];
        [_dateInfos addObject:pararms];
    }
}

- (UICollectionView *)calendarCollectionview{
    if (!_calendarCollectionview) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing=0;
        flowLayout.minimumInteritemSpacing=0;
        flowLayout.itemSize=CGSizeMake((ScreenWidth)/7, (ScreenWidth)/7);
        flowLayout.headerReferenceSize=CGSizeMake(ScreenWidth, 60);
        flowLayout.footerReferenceSize=CGSizeMake(ScreenWidth, 0.01);
        flowLayout.sectionHeadersPinToVisibleBounds=YES;
        _calendarCollectionview=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:flowLayout];
        [_calendarCollectionview registerClass:[CalendarViewCell class] forCellWithReuseIdentifier:cellId];
        [_calendarCollectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
        [_calendarCollectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
        _calendarCollectionview.backgroundColor=[UIColor clearColor];
        _calendarCollectionview.delegate=self;
        _calendarCollectionview.dataSource=self;
        
    }
    return _calendarCollectionview;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _dateInfos.count;
}


//每个section的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSMutableDictionary *dateinfo=_dateInfos[section];
    NSMutableArray *datearray=dateinfo[@"dayinfo"];
    return datearray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CalendarViewCell *calendarViewCell = (CalendarViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    NSMutableDictionary *dateinfo=_dateInfos[indexPath.section];
    NSMutableArray *datearray=dateinfo[@"dayinfo"];
    if ([datearray[indexPath.row] isKindOfClass:[NSMutableDictionary class]]) {
        NSMutableDictionary *dayPararms=datearray[indexPath.row];
        calendarViewCell.dateLab.text=dayPararms[@"day"];
        if ([dayPararms[@"Selected"] integerValue]==0) {
            calendarViewCell.selectedView.hidden=YES;
        }else{
            calendarViewCell.selectedView.hidden=NO;
        }
    }else{
        calendarViewCell.dateLab.text=datearray[indexPath.row];
        calendarViewCell.selectedView.hidden=YES;
    }
    return calendarViewCell;
}

// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary *dateinfo=_dateInfos[indexPath.section];
    NSString *month=dateinfo[@"month"];
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *headerView = [_calendarCollectionview dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
        if(headerView == nil)
        {
            headerView = [[UICollectionReusableView alloc] init];
        }
        headerView.backgroundColor = [UIColor grayColor];
        HeadReusableView *head=[headerView viewWithTag:1000];
        if (!head) {
            head=[[HeadReusableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
            [head setTag:1000];
            [headerView addSubview:head];
        }
        head.dateLab.text=month;
        return headerView;
    }
    else if([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        UICollectionReusableView *footerView = [_calendarCollectionview dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerId forIndexPath:indexPath];
        if(footerView == nil)
        {
            footerView = [[UICollectionReusableView alloc] init];
        }
        footerView.backgroundColor = [UIColor lightGrayColor];
        
        return footerView;
    }
    
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *dateinfo=_dateInfos[indexPath.section];
    NSMutableArray *datearray=dateinfo[@"dayinfo"];
    NSMutableDictionary *dayPararms=datearray[indexPath.row];
    if ([dayPararms isKindOfClass:[NSMutableDictionary class]]) {
        if ([dayPararms[@"Selected"] integerValue]==0) {
            [dayPararms setObject:@"1" forKey:@"Selected"];
        }else{
            [dayPararms setObject:@"0" forKey:@"Selected"];
        }
        [self.calendarCollectionview reloadData];
    }
}

@end
