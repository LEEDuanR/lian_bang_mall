//
//  LBFiltrateItem.h
//  帘邦商城
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBSectionItem.h"

@interface LBFiltrateItem : NSObject


@property(nonatomic , copy) NSString * type_name;

/*内容数组*/
@property(nonatomic ,strong) NSMutableArray<LBSectionItem *> *list;

/*判断当前的cell是否展开*/
@property(nonatomic ,assign) BOOL isOpen;

@end
