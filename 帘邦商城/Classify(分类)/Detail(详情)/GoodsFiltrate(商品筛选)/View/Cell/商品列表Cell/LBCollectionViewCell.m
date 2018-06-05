//
//  LBCollectionViewCell.m
//  帘邦商城
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LBCollectionViewCell.h"
#import "LBFiltrateItem.h"
#import "LBSectionItem.h"
#import "DCSpeedy.h"
@interface LBCollectionViewCell()
@property(nonatomic , strong) UIButton * contentButton;


@end


@implementation LBCollectionViewCell
#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI
{
    _contentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _contentButton.enabled = NO;
    [self addSubview:_contentButton];
    _contentButton.titleLabel.font = PFR12Font;
    [_contentButton setTitleColor:[UIColor blackColor] forState:0];
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_contentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}


#pragma mark - Setter Getter Methods

- (void)setSectionItem:(LBSectionItem *)sectionItem
{
    _sectionItem = sectionItem;
    [_contentButton setTitle:sectionItem.name forState:0];
    
    if (sectionItem.isSelect) {
                [_contentButton setImage:nil forState:0];
                [_contentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                _contentButton.backgroundColor =RGB(108, 166, 60);
        [DCSpeedy dc_chageControlCircularWith:self AndSetCornerRadius:3 SetBorderWidth:1 SetBorderColor:RGB(108, 166, 60) canMasksToBounds:YES];
            }else{
        
                [_contentButton setImage:nil forState:0];
                [_contentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                _contentButton.backgroundColor = RGB(247, 247, 247);
                 [DCSpeedy dc_chageControlCircularWith:self AndSetCornerRadius:3 SetBorderWidth:1 SetBorderColor:RGB(230, 230, 230) canMasksToBounds:YES];
            }
}
@end
