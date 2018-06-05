//
//  LBGoodsSetViewController.m
//  帘邦商城
//
//  Created by apple on 2018/5/24.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "LBGoodsSetViewController.h"
#import "DiySearchBar.h"
#import "SPullDownMenuView.h"
#import "LBGoodsTableViewCell.h"
#import "LBGoodsListItem.h"
#import "LBSilderBarView.h"
#import "LBRightCollectionViewItem.h"
@interface LBGoodsSetViewController ()<SPullDownMenuViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic , strong) UITableView *tableView;

@property(nonatomic , strong) SPullDownMenuView * menuView;

@property(nonatomic , strong) NSArray *menuTitle;

@property (strong, nonatomic) NSIndexPath *index;

@property (nonatomic , strong) NSMutableArray *goodsData;

@property(nonatomic ,strong)NSDictionary *dict;
@property(nonatomic ,strong)NSDictionary *selectDict;

@property(nonatomic , strong)DiySearchBar *searchBar;
//拼接的数据
@property(nonatomic ,assign)NSString *order;
@property(nonatomic ,assign)NSString *sort;



@end
static NSString *const LBGoodsTableViewCellID = @"LBGoodsTableViewCell";
@implementation LBGoodsSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor= [UIColor whiteColor];
    [self createUI];
    [self loadData];
    // Do any additional setup after loading the view.
}
-(void)createUI
{
    UIView * bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenW,50)];
    bottomView.backgroundColor= RGB(247, 247, 247);
    [self.view addSubview:bottomView];
    _searchBar = [[DiySearchBar alloc] initWithFrame:CGRectMake(10, 10, ScreenW - 90, 30)];
    _searchBar.placeholder = @"输入关键字...";
    //添加一些阴影
    _searchBar.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _searchBar.layer.shadowOpacity = 0.5;
    _searchBar.layer.shadowRadius = 2.0;
    _searchBar.layer.shadowOffset = CGSizeMake(0, 2);
    _searchBar.clipsToBounds = YES;
    
    //设置背景图是为了去掉背景色
    _searchBar.backgroundImage = [UIImage imageNamed:@"kk"];
    //    会限制搜索框的高度
    //    _searchBar.scopeBarBackgroundImage = [UIImage imageNamed:@"kk"];
    [bottomView addSubview:_searchBar];
    UIButton * searchButton =[[UIButton alloc]initWithFrame:CGRectMake( ScreenW-65,10, 55, 30)];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    searchButton.layer.cornerRadius=5.0f;
    searchButton.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;
    searchButton.backgroundColor=RGB(108, 166, 60);
    [searchButton addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:searchButton];
    self.menuTitle = @[@[@"综合",@"新品优先",@"评论数从高到低"],@[@"销量"],@[@"价格",@"价格从高到低",@"价格从低到高"],@[@"筛选"]];

    self.menuView = [[SPullDownMenuView alloc] initWithFrame:CGRectMake(0, 114, ScreenW, 40) withTitle:self.menuTitle withSelectColor:RGB(58, 176,52)];
    self.menuView.delegate = self;
    [self.view addSubview:self.menuView];
    
    
}
#pragma mark Lazyload
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView=[[UITableView  alloc]initWithFrame:CGRectMake(0,154, ScreenW, ScreenH-154) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.showsVerticalScrollIndicator=NO;
        [self.view addSubview:_tableView];
        [_tableView registerClass:[LBGoodsTableViewCell class] forCellReuseIdentifier:LBGoodsTableViewCellID];
        
    }
    return _tableView;
    
}
-(void)loadData
{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval= 10.0f;
    _dict = @{@"merchtype":@"0",@"cate":[LBRightCollectionViewItem shareInstance].id,@"keywords":@"",@"isrecommand":@"0",@"order":@"",@"sort":@"",@"psize":@"10",@"page":@"1"};
   
    if ([[LBRightCollectionViewItem shareInstance].type isEqualToString:@"2"]) {
        _dict=@{@"merchtype":@"0",@"brand":[LBRightCollectionViewItem shareInstance].id,@"keywords":@"",@"isrecommand":@"0",@"order":@"",@"sort":@"",@"psize":@"10",@"page":@"1"};
    }
//     NSLog(@"dict %@",_dict);
    [manager POST:LBGoodsListData parameters:_dict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _goodsData = [LBGoodsListItem mj_objectArrayWithKeyValuesArray:[self goodsDatawithData:responseObject]];
//        NSLog(@"goodsData %@",goodsData);

        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
- (void)pullDownMenuView:(SPullDownMenuView *)menu didSelectedIndex:(NSIndexPath *)indexPath{
    self.index = indexPath;
//    NSLog(@"menu %zd",indexPath.row);
    if (indexPath.row == 3) {
        [LBSilderBarView lb_showShilderBarView];
    }
  
//    NSLog(@"row %zd",indexPath.section);
//  self.menuTitle = @[@[@"综合",@"新品优先",@"评论数从高到低"],@[@"销量"],@[@"价格",@"价格从高到低",@"价格从低到高"],@[@"筛选"]];
    
    //根据上面的标题来确定选择的筛选项
    NSArray *orderArr = @[@[@"",@"createtime",@"comment"],@[@"salesreal"],@[@"",@"memberprice",@"memberprice"],@[@""]];
    NSArray * ARR = orderArr[indexPath.row];
    _order = ARR[indexPath.section];
    NSLog(@"_order  %@", _order);
   NSArray *  sortArr = @[@[@"asc",@"asc",@"desc"],@[@"asc"],@[@"asc",@"desc",@"asc"],@[@""]];
    NSArray * arr = sortArr[indexPath.row];
    _sort= arr[indexPath.section];
    NSLog(@"_sort %@",_sort);
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval= 10.0f;
//    NSDictionary * dict = @{@"merchtype":@"0",@"merchid":@"0",@"cate":[LBRightCollectionViewItem shareInstance].id,@"keywords":@"",@"isrecommand":@"0",@"order":_order,@"sort":_sort,@"psize":@"10",@"page":@"1",@"filters":@""};
    _selectDict = @{@"merchtype":@"0",@"cate":[LBRightCollectionViewItem shareInstance].id,@"keywords":@"",@"isrecommand":@"0",@"order":_order,@"sort":_sort,@"psize":@"10",@"page":@"1"};
    
    if ([[LBRightCollectionViewItem shareInstance].type isEqualToString:@"2"]) {
        _selectDict=@{@"merchtype":@"0",@"brand":[LBRightCollectionViewItem shareInstance].id,@"keywords":@"",@"isrecommand":@"0",@"order":_order,@"sort":_sort,@"psize":@"10",@"page":@"1"};
    }
    [manager POST:LBGoodsListData parameters:_selectDict progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _goodsData = [LBGoodsListItem mj_objectArrayWithKeyValuesArray:[self goodsDatawithData:responseObject]];
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error%@",error);
    }];

}

#pragma mark--<UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _goodsData.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LBGoodsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:LBGoodsTableViewCellID forIndexPath:indexPath];
    cell.goodsListItem = _goodsData[indexPath.row];
    return cell;
}
#pragma mark -- <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"dianji %zd",indexPath.row);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(NSArray *)goodsDatawithData:(NSData *)responseObject
{
    
    //解析出来的json数据这边要做截取处理 后台传过来的数据前面加了个jsonReturn() 我们要把jsonReturn()给截掉
    NSString *str=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
    NSRange range = NSMakeRange(12,[str length]-14);
    NSString * subStr= [str substringWithRange: range];
    NSData *jsonData = [subStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *strDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:nil];
    NSDictionary * listDic=strDict[@"data"];
    //        NSLog(@"list -- %@",listDic);
    NSArray *goodsData = listDic[@"list"];
    
    return goodsData;
}
-(void)searchClick:(UIButton *)button
{
    NSLog(@"点击搜索");
}


// 将点击tableviewcell的时候收回 searchBar 键盘
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_searchBar resignFirstResponder];
    return indexPath;
}
// 滑动的时候 searchBar 回收键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_searchBar resignFirstResponder];
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
