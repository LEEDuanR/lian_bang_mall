//
//  LBRightCollectionViewItem.m
//  帘邦商城
//
//  Created by apple on 2018/5/17.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LBRightCollectionViewItem.h"
#import <objc/runtime.h>

@implementation LBRightCollectionViewItem
//- (void)setValue:(id)value forUndefinedKey:(NSString *)key  {
//    if([key isEqualToString:@"id"])
//        self.userId = value;
//}
+(instancetype)shareInstance
{
    LBRightCollectionViewItem *manager;
    NSString *docPath  = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString * path = [docPath stringByAppendingPathComponent:@"LBRightCollectionViewItem.archiver"];
    manager = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return manager;
}
- (void)encodeWithCoder:(NSCoder *)coder
{
    unsigned int count = 0 ;
    Ivar *ivars = class_copyIvarList([LBRightCollectionViewItem class], &count);//传递count的地址，修改count的值
    for (int i = 0 ; i<count; i++) {
        Ivar ivar = ivars[i]; //得到成员变量对象(内存位置)
        const char *name= ivar_getName(ivar);//得到成员变量名称
        NSString * key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [coder encodeObject:value forKey:key];
    }
    free(ivars);//OC 的ARC只管理OC对象内存，这里C创建的所以要释放
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self= [super init]) {
        unsigned  int count = 0;
        Ivar *ivars = class_copyIvarList([LBRightCollectionViewItem class], &count);
        for (int i=0; i<count; i++) {
            Ivar ivar = ivars[i];//得到成员变量对象（内存位置）
            const char *name = ivar_getName(ivar);//得到成员变量名称
            //归档
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            //设置到成员变量身上
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    

    return self;
}




@end
