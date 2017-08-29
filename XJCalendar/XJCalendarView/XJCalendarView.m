//
//  XJCalendarView.m
//  XJCalendar
//
//  Created by 肖吉 on 2017/8/28.
//  Copyright © 2017年 jamace. All rights reserved.
//

#import "XJCalendarView.h"
#import "NSObject+XJCalendarTool.h"
#import "XJCalendarCollectionView.h"
#import "XJCalendarCollectionCell.h"
#import "XJCalendarWeekdayView.h"
#import "XJCalendarHeader.h"
#import "XJCalendarReusableView.h"



@interface XJCalendarView()<UICollectionViewDelegate,UICollectionViewDataSource,XJCalendarReusableViewDelegate>
@property (nonatomic, strong)NSCalendar                 * calendar;              //创建日历
@property (nonatomic, strong)NSDate                     * amountOf1_Date;        //当前的日期
@property (nonatomic, assign)NSInteger                  dayNum;                //表示周里面的天 1代表周日 2代表周一 7代表周六
@property (nonatomic, assign)NSInteger                  selectedIndex;         //当前日期选中的下标
@property (nonatomic, strong)XJCalendarCollectionView   *collectionView;
@property (nonatomic, strong)NSMutableArray             *dataArray;
@property (nonatomic, strong)NSMutableArray             *headerViewDataArray;   //组头数据源
@property (nonatomic, assign)NSInteger                  currentMonth;           //0是当前，往后是下月，往前是上月
@end

@implementation XJCalendarView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _currentMonth = 0;
        self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];//指定日历的算法
        [self addSubview:self.collectionView];
        [self creatWeekdayView];
        [self loadCalendarData];
    }
    return self;
}

//周日-周六
-(void)creatWeekdayView
{
    XJCalendarWeekdayView *weekdayView = [[XJCalendarWeekdayView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, XJCWeekday_Height)];
    [self addSubview:weekdayView];
}
//日历数据
-(void)loadCalendarData
{
    /*******/
    /*
     *  getFirstDayWeekForMonth ->获取目标月份1号是周几
     *  [self getAMonthframDate:currentDate months:0] ->根据当前日期返回目标月1号的date对象(用来计算1号周几)
     *******/
    self.amountOf1_Date =  [self getAMonthframDate:[NSDate date] months:_currentMonth calendar:self.calendar];
    self.dayNum = [self getFirstDayWeekForMonth:self.amountOf1_Date calendar:self.calendar];
    self.selectedIndex =  [self getTheDateInCalendarTodaySubscript];
    //当前月的天数+空白星期数
    NSInteger itemCount = [self getNextNMonthForDays:self.amountOf1_Date] + self.dayNum;
 
    //移除老数据
    [self.dataArray removeAllObjects];
    [self.headerViewDataArray removeAllObjects];
    
    NSLog(@"%ld",self.selectedIndex);
    //处理数据源
    for (NSInteger i = 0; i< itemCount; i++) {
        XJCalendarModel *model = [[XJCalendarModel alloc] init];
        if (i<self.dayNum) {
            model.day = @"";
        }else{
            // 方法定义如果是星期天返回0(为了日历布局) 所以这里处理一下
            if (self.dayNum == 0){
                model.day = [NSString stringWithFormat:@"%ld",(i + 1)];
            } else {
                model.day = [NSString stringWithFormat:@"%ld",(i + 1 - self.dayNum)];
                
            }
            if (([model.day integerValue] == self.selectedIndex-1) && _currentMonth == 0) {
                model.isCurrentDay = YES;
            }else{
                model.isCurrentDay = NO;
            }
            if ( _currentMonth == 0) {
                if (i<self.selectedIndex) {
                    model.currentBefore = YES;
                }else{
                    model.currentBefore = NO;
                }
            }
        }
        [self.dataArray addObject:model];
    }
    
    [self.collectionView reloadData];
}

#pragma mark - 返回今天日期在日历UI中的位置下标
-(NSInteger)getTheDateInCalendarTodaySubscript{
    NSCalendarUnit dayInfoUnits  = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components = [self.calendar components:dayInfoUnits fromDate:[NSDate date]];
    // 为了对应星期数，前边加了站位cell。所以这里真正下标应该加上星期数(-1不用说了下标从0开始)
    return components.day-1+ self.dayNum;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // 装collectionView头视图需要的数据
    [self.headerViewDataArray addObject:self.amountOf1_Date];
    // 目标月的天数+星期数（这天星期几就加几）---目的->布局cell时候能够让每个月1号对应上星期数
    return [self getNextNMonthForDays:self.amountOf1_Date]  + self.dayNum;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XJCalendarCollectionCell *item = [XJCalendarCollectionCell XJCalendarCollectionCell:collectionView indexPath:indexPath];
    item.model = self.dataArray[indexPath.item];
    item.indexPath = indexPath;
    return item;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    if (kind == UICollectionElementKindSectionHeader) {
        XJCalendarReusableView *headerView = [XJCalendarReusableView XJCalendarCollectionReusableView:collectionView kind:kind indexPath:indexPath];
        headerView.delegate = self;
        headerView.month = [self theTargetDateConversionStr:_headerViewDataArray[indexPath.section]];
        return headerView;
    } else {
        return nil;
    }
}
-(void)selectMonthType:(monthType)type
{
    if (type == monthBack) {
        _currentMonth --;
    }else if (type == monthNext){
        _currentMonth++;
    }else if (type == monthCurrent){
        _currentMonth = 0;
    }
    [self loadCalendarData];
}
-(XJCalendarCollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[XJCalendarCollectionView alloc] initWithFrame:CGRectMake(0, XJCWeekday_Height, self.frame.size.width, self.frame.size.height - XJCWeekday_Height)];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}
-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
-(NSMutableArray *)headerViewDataArray{
    if (!_headerViewDataArray) {
        _headerViewDataArray = [NSMutableArray array];
    }
    return _headerViewDataArray;
}
@end
