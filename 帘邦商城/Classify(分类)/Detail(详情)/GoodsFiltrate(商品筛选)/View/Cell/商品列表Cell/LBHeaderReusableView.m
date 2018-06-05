//
//  LBHeaderReusableView.m
//  帘邦商城
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LBHeaderReusableView.h"
#import "LBFiltrateItem.h"

@interface LBHeaderReusableView()

@property (weak, nonatomic) IBOutlet UILabel *headLabel;

@end

@implementation LBHeaderReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setHeadFiltrate:(LBFiltrateItem *)headFiltrate
{
    _headLabel.text = headFiltrate.type_name;
    
    if (headFiltrate.isOpen) { //箭头
        [self.upDownButton setImage:[UIImage imageNamed:@"arrow_up"] forState:0];
    }else{
        [self.upDownButton setImage:[UIImage imageNamed:@"arrow_down"] forState:0];
    }
}
- (IBAction)buttonClick:(UIButton *)sender {
    !_sectionClick ? : _sectionClick();
}
@end
