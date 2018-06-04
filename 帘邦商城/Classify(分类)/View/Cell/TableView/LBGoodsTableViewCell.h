//
//  LBGoodsTableViewCell.h
//  帘邦商城
//
//  Created by apple on 2018/5/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "LBGoodsListItem.h"

@class LBGoodsListItem ;
@interface LBGoodsTableViewCell : UITableViewCell

@property(nonatomic , strong) LBGoodsListItem * goodsListItem;

@end
