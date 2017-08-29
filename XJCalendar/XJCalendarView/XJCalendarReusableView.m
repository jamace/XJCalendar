//
//  XJCalendarReusableView.m
//  XJCalendar
//
//  Created by 肖吉 on 2017/8/29.
//  Copyright © 2017年 jamace. All rights reserved.
//

#import "XJCalendarReusableView.h"
#import "XJCalendarHeader.h"
static NSString * const collectionHeaderIdenter = @"collectionHeaderIdenter";

@interface XJCalendarReusableView()
@property (nonatomic, strong) UILabel *currentMonth;              //月份
@property (nonatomic, strong) UIButton *nextMonth;                //下个月
@property (nonatomic, strong) UIButton *backMonth;                //上个月
@end

@implementation XJCalendarReusableView

+(instancetype)XJCalendarCollectionReusableView:(UICollectionView *)collectionView kind:(NSString *)kind indexPath:(NSIndexPath *)indexPath
{

    XJCalendarReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:collectionHeaderIdenter forIndexPath:indexPath];
    return reusableView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self creatHeaderView];
    }
    return self;
}
-(void)creatHeaderView
{
    _currentMonth = [[UILabel alloc] initWithFrame:CGRectMake(XJCMonthChange_Width, 0, self.frame.size.width-2*XJCMonthChange_Width, self.frame.size.height)];
    _currentMonth.textColor = [UIColor redColor];
    _currentMonth.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_currentMonth];
    
    _backMonth = [UIButton buttonWithType:UIButtonTypeCustom];
    _backMonth.frame = CGRectMake(0, 0, XJCMonthChange_Width, self.frame.size.height);
    [_backMonth setTitle:@"上个月" forState:UIControlStateNormal];
    _backMonth.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [_backMonth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_backMonth addTarget:self action:@selector(backMonthClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backMonth];
    
    _nextMonth = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextMonth.frame = CGRectMake(self.frame.size.width-XJCMonthChange_Width, 0,XJCMonthChange_Width, self.frame.size.height);
    [_nextMonth setTitle:@"下个月" forState:UIControlStateNormal];
    _nextMonth.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [_nextMonth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_nextMonth addTarget:self action:@selector(nextMonthClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_nextMonth];
}

-(void)backMonthClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(selectMonthType:)]) {
        [self.delegate selectMonthType:monthBack];
    }
}

-(void)nextMonthClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(selectMonthType:)]) {
        [self.delegate selectMonthType:monthNext];
    }
}
-(void)setMonth:(NSString *)month
{
    _month = month;
    _currentMonth.text = month;
}
@end
