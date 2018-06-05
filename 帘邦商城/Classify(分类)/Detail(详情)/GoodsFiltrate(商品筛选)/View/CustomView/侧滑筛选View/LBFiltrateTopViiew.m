//
//  LBFiltrateTopViiew.m
//  帘邦商城
//
//  Created by apple on 2018/5/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LBFiltrateTopViiew.h"

#define NUM @"0123456789"

@interface LBFiltrateTopViiew()<UITextFieldDelegate>


@property(nonatomic , strong) UILabel * textLabel;
@property(nonatomic , strong) UILabel * lineLabel;
@property(nonatomic , strong) UITextField *leftTextField;
@property(nonatomic , strong) UITextField *rightTextField;

@end

@implementation LBFiltrateTopViiew

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self crateUI];
    }
    return self;
}
-(void)crateUI
{
    _textLabel = [[UILabel alloc]init];
    _textLabel.font= PFR15Font ;
    _textLabel.text = @"价格区间(元)";
    [self addSubview:_textLabel];
    
    _lineLabel = [[UILabel alloc]init];
    _lineLabel.backgroundColor = [UIColor blackColor];
    [self addSubview:_lineLabel];
    
    _leftTextField = [[UITextField alloc]init];
    _leftTextField.borderStyle = UITextBorderStyleRoundedRect;
    _leftTextField.backgroundColor =RGB(247, 247, 247);
    _leftTextField.delegate=self;

    [self addSubview:_leftTextField];
    
    _rightTextField = [[UITextField alloc]init];
    _rightTextField.borderStyle = UITextBorderStyleRoundedRect;
    _rightTextField.backgroundColor = RGB(247, 247, 247);
    _rightTextField.delegate=self;

    [self addSubview:_rightTextField];
    
    
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.mas_left)setOffset:10];
        [make.top.mas_equalTo(self.mas_top)setOffset:5];
        make.size.mas_equalTo(CGSizeMake(85,30));
    }];
    
    [_leftTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.mas_left)setOffset:10];
        [make.top.mas_equalTo(_textLabel.mas_bottom)setOffset:10];
        make.size.mas_equalTo(CGSizeMake(120, 30));
    }];
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(_leftTextField);
         [make.top.mas_equalTo(_textLabel.mas_bottom)setOffset:25];
//        [make.left.mas_equalTo(_leftTextField.mas_right)setOffset:10];
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(30, 1));
    }];
    [_rightTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(_leftTextField);
          [make.top.mas_equalTo(_textLabel.mas_bottom)setOffset:10];
        [make.right.mas_equalTo(self.mas_right)setOffset:-10];
        make.size.mas_equalTo(CGSizeMake(120, 30));
    }];
}

#pragma mark -- <UITextFieldDelegate>
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validateNumber:string];
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:NUM];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
@end
