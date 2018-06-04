//
//  LBHeaderReusableView.h
//  帘邦商城
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LBFiltrateItem;
@interface LBHeaderReusableView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *headerSelectLabel;
@property (weak, nonatomic) IBOutlet UIButton *upDownButton;


/* 头部数组 */
@property (strong , nonatomic)LBFiltrateItem * headFiltrate;
/** 头部点击 */
@property (nonatomic, copy) dispatch_block_t sectionClick;

@end
