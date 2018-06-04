//
//  LBAppVersionTool.m
//  帘邦商城
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LBAppVersionTool.h"

@implementation LBAppVersionTool
    
// 获取保存的上一个版本信息
+(NSString *)lb_GetLastOneVersion
    {
        return [[NSUserDefaults standardUserDefaults]stringForKey:@"AppVersion"];
    }
// 保存新版本信息
+(void)lb_SaveNewAppVersion:(NSString *)version
    {
        [[NSUserDefaults standardUserDefaults]setObject:version forKey:@"AppVersion"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }

    
    
@end
