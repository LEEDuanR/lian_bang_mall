//
//  LBRightCollectionViewCell.m
//  帘邦商城
//
//  Created by apple on 2018/5/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LBRightCollectionViewCell.h"

#import "LBRightCollectionViewItem.h"

#import <UIImageView+WebCache.h>



@interface LBRightCollectionViewCell()

@property(nonatomic , strong) UIImageView * classifyImageView;

@property(strong , nonatomic) UILabel * classifyLabel;

@end

@implementation LBRightCollectionViewCell

#pragma mark --- inital
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark -- createUI
-(void)createUI
{
    self.backgroundColor=DCBGColor;
    _classifyImageView=[[UIImageView alloc]init];
//    _classifyImageView.backgroundColor=[UIColor yellowColor];
//    _classifyImageView.contentMode=UIViewContentModeScaleAspectFit;
    _classifyImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_classifyImageView];
    _classifyLabel = [[UILabel  alloc]init];
    _classifyLabel.font = PFR13Font;
    _classifyLabel.adjustsFontSizeToFitWidth=YES;
    _classifyLabel.textAlignment=NSTextAlignmentCenter;
    [self addSubview:_classifyLabel];
    
}
#pragma  mark -- 布局
-(void)layoutSubviews
{
    [_classifyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.top.mas_equalTo(self)setOffset:5];
        make.size.mas_equalTo(CGSizeMake(self.dc_width * 0.85, self.dc_width * 0.85));
    }];
    
    [_classifyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(self->_classifyImageView.mas_bottom)setOffset:5];
        make.width.mas_equalTo(self->_classifyImageView);
        make.centerX.mas_equalTo(self);
    }];
    
    
}
- (void)setRightItem:(LBRightCollectionViewItem *)rightItem
{
    _rightItem=rightItem;
    [_classifyImageView  sd_setImageWithURL:[NSURL URLWithString:rightItem.thumb]];
    _classifyLabel.text=rightItem.name;
    
}






@end
