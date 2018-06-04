//
//  constant.h
//  帘邦商城
//
//  Created by apple on 2018/5/18.
//  Copyright © 2018年 apple. All rights reserved.
//

#ifndef constant_h
#define constant_h

//首次进入分类页面
#define  LBClassifyData @"http://api.lianbangyoupin.cn/api/goods/category"
//分类选择接口
#define  LBClassifySelectData @"http://api.lianbangyoupin.cn/api/goods/getSubCategory"
//产品列表
#define  LBGoodsListData  @"http://api.lianbangyoupin.cn/api/goods/showlist"

#define  LBGoodsListDataTest @"http://api.lianbangyoupin.cn/api/goods/showlist?merchtype=0&merchid=0&cate=1638&keywords=&type=1&isrecommand=0&order=&sort=0&psize=20&page=1"
//筛选项列表接口
#define LBGoodFilterData @"http://api.lianbangyoupin.cn/api/goods/getCateFilter"

//http://api.lianbangyoupin.cn/api/goods/getCateFilter?cate=1258&filter=%E2%80%98959,960,961%E2%80%99

#endif /* constant_h */
