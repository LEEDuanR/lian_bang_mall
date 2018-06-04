//
//  LBNavigationController.m
//  帘邦商城
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LBNavigationController.h"
#import "GQGesVCTransition.h"
#import "UIBarButtonItem+LBBarButtonItem.h"



@interface LBNavigationController ()

@end

@implementation LBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [GQGesVCTransition validateGesBackWithType:GQGesVCTransitionTypePanWithPercentRight withRequestFailToLoopScrollView:YES];//手势返回
    
    
}
#pragma  load 初始化一次
+(void)load
{
    
    [self setUpBase];
    
}


+(void)setUpBase
{
    UINavigationBar *bar=[UINavigationBar appearance];
    bar.barTintColor=[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1];
    [bar setTintColor:[UIColor darkGrayColor]];
    bar.translucent=YES;
    [bar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
     NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    UIColor * naiColor = [UIColor blueColor];
    attributes[NSForegroundColorAttributeName] = naiColor;
    attributes[NSFontAttributeName] = [UIFont fontWithName:[[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? @"PingFangSC-Regular" : @"PingFang SC" size:18];;
    bar.titleTextAttributes = attributes;
}
#pragma 返回
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self.childViewControllers.count >= 1) {
        //返回按钮自定义
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -15;
        
        UIButton *button = [[UIButton alloc] init];
        [button setImage:[UIImage imageNamed:@"navigation_back_normal"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigation_back_hl"] forState:UIControlStateHighlighted];
        button.frame = CGRectMake(0, 0, 33, 33);
        
        if (@available(ios 11.0,*)) {
            button.contentEdgeInsets = UIEdgeInsetsMake(0, -15,0, 0);
            button.imageEdgeInsets = UIEdgeInsetsMake(0, -10,0, 0);
        }
        
        [button addTarget:self action:@selector(backButtonTapClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        viewController.navigationItem.leftBarButtonItems = @[negativeSpacer, backButton];
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 就有滑动返回功能
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    //跳转
    [super pushViewController:viewController animated:animated];
    
    
}


//点击事件
- (void)backButtonTapClick {
    
    [self popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
