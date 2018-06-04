//
//  ClassifyViewController.m
//  帘邦商城
//
//  Created by apple on 2018/5/16.
//  Copyright © 2018年 apple. All rights reserved.
//
#import "ClassifyViewController.h"
#import "LBLeftTableViewItem.h"
#import "LBRightCollectionViewItem.h"
#import "LeftTableViewCell.h"
#import "LBRightCollectionViewCell.h"
#import "LBCollectionHeaderView.h"
#import "LBRightHeaderItem.h"
#import "LBRightCollectionListData.h"
#import <UIImageView+WebCache.h>
#import "LBGoodsSetViewController.h"

@interface ClassifyViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic , strong) UITableView *tableView;
@property(nonatomic , strong) UICollectionView *collectionView;
//@property(nonatomic , strong)NSMutableArray<LBLeftTableViewItem *> *leftItem;
@property(nonatomic , strong)NSMutableArray<LBRightCollectionViewItem *> *rightItem;//每个item数据的数组
@property(nonatomic , strong)NSMutableArray<LBRightHeaderItem *> * headerItem;
@property(nonatomic , strong)NSMutableArray *leftItemName;//左边栏装name的数组
@property(nonatomic , strong)NSMutableArray *leftItemType;//左边栏装type的数组
@property(nonatomic , strong)NSMutableArray *leftItemId;  //左边栏装id的数组
@property(nonatomic , strong)NSMutableArray *leftItemArr;//左边栏的全部数据
@property(nonatomic , strong)NSMutableArray *headerName; //

@property(nonatomic , strong)NSMutableArray *rightItemArr; //最外层模型数组
@property(nonatomic , strong)NSMutableArray *rightName; //右边装name的数组
@property(nonatomic , strong)NSMutableArray *rightImageUrl; //右边栏装imageUrl的数组
//@property(nonatomic , strong)NSMutableArray *rightSectionItem; //每个item数据的数组
@property(nonatomic , strong)UIImageView * headerImageView;

@property(nonatomic , strong)NSMutableArray * rightAllItem;

@property(nonatomic ,strong) LBRightCollectionViewItem *collectionItem;
@end



@implementation ClassifyViewController
static NSString *const LeftTableViewCellID = @"LeftTableViewCell";
static NSString *const LBRightCollectionViewCellID = @"LBRightCollectionViewCell";
static NSString *const LBCollectionHeaderViewID = @"LBCollectionHeaderView";
#pragma mark Lazyload
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView=[[UITableView  alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame=CGRectMake(0, 64, ScreenW/4-10, ScreenH-64);
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.showsVerticalScrollIndicator=NO;
        [self.view addSubview:_tableView];
        [_tableView registerClass:[LeftTableViewCell class] forCellReuseIdentifier:LeftTableViewCellID];
        
    }
    return _tableView;
    
}

