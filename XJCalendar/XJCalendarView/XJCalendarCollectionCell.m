//
//  XJCalendarCollectionCell.m
//  XJCalendar
//
//  Created by 肖吉 on 2017/8/28.
//  Copyright © 2017年 jamace. All rights reserved.
//

#import "XJCalendarCollectionCell.h"

@interface XJCalendarCollectionCell()
{
    UILabel *_dayLabel;
}
@end
@implementation XJCalendarCollectionCell


static NSString * const cellId = @"XJCalendarCell";

+(instancetype)XJCalendarCollectionCell:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    XJCalendarCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    return cell;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

-(void)initSubviews
{
    _dayLabel = [[UILabel alloc] init];
    _dayLabel.layer.masksToBounds = YES;
    _dayLabel.layer.cornerRadius = self.frame.size.width/2.0f;
    _dayLabel.textColor = [UIColor blackColor];
    _dayLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_dayLabel];
    _dayLabel.frame = self.contentView.bounds;
}

-(void)setModel:(XJCalendarModel *)model
{
    _dayLabel.text = model.day;
    
    if (model.currentBefore) {
        _dayLabel.textColor = [UIColor lightGrayColor];
    }else{
        _dayLabel.textColor = [UIColor blackColor];
    }
    if (model.isCurrentDay) {
        _dayLabel.textColor = [UIColor whiteColor];
        _dayLabel.backgroundColor = [UIColor redColor];
    }else{
        _dayLabel.backgroundColor = [UIColor clearColor];
    }
    
}
-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
}
@end
