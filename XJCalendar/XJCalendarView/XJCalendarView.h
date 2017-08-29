//
//  XJCalendarView.h
//  XJCalendar
//
//  Created by 肖吉 on 2017/8/28.
//  Copyright © 2017年 jamace. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XJCalendarViewDelegate <NSObject>

-(void)selectIndex;

@end
@interface XJCalendarView : UIView
@property (nonatomic, assign) id<XJCalendarViewDelegate>delegate;
@end
