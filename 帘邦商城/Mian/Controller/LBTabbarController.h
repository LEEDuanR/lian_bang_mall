//
//  LBTabbarController.h
//  帘邦商城
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSInteger ,LBTabBarControllerType){
    LBTabBarControllerHomePage = 0,  //首页
    LBTabBarControllerClassify = 1, //分类
    LBTabBarControllerShoppingCart = 2,  //购物车
    LBTabBarControllerMessage = 3, //消息
    
    LBTabBarControllerPersonal = 4, //我的
};
@interface LBTabbarController : UITabBarController

//控制器 Type

@property(nonatomic,assign)LBTabBarControllerType tabVcType;

@end
