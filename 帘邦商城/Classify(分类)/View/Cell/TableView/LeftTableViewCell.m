//
//  LeftTableViewCell.m
//  帘邦商城
//
//  Created by apple on 2018/5/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LeftTableViewCell.h"
#import "LBLeftTableViewItem.h"
#import "Masonry.h"

@interface LeftTableViewCell();


@end

@implementation LeftTableViewCell

#pragma mark inital

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    return self;
}
-(void)createUI
{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = PFR15Font;
    [self addSubview:_titleLabel];
    
    _indicatorView = [[UIView alloc] init];
    _indicatorView.hidden = NO;
    _indicatorView.backgroundColor = [UIColor redColor];
    [self addSubview:_indicatorView];
 
}
#pragma mark -- 布局
-(void)layoutSubviews
{
    [super layoutSubviews];

    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
    }];
    [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(self);
        make.width.mas_equalTo(4);
    }];
    
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        _indicatorView.hidden = NO;
        _titleLabel.textColor = [UIColor redColor];
        self.backgroundColor = [UIColor whiteColor];
    }else{
        _indicatorView.hidden = YES;
        _titleLabel.textColor = [UIColor blackColor];
        self.backgroundColor = [UIColor clearColor];
    }
    // Configure the view for the selected state
}
#pragma mark - Setter Getter Methods
- (void)setTitle:(LBLeftTableViewItem *)titleItem
{
    _titleItem=titleItem;
    self.titleLabel.text=titleItem.name;
    
}


@end
