//
//  LBCollectionHeaderView.m
//  帘邦商城
//
//  Created by apple on 2018/5/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LBCollectionHeaderView.h"
#import "LBRightCollectionViewItem.h"
#import "LBRightHeaderItem.h"
@interface LBCollectionHeaderView ()

/* 头部标题Label */
@property (strong , nonatomic)UILabel *headLabel;

@end

@implementation LBCollectionHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark - UI
- (void)createUI
{
    _headLabel = [[UILabel alloc] init];
    _headLabel.font = PFR15Font;
    _headLabel.textColor = [UIColor blackColor];
    [self addSubview:_headLabel];
    _headLabel.frame = CGRectMake(10, 0, self.dc_width, self.dc_height);
}

#pragma mark - Setter Getter Methods
- (void)setHeadTitle:(LBRightHeaderItem  *)headTitle
{
    _headTitle = headTitle;
    _headLabel.text = headTitle.name;
}




@end
