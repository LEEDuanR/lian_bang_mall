//
//  LBGoodsTableViewCell.m
//  帘邦商城
//
//  Created by apple on 2018/5/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LBGoodsTableViewCell.h"
#import "LBGoodsListItem.h"
#import <UIImageView+WebCache.h>


@interface LBGoodsTableViewCell ()
/*商品图片*/
@property(nonatomic , strong) UIImageView *goodsImageView;
/*帘邦优选*/
@property(nonatomic , strong) UIImageView *goodSelect;
/*商品标题*/
@property(nonatomic , strong) UILabel * goodsTitle;
/*标题下面的价格*/
@property(nonatomic , strong) UILabel * memberPriceLabel;
/*左边的价格*/
@property(nonatomic , strong) UILabel * realPriceLabel;
/*右边的价格*/
@property(nonatomic , strong) UILabel * discountPriceLabel;
/*最下面的label*/
@property(nonatomic , strong) UILabel * bottomLabel;

@end

@implementation LBGoodsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//-(instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self createUI];
//    }
//     return  self;
//}
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
    self.backgroundColor = [UIColor whiteColor];
    
    _goodsImageView = [[UIImageView alloc]init];
    _goodsImageView.contentMode = UIViewContentModeScaleToFill ;
    [self addSubview:_goodsImageView];
    
    _goodsTitle = [[UILabel alloc]init];
    _goodsTitle.numberOfLines=2;
    _goodsTitle.font= PFR13Font;
    _goodsTitle.textAlignment = NSTextAlignmentLeft;
    [self addSubview: _goodsTitle];
    
    _memberPriceLabel= [[UILabel alloc]init];
    _memberPriceLabel.font = PFR13Font;
    [self addSubview:_memberPriceLabel];
    
    _realPriceLabel = [[UILabel alloc]init];
    _realPriceLabel.font = PFR13Font;
    [self addSubview:_realPriceLabel];
    
    _discountPriceLabel = [[UILabel alloc]init];
    _discountPriceLabel.font = PFR13Font;
    [self addSubview:_discountPriceLabel];
    
    _bottomLabel = [[UILabel alloc]init];
    _bottomLabel.textColor = [UIColor redColor];
     _bottomLabel.layer.borderColor = [[UIColor redColor]CGColor];
     _bottomLabel.layer.borderWidth = 0.5f;
     _bottomLabel.layer.masksToBounds = YES;
    _bottomLabel.layer.cornerRadius=5.0f;
    _bottomLabel.font = PFR13Font ;
    _bottomLabel.text=[NSString stringWithFormat:@"按支付现金返等额帘邦豆"];
    _bottomLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_bottomLabel];
}

-(void)layoutSubviews
{
     [super layoutSubviews];
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        [make.left.mas_equalTo(self)setOffset:10];
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
    
    [_goodsTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(_goodsImageView.mas_right)setOffset:10];
        [make.top.mas_equalTo(_goodsImageView)setOffset:-3];
        [make.right.mas_equalTo(self)setOffset:-10];
    }];
    
    [_memberPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(_goodsImageView.mas_right)setOffset:10];
        [make.top.mas_equalTo(_goodsTitle.mas_bottom)setOffset:-5];
        make.size.mas_equalTo(CGSizeMake(100, 25));
    }];
    [_realPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       [make.left.mas_equalTo(_goodsImageView.mas_right)setOffset:10];
        [make.top.equalTo(_memberPriceLabel.mas_bottom)setOffset:-5];
        make.size.mas_equalTo(CGSizeMake(75, 25));
    }];
    [_discountPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.equalTo(_realPriceLabel.mas_right)setOffset:5];
        make.top.equalTo(_realPriceLabel);
        make.size.mas_equalTo(CGSizeMake(80, 25));
    }];
    [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(_goodsImageView.mas_right)setOffset:10];
        [make.bottom.mas_equalTo(self.mas_bottom)setOffset:-5];
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    
}
- (void)setGoodsListItem:(LBGoodsListItem *)goodsListItem
{
    _goodsListItem=goodsListItem;

    _goodsTitle.text= [NSString stringWithFormat:@"%@/%@",goodsListItem.brandname,goodsListItem.title];
    _memberPriceLabel.text=[NSString stringWithFormat:@"%@元/%@",goodsListItem.memberprice,goodsListItem.unit];
    _realPriceLabel.text = [NSString stringWithFormat:@"%@元/%@",goodsListItem.real_price,goodsListItem.unit];
    _discountPriceLabel.text=[NSString stringWithFormat:@"+%@元/%@",goodsListItem.discount_price,goodsListItem.unit];
    //对后台传过来的图片url作处理
    NSString *thumb = [NSString stringWithFormat:@"%@",goodsListItem.thumb];
   NSArray *strArr = [thumb  componentsSeparatedByString:@"?"];
    NSString *url = strArr[0];
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        NSLog(@"error%@ ",error);
    }];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
