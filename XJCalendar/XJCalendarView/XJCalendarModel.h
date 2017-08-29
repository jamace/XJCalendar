//
//  XJCalendarModel.h
//  XJCalendar
//
//  Created by 肖吉 on 2017/8/28.
//  Copyright © 2017年 jamace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XJCalendarModel : NSObject
@property (nonatomic,copy) NSString *day;
@property (nonatomic,assign) BOOL currentBefore;
@property (nonatomic,assign) BOOL isCurrentDay;
@end
