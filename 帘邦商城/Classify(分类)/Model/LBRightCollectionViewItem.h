//
//  LBRightCollectionViewItem.h
//  帘邦商城
//
//  Created by apple on 2018/5/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBRightCollectionViewItem : NSObject

@property(nonatomic,copy)NSString *id;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *attributes;
@property(nonatomic,copy)NSString *parentid;
@property(nonatomic,copy)NSString *thumb;
@property(nonatomic,copy)NSString *targetcate;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *merchid;
@property(nonatomic,strong)NSDictionary *filters;


+(instancetype)shareInstance;

@end
