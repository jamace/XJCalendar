//
//  ViewController.m
//  XJCalendar
//
//  Created by 肖吉 on 2017/8/28.
//  Copyright © 2017年 jamace. All rights reserved.
//

#import "ViewController.h"
#import "XJCalendarView.h"
#import "XJCalendarHeader.h"
@interface ViewController ()<XJCalendarViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    XJCalendarView *calendar = [[XJCalendarView alloc]initWithFrame:CGRectMake(0, 100, XJCScreen_Width, XJCScreen_Width)];
    [self.view addSubview:calendar];
}
    
@end
