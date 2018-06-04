//
//  LBGoodsListItem.h
//  帘邦商城
//
//  Created by apple on 2018/5/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBGoodsListItem : NSObject
//"id": 3107,
//"unit": "米",
//"pcate": 1194,
//"merchid": 2846,
//"title": "欧式风格布艺窗帘棉麻拼接印花系列成品",
//"thumb": "http:\/\/img2.suneastzy.com\/gG0cK04vnPp0u1XX4Xcgx8xgR1fXk8.jpg?imageView2\/0\/w\/300\/h\/300\/q\/90|imageslim",
//"view_style": 0,
//"marketprice": "0.00",
//"seven": 0,
//"repair": 0,
//"quality": 0,
//"sales": 0,
//"brand2": "",
//"total": 1000,
//"description": null,
//"type": 1,
//"merchname": "豪庭阁",
//"mrecommand": 0,
//"brandname": "豪庭阁",
//"suggestprice": "0.00",
//"memberprice": "210.00",
//"market_price": "0.00",
//"discount": "0.0",
//"coin_discount": "0.00",
//"coin_reward": "100.00",
//"discount_price": "42.00",
//"real_price": "168.00",
//"platform": ""
@property(nonatomic , assign)NSInteger id;
@property(nonatomic , copy)NSString *unit;
@property(nonatomic , assign)NSInteger  pcate;
@property(nonatomic , assign)NSInteger merchid;
@property(nonatomic , copy)NSString * title;
@property(nonatomic , copy)NSString * thumb;
@property(nonatomic , assign)NSInteger view_style;
@property(nonatomic , copy)NSString * marketprice;
@property(nonatomic , assign)NSInteger seven;
@property(nonatomic , assign)NSInteger repair;
@property(nonatomic , assign)NSInteger quality;
@property(nonatomic , assign)NSInteger sales;
@property(nonatomic , copy)NSString * brand2;
@property(nonatomic , assign)NSInteger total;
@property(nonatomic , copy)NSString * Description;
@property(nonatomic , assign)NSInteger type;
@property(nonatomic , copy)NSString *merchname;
@property(nonatomic , assign)NSInteger mrecommand ;
@property(nonatomic , copy)NSString * brandname;
@property(nonatomic , copy)NSString * suggestprice;
@property(nonatomic , copy)NSString * memberprice;
@property(nonatomic , copy)NSString * market_price;
@property(nonatomic , copy)NSString * discount;
@property(nonatomic , copy)NSString * coin_discount;
@property(nonatomic , copy)NSString * coin_reward;
@property(nonatomic , copy)NSString * discount_price;
@property(nonatomic , copy)NSString * real_price;
@property(nonatomic , copy)NSString * platform;

@end
