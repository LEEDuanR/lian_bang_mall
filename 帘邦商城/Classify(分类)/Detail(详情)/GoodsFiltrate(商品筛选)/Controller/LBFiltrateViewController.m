//
//  LBFiltrateViewController.m
//  帘邦商城
//
//  Created by apple on 2018/5/28.
//  Copyright © 2018年 apple. All rights reserved.
//

#define FiltrateViewScreenW ScreenW * 0.8


#import "LBFiltrateViewController.h"
//model
#import "LBFiltrateItem.h"
#import "LBSectionItem.h"
//cell
#import "LBCollectionViewCell.h"
#import "LBHeaderReusableView.h"
#import "LBFooterReusableView.h"
//view
#import "LBFiltrateTopViiew.h"

@interface LBFiltrateViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/*筛选父视图*/
@property(nonatomic , strong) UIView *filtrateConView;

@property(nonatomic , strong) UICollectionView * collectionView;

//数据数组
@property(nonatomic , strong) NSMutableArray<LBFiltrateItem *> *filtrateItem;
/*已选*/
@property(nonatomic , strong) NSMutableArray * selectArr;


//@property(nonatomic , strong) NSMutableArray *dataArr;
@property(nonatomic , strong) NSMutableArray *sectionHeaderName;
@property(nonatomic , strong) NSMutableArray *sectionButtonItem;
@property(nonatomic , strong) NSMutableArray *sectionButtonName;



@end
static NSString *const LBCollectionViewCellID = @"LBCollectionViewCell";
static NSString * const LBHeaderReusableViewID = @"LBHeaderReusableView";
static NSString * const LBFooterReusableViewID = @"LBFooterReusableView";
@implementation LBFiltrateViewController


- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 10 ;//竖间距
        layout.itemSize = CGSizeMake((FiltrateViewScreenW-30)/3, 30);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self ;
        _collectionView.alwaysBounceVertical=YES;
        _collectionView.frame= CGRectMake(5, 10, FiltrateViewScreenW - 10 ,ScreenH - 60);
        _collectionView.showsVerticalScrollIndicator= NO;
        
        //注册cell
        [_collectionView registerClass:[LBCollectionViewCell class]
            forCellWithReuseIdentifier:LBCollectionViewCellID];
        
        //注册头部
        [_collectionView  registerNib:[UINib nibWithNibName:NSStringFromClass([LBHeaderReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:LBHeaderReusableViewID];
        //注册尾部
        [_collectionView    registerClass:[LBFooterReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:LBFooterReusableViewID];
    }
    
    return _collectionView;
}
-(NSMutableArray<LBFiltrateItem *> *)filtrateItem
{
    
    if (!_filtrateItem) {
        _filtrateItem = [NSMutableArray array];
    }
    return _filtrateItem;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpInit];
    [self loadData];
    [self setUpBottomButton];
   

}
-(void)setUpInit
{
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
    LBFiltrateTopViiew *rightTopView =[[LBFiltrateTopViiew alloc]initWithFrame:CGRectMake(0, -95, FiltrateViewScreenW, 100)];
    [self.collectionView addSubview:rightTopView];
    
    _filtrateConView = [UIView new];
    _filtrateConView.backgroundColor = [UIColor whiteColor];
    _filtrateConView.frame = CGRectMake(0, 0, FiltrateViewScreenW , ScreenH);
    [self.view addSubview:_filtrateConView];
    [_filtrateConView addSubview:self.collectionView];
}
-(void)loadData
{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval= 10.0f;
    NSDictionary *dict = @{@"cate":[LBRightCollectionViewItem shareInstance].id,@"filter":[LBRightCollectionViewItem shareInstance].attributes};
    [manager POST:LBGoodFilterData parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *str=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSRange range = NSMakeRange(12,[str length]-14);
        NSString * subStr= [str substringWithRange: range];
        NSData *jsonData = [subStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *strDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                options:NSJSONReadingMutableContainers
                                                            error:nil];
        //总的数据数组
//        self.dataArr = [NSMutableArray  new];
        //装每组头部名称
        self.sectionHeaderName = [NSMutableArray new];
        //每行的模型数组
        self.sectionButtonItem = [NSMutableArray new];
        //每行按钮的名称
        self.sectionButtonName = [NSMutableArray new];
        NSArray * listDic=strDict[@"data"];
        _filtrateItem = [LBFiltrateItem mj_objectArrayWithKeyValuesArray:listDic];
//        NSLog(@"%@",self.dataArr);
        for (LBFiltrateItem *item in _filtrateItem) {
            [self.sectionHeaderName addObject:item.type_name];
            [self.sectionButtonItem addObject:item.list];
            for (LBSectionItem *sectionItem in item.list) {
                [self.sectionButtonName addObject:sectionItem.name];
            }
        }
        
//        NSLog(@"self.dataArr %@",_filtrateItem);
//        NSLog(@"type_name %@",self.sectionHeaderName);
//        NSLog(@"list %@",self.sectionButtonItem);
//        NSLog(@"buttonName %@" ,self.sectionButtonName);
        [self.collectionView reloadData];
//        NSLog(@"listDic %@",listDic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error %@",error);
    }];
    
    
}
#pragma  mark -- 底部的重置确定按钮
- (void)setUpBottomButton
{
    CGFloat buttonW = FiltrateViewScreenW/2;
    CGFloat buttonH = 50;
    CGFloat buttonY = ScreenH - buttonH;
    NSArray *titles = @[@"重置",@"确定"];
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.tag = i;
        if (i == 0) {
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        CGFloat buttonX = i*buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.titleLabel.font = PFR16Font;
        button.backgroundColor = (i == 0) ? self.collectionView.backgroundColor : RGB(108, 166, 60);
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_filtrateConView addSubview:button];
    }
}
#pragma mark -- <UICollectionDataSource>
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return  self.filtrateItem.count;
}
#pragma mark  -- <UICollectionViewDelegate>
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray * buttonItem =_sectionButtonItem[section];
     NSInteger oneLine = (buttonItem.count >= 3) ? 3 : buttonItem.count; //默认一行
    return  _filtrateItem[section].isOpen == YES ? buttonItem.count:  oneLine;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LBCollectionViewCell *cell = [collectionView  dequeueReusableCellWithReuseIdentifier:LBCollectionViewCellID forIndexPath:indexPath];
    cell.sectionItem = _sectionButtonItem[indexPath.section][indexPath.row];
    return cell;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        LBHeaderReusableView *headerView = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:LBHeaderReusableViewID forIndexPath:indexPath];
         NSArray * buttonItem =_sectionButtonItem[indexPath.section];
        if (buttonItem.count <= 3) {
            headerView.upDownButton.hidden = YES;
        }else
        {
            headerView.upDownButton.hidden=NO;
            
        }
        
        WEAKSELF
        headerView.sectionClick = ^{
            
            weakSelf.filtrateItem[indexPath.section].isOpen = !weakSelf.filtrateItem[indexPath.section].isOpen; //打开取反
            
            [self.collectionView reloadData]; //刷新
        };
        //给每组的header的已选label赋值~
        
        NSArray *array = _selectArr[indexPath.section];
        NSString *selectName = @"";
        for (NSInteger i = 0; i < array.count; i ++ ) {
            if (i == array.count - 1) {
                selectName = [selectName stringByAppendingString:[NSString stringWithFormat:@"%@",array[i]]];
            }else{
                selectName = [selectName stringByAppendingString:[NSString stringWithFormat:@"%@,",array[i]]];
            }
            
        }
        headerView.headerSelectLabel.text = (selectName.length == 0) ? @"" : selectName;
        headerView.headerSelectLabel.textColor = ([headerView.headerSelectLabel.text isEqualToString:@""]) ?  [UIColor darkGrayColor] : [UIColor redColor];
        
        
        headerView.headFiltrate = _filtrateItem[indexPath.section];
        
        return headerView;
    }else
    {
        LBFooterReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:LBFooterReusableViewID forIndexPath:indexPath];
        return footerView;
        
    }
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    _filtrateItem[indexPath.section].list[indexPath.row].isSelect = ! _filtrateItem[indexPath.section].list[indexPath.row].isSelect;
    
    //数组mutableCopy初始化,for循环加数组 结构大致：@[@[],@[]] 如此
    _selectArr = [@[] mutableCopy];
    for (NSInteger i = 0; i < _filtrateItem.count; i++) {
        NSMutableArray *section = [@[] mutableCopy];
        [_selectArr addObject:section];
    }

    //把所选的每组Item分别加入每组的数组中
    for (NSInteger i = 0; i < _filtrateItem.count; i++) {
        for (NSInteger j = 0; j < _filtrateItem[i].list.count; j++) {
            if (_filtrateItem[i].list[j].isSelect == YES) {
                [_selectArr[i] addObject:_filtrateItem[i].list[j].name];
            }else{
                [_selectArr[i] removeObject:_filtrateItem[i].list[j].name];
            }
        }
    }

    
    [self.collectionView reloadData];
    NSLog(@"点击了第%zd组第%zd行",indexPath.section,indexPath.row);
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.collectionView.dc_width, 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(self.collectionView.dc_width,10);
}

//点击事件
-(void)bottomButtonClick:(UIButton *)button
{
     //点击重置
    if (button.tag == 0) {
        
        
        
    }else if (button.tag == 1)//点击确定
    {
        
        
        
        
    }
    
    
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
