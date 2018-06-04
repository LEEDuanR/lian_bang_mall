//
//  UIBarButtonItem+LBBarButtonItem.m
//  帘邦商城
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UIBarButtonItem+LBBarButtonItem.h"

@implementation UIBarButtonItem (LBBarButtonItem)
+(UIBarButtonItem *)ItemWithImage:(UIImage *)image WithHighlighted:(UIImage *)HighlightedImage Target:(id)target action:(SEL)action
{
    UIBarButtonItem *negativeSpacer=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width=-15;
    UIButton *button=[[UIButton  alloc]init];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:HighlightedImage forState:UIControlStateHighlighted];
    button.frame=CGRectMake(0, 0, 44, 44);
    [button setTitleColor:[UIColor blackColor] forState:0];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:button];
    
}
+(UIBarButtonItem *)ItemWithImage:(UIImage *)image WithSelected:(UIImage *)SelectedImage Target:(id)target action:(SEL)action
{
    UIBarButtonItem *negativeSpacer=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width=-15;
    UIButton *button=[[UIButton  alloc]init];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:SelectedImage forState:UIControlStateSelected];
    button.frame=CGRectMake(0, 0, 44, 44);
    [button setTitleColor:[UIColor blackColor] forState:0];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}
+(UIBarButtonItem *)BackItemWithImage:(UIImage *)image WithHighlighted:(UIImage *)HighlightedImage Target:(id)target action:(SEL)action Title:(NSString *)title
{
    UIBarButtonItem *negativeSpacer=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width=-15;
    UIButton *button=[[UIButton  alloc]init];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:HighlightedImage forState:UIControlStateHighlighted];
    button.frame=CGRectMake(0, 0, 44, 44);
    [button setTitleColor:[UIColor blackColor] forState:0];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}



@end
