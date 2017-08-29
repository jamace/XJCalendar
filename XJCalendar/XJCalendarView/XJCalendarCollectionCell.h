//
//  XJCalendarCollectionCell.h
//  XJCalendar
//
//  Created by 肖吉 on 2017/8/28.
//  Copyright © 2017年 jamace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XJCalendarModel.h"

@interface XJCalendarCollectionCell : UICollectionViewCell
+(instancetype)XJCalendarCollectionCell:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;
@property (nonatomic, strong) XJCalendarModel *model;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end
