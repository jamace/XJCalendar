//
//  XJCalendarWeekdayView.m
//  XJCalendar
//
//  Created by 肖吉 on 2017/8/29.
//  Copyright © 2017年 jamace. All rights reserved.
//

#import "XJCalendarWeekdayView.h"
#import "XJCalendarHeader.h"
@implementation XJCalendarWeekdayView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWeekdayView];
    }
    return self;
}

-(void)initWeekdayView
{
    CGFloat weekWidth = (self.frame.size.width-XJCItem_Space)/7.0f;
    CGFloat weekHeight = XJCWeekday_Height;
    NSArray *weekArray = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    for (int i = 0; i<weekArray.count; i++) {
        UILabel *weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(XJCItem_Space/2.0f+weekWidth*i, 0, weekWidth, weekHeight)];
        weekLabel.text = weekArray[i];
        weekLabel.backgroundColor = [UIColor lightGrayColor];
        weekLabel.textAlignment = NSTextAlignmentCenter;
        weekLabel.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:weekLabel];
    }

}
@end
