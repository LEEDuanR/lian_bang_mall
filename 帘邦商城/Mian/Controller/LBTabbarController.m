//
//  LBTabbarController.m
//  帘邦商城
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LBTabbarController.h"
#import "LBNavigationController.h"



@interface LBTabbarController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) NSMutableArray *tabBarItems;

@end

@implementation LBTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate=self;
    [self addLBChildViewController];
    self.selectedViewController=[self.viewControllers objectAtIndex:1];
    // Do any additional setup after loading the view.
}

- (NSMutableArray  *)tabBarItem
{
    if (_tabBarItems == nil) {
        _tabBarItems = [NSMutableArray array];
    }
    
    return _tabBarItems;
    
    
}
-(void)addLBChildViewController
{
    NSArray *childArray=@[
                          @{MallClassKey  : @"HomePageViewController",
                            MallTitleKey  : @"首页",
                            MallImgKey    : @"tabbar_01_up",
                            MallSelImgKey : @"tabbar_01_down"},
                          
                          @{MallClassKey  : @"ClassifyViewController",
                            MallTitleKey  : @"分类",
                            MallImgKey    : @"tabbar_02_up",
                            MallSelImgKey : @"tabbar_02_down"},
                          
                          @{MallClassKey  : @"ShoppingCartViewController",
                            MallTitleKey  : @"购物车",
                            MallImgKey    : @"tabbar_03_up",
                            MallSelImgKey : @"tabbar_03_down"},
                          
                          @{MallClassKey  : @"MessageViewController",
                            MallTitleKey  : @"消息",
                            MallImgKey    : @"tabbar_04_up",
                            MallSelImgKey : @"tabbar_04_down"},
                          
                          @{MallClassKey  : @"PersonalCenterViewController",
                            MallTitleKey  : @"我的",
                            MallImgKey    : @"tabbar_05_up",
                            MallSelImgKey : @"tabbar_05_down"},
                          ];
    [childArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *vc=[NSClassFromString(dict[MallClassKey]) new];
        LBNavigationController *nav=[[LBNavigationController alloc]initWithRootViewController:vc];
        UITabBarItem *item=nav.tabBarItem;
        item.image=[UIImage imageNamed:dict[MallImgKey]];
        item.selectedImage=[[UIImage imageNamed:dict[MallSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
      item.title=dict[MallTitleKey];
        
        [self addChildViewController:nav];
        item.imageInsets=UIEdgeInsetsMake(0,0,0,0);
        
        [self.tabBarItems addObject:vc.tabBarItem];
    }];
                          
    
    
}
#pragma mark - <UITabBarControllerDelegate>
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
    
    
    
    
}
#pragma mark - 点击动画
- (void)tabBarButtonClick:(UIControl *)tabBarButton
{
    for (UIView *imageView in tabBarButton.subviews) {
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            //需要实现的帧动画,这里根据自己需求改动
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"transform.scale";
            animation.values = @[@1.0,@1.1,@0.9,@1.0];
            animation.duration = 0.3;
            animation.calculationMode = kCAAnimationCubic;
            //添加动画
            [imageView.layer addAnimation:animation forKey:nil];
        }
    }
    
}
#pragma mark - 禁止屏幕旋转
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
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