-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout=[UICollectionViewFlowLayout new];
        layout.minimumInteritemSpacing = 3;//X
        layout.minimumLineSpacing = 3; //Y
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.alwaysBounceVertical = NO;
        _collectionView.frame = CGRectMake(ScreenW/4, 69, ScreenW*3/4-5, ScreenH - 69);
        _collectionView.backgroundColor = [UIColor lightGrayColor];
        //注册cell
        [_collectionView registerClass:[LBRightCollectionViewCell class] forCellWithReuseIdentifier:LBRightCollectionViewCellID];
        //注册header
        [_collectionView registerClass:[LBCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:LBCollectionHeaderViewID];

    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor yellowColor];
    [self setUpTab];
    [self loadData];
}
- (void)setUpTab
{
    self.view.backgroundColor=[UIColor whiteColor];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.backgroundColor=DCBGColor;
    self.collectionView.backgroundColor=[UIColor whiteColor];
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    //给右边的collectionView添加头部视图
    self.collectionView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0); //collection向下偏移
    
    // 注意这里设置headerView的头视图的y坐标一定是从"负值"开始,因为headerView是添加在collectionView上的.
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(-ScreenW/4, -165, ScreenW*3/4-5, 95)];
    _headerImageView=[[UIImageView alloc]initWithFrame:CGRectMake(ScreenW/4, 69, ScreenW*3/4-5, 95)];
    [headerView addSubview:_headerImageView];
    [self.collectionView addSubview:headerView];
   self.tableView.tableHeaderView=[UIView new];
    
}
#pragma mark -- 加载数据
-(void)loadData
{
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval= 10.0f;

    [manager GET:LBClassifyData parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //解析出来的json数据这边要做截取处理 后台传过来的数据前面加了个jsonReturn() 我们要把jsonReturn()给截掉
       NSString *str=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//        NSDictionary   *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSRange range = NSMakeRange(12,[str length]-14);
        NSString * subStr= [str substringWithRange: range];
        NSData *jsonData = [subStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *strDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:nil];
        NSDictionary * leftDic=strDict[@"data"];
        
        NSArray *left=leftDic[@"topCate"];
        NSString * headerImageUrl = leftDic[@"banner"];
        [_headerImageView sd_setImageWithURL:[NSURL URLWithString:headerImageUrl]];
        _leftItemArr = [LBLeftTableViewItem mj_objectArrayWithKeyValuesArray:left];
        _leftItemName=[NSMutableArray new];
        _leftItemType=[NSMutableArray new];
        _leftItemId = [NSMutableArray new];
        for (LBLeftTableViewItem *leftItem in _leftItemArr) {
            [_leftItemName addObject:leftItem.name];
            [_leftItemType addObject:leftItem.type];
            [_leftItemId addObject:leftItem.id];
            
//            NSLog(@"%@",leftItem.name);
//            NSLog(@"%@",leftItem.type);
//            NSLog(@"%@",leftItem.id);
        }
        
//        NSLog(@"leftItemName %@",_leftItemName);
//          NSLog(@"leftItemType %@",_leftItemType);
//          NSLog(@"leftItemId %@",_leftItemId);
         [self.tableView reloadData];
        
        
   //下面这段collectionView数据处理tableView的点击事件中的是一样的
        NSArray *rightArr=leftDic[@"list"];
        _rightItemArr=[LBRightCollectionListData mj_objectArrayWithKeyValuesArray:rightArr];
        _headerItem =[NSMutableArray new];
        _headerName =[NSMutableArray new];
        _rightAllItem = [NSMutableArray new];
        for (LBRightCollectionListData *data in _rightItemArr) {
            LBRightHeaderItem *headerItem= data.current;
            NSMutableArray *collectionItemArr = data.subcate;
            [_headerItem addObject:headerItem];
//            _rightSectionItem=[LBRightCollectionViewItem mj_objectArrayWithKeyValuesArray:collectionItemArr];
            _rightItem = [LBRightCollectionViewItem mj_objectArrayWithKeyValuesArray:collectionItemArr];
            [_headerName addObject:headerItem.name];
//            [_rightAllItem addObject:_rightSectionItem];
            [_rightAllItem addObject:_rightItem];
            
        }
        _rightName=[NSMutableArray new];
        _rightImageUrl=[NSMutableArray new];
        for (LBRightCollectionViewItem *sectionItem in _rightItem) {
            [_rightName addObject:sectionItem.name];
            [_rightImageUrl addObject:sectionItem.thumb];
        }
        
        
        [self.collectionView reloadData];
        //默认选择第一行（注意一定要在加载完数据之后）
          [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error %@",error.description);
    }];
}
#pragma mark--<UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return _leftItemName.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:LeftTableViewCellID forIndexPath:indexPath];
    cell.titleItem=_leftItemArr[indexPath.row];
    cell.titleLabel.text = _leftItemName[indexPath.row];
    return cell;
}
#pragma mark -- <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval= 10.0f;
    NSDictionary *dict=@{@"id":_leftItemId[indexPath.row],@"type":_leftItemType[indexPath.row],@"datatype":@"json"};
    NSLog(@"dict %@",dict);
    
    [manager POST:LBClassifySelectData parameters:dict  progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary   *dict =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"collection -- %@",dict);
        NSDictionary * rightDic=dict[@"data"];
        NSArray *rightArr=rightDic[@"list"];
        _rightItemArr=[LBRightCollectionListData mj_objectArrayWithKeyValuesArray:rightArr];
        _headerItem =[NSMutableArray new];
        _headerName =[NSMutableArray new];
        _rightAllItem = [NSMutableArray new];
        for (LBRightCollectionListData *data in _rightItemArr) {
            LBRightHeaderItem *headerItem= data.current;
            NSMutableArray *collectionItemArr = data.subcate;
//            _rightSectionItem=[LBRightCollectionViewItem mj_objectArrayWithKeyValuesArray:collectionItemArr];
            _rightItem = [LBRightCollectionViewItem mj_objectArrayWithKeyValuesArray:collectionItemArr];
            [_headerItem addObject:headerItem];
            [_headerName addObject:headerItem.name];
//            NSLog(@"headerItem.name %@",headerItem.name);
//            NSLog(@" collectionItemArr %@" ,collectionItemArr);
//            NSLog(@"rightSectionItem %@",_rightSectionItem);
            [_rightAllItem addObject:_rightItem];
        }
        _rightName=[NSMutableArray new];
        _rightImageUrl=[NSMutableArray new];
