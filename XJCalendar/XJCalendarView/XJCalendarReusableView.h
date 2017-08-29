//
//  XJCalendarReusableView.h
//  XJCalendar
//
//  Created by 肖吉 on 2017/8/29.
//  Copyright © 2017年 jamace. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    monthCurrent,   //当前月
    monthNext,      //下个月
    monthBack,      //上个月
} monthType;

@protocol XJCalendarReusableViewDelegate <NSObject>

-(void)selectMonthType:(monthType)type;

@end
@interface XJCalendarReusableView : UICollectionReusableView
+(instancetype)XJCalendarCollectionReusableView:(UICollectionView *)collectionView kind:(NSString *)kind indexPath:(NSIndexPath *)indexPath;
@property (nonatomic, copy) NSString *month;
@property (nonatomic, assign) id<XJCalendarReusableViewDelegate>delegate;
@end
