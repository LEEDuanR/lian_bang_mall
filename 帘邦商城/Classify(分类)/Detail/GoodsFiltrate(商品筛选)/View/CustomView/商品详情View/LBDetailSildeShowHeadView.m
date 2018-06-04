//
//  LBDetailSildeShowHeadView.m
//  帘邦商城
//
//  Created by apple on 2018/6/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LBDetailSildeShowHeadView.h"
#import "SDCycleScrollView.h"

@interface LBDetailSildeShowHeadView()<SDCycleScrollViewDelegate>
/*轮播图*/
@property(nonatomic , strong)SDCycleScrollView  *scrollView;

@end



@implementation LBDetailSildeShowHeadView
#pragma mark -- inital
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
    
}
-(void)createUI
{
    self.backgroundColor = [UIColor whiteColor];
    _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0,ScreenW, self.dc_height) delegate:self placeholderImage:nil];
    _scrollView.autoScroll = YES;
    _scrollView.autoScrollTimeInterval = 3.0f;
    [self addSubview:_scrollView];
  
}
#pragma mark -- 点击图片跳转
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"点击了%zd张",index);
}

#pragma mark -- Setter Getter Methods
- (void)setSildeShowArr:(NSArray *)sildeShowArr
{
    _sildeShowArr=sildeShowArr;
    _scrollView.imageURLStringsGroup=sildeShowArr;
    
}

@end
