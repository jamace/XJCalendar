//
//  XJCalendarCollectionView.m
//  XJCalendar
//
//  Created by 肖吉 on 2017/8/28.
//  Copyright © 2017年 jamace. All rights reserved.
//

#import "XJCalendarCollectionView.h"
#import "XJCalendarCollectionCell.h"
#import "XJCalendarHeader.h"
#import "XJCalendarReusableView.h"
@implementation XJCalendarCollectionView

static NSString * const cellId = @"XJCalendarCell";
static NSString * const collectionHeaderIdenter = @"collectionHeaderIdenter";

-(instancetype)initWithFrame:(CGRect)frame
{
    CGFloat itemSpace = XJCItem_Space;
    CGFloat itemWidth = (XJCScreen_Width - itemSpace*8)/7.0f;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth);
    flowLayout.minimumLineSpacing = itemSpace;
    flowLayout.minimumInteritemSpacing = itemSpace;
    flowLayout.sectionInset = UIEdgeInsetsMake(itemSpace, itemSpace, itemSpace, itemSpace);
    flowLayout.headerReferenceSize = CGSizeMake(XJCScreen_Width, XJCWeekday_Height);
    flowLayout.footerReferenceSize = CGSizeMake(XJCScreen_Width, 0);
    
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        [self registerClass:[XJCalendarCollectionCell class] forCellWithReuseIdentifier:cellId];
        [self registerClass:[XJCalendarReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionHeaderIdenter];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end
