//
//  UIBarButtonItem+LBBarButtonItem.h
//  帘邦商城
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LBBarButtonItem)

//Highlighted
+(UIBarButtonItem *)ItemWithImage:(UIImage *)image WithHighlighted:(UIImage *)HighlightedImage Target:(id)target action:(SEL)action;

//Selected
+(UIBarButtonItem *)ItemWithImage:(UIImage *)image WithSelected:(UIImage *)SelectedImage Target:(id)target action:(SEL)action;

//Title
+(UIBarButtonItem *)BackItemWithImage:(UIImage *)image WithHighlighted:(UIImage *)HighlightedImage Target:(id)target action:(SEL)action Title:(NSString *)title;




@end
