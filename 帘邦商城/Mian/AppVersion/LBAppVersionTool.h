//
//  LBAppVersionTool.h
//  帘邦商城
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBAppVersionTool : NSObject
/*
   获取之前保存的版本
   return NSString类型的AppVersion
 */
+ (NSString *)lb_GetLastOneVersion;
    
+(void)lb_SaveNewAppVersion:(NSString *)version;
    
@end
