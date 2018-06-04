//
//  LBRightCollectionListData.m
//  帘邦商城
//
//  Created by apple on 2018/5/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LBRightCollectionListData.h"

@implementation LBRightCollectionListData
+ (NSDictionary *)mj_objectClassInArray {
    
    // 表明你subcate数组存放的将是LBRightCollectionViewItem类的模型
    return @{
             @"subcate" : @"LBRightCollectionViewItem",
             };
}

@end
