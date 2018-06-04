//
//  LBRightCollectionListData.h
//  帘邦商城
//
//  Created by apple on 2018/5/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBRightCollectionViewItem.h"
#import "LBRightHeaderItem.h"


@interface LBRightCollectionListData : NSObject

@property(nonatomic , strong)LBRightHeaderItem * current;
@property(nonatomic , strong)NSMutableArray<LBRightCollectionViewItem *> * subcate;


@end
