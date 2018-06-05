//
//  LBSectionItem.h
//  帘邦商城
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBSectionItem : NSObject

/*是否点击*/
@property(nonatomic , assign) BOOL isSelect;

@property(nonatomic , assign) NSInteger key;
@property(nonatomic , assign) NSInteger value;
@property(nonatomic , copy) NSString *name;
@property(nonatomic , copy) NSString *current;


@end
