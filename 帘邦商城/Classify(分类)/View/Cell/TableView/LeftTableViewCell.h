//
//  LeftTableViewCell.h
//  帘邦商城
//
//  Created by apple on 2018/5/17.
//  Copyright © 2018年 apple. All rights reserved.
//



#import <UIKit/UIKit.h>
@class LBLeftTableViewItem;

@interface LeftTableViewCell : UITableViewCell

@property(nonatomic , strong)LBLeftTableViewItem * titleItem;
@property(nonatomic , strong) UILabel *titleLabel;
@property(nonatomic , strong) UIView  *indicatorView;

@end