//        NSLog(@"_rightSectionItem  %@",_rightSectionItem);
        for (LBRightCollectionViewItem *sectionItem in _rightItem) {
            [_rightName addObject:sectionItem.name];
            [_rightImageUrl addObject:sectionItem.thumb];
        }
//        NSLog(@"rightName--%@",_rightName);
//        NSLog(@"_rightImageUrl%@",_rightImageUrl);
//        NSLog(@"rightArr %@",_rightItemArr);
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          NSLog(@"collectionError %@",error.description);
    }];
    
    
    
}
#pragma mark -- <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _rightItemArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    

    //    _rightSectionItem=_rightAllItem[section];//找出这组的数据数组
    _rightItem = _rightAllItem[section];
    
//    return  _rightSectionItem.count;
    return _rightItem.count;
    
}
#pragma mark -- <UICollectionViewDelegate>
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *goodsCell=nil;
    LBRightCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:LBRightCollectionViewCellID forIndexPath:indexPath];
    _rightItem = _rightAllItem[indexPath.section];
    
//    cell.rightItem = _rightAllItem[indexPath.section][indexPath.row];
    cell.rightItem=  _rightItem[indexPath.row];
    
    
    
    goodsCell = cell;
    return goodsCell;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        LBCollectionHeaderView *headerView =[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:LBCollectionHeaderViewID forIndexPath:indexPath];
        headerView.headTitle = _headerItem[indexPath.section];
        reusableView = headerView;
    }
    return reusableView;
}
#pragma mark -- 设置宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((ScreenW - ScreenW/4 - 16)/3, (ScreenW - ScreenW/4 - 16)/3 + 20);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(ScreenW, 25);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了个第%zd分组第%zd个Item",indexPath.section+1,indexPath.row+1);
    LBGoodsSetViewController *goodsSet = [[LBGoodsSetViewController alloc]init];
     [self.navigationController pushViewController:goodsSet animated:YES];
    _rightItem = _rightAllItem[indexPath.section];
    _collectionItem =  _rightItem[indexPath.row];
    LBRightCollectionViewItem *item = _rightItem[indexPath.row];
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *path=[docPath stringByAppendingPathComponent:@"LBRightCollectionViewItem.archiver"];
//    NSLog(@"LBRightCollectionViewItem  path=%@",path);
    BOOL success=[NSKeyedArchiver archiveRootObject:item toFile:path];
    if (success) {
        NSLog(  @"LBRightCollectionViewItem 归档成功");
    }

   NSLog(@"id --%@ name--%@ attribute --%@ parentid --%@  target-- %@ type--%@ merchid--%@ ",_collectionItem.id,_collectionItem.name,_collectionItem.attributes,_collectionItem.parentid,_collectionItem.targetcate,_collectionItem.type,_collectionItem.merchid);
    NSLog(@"filters %@",[LBRightCollectionViewItem shareInstance].type);
    
    
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
