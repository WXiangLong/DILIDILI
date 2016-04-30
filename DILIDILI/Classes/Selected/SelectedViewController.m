//
//  SelectedViewController.m
//  DILIDILI
//
//  Created by LONG on 16/4/21.
//  Copyright © 2016年 LONG. All rights reserved.
//

#import "SelectedViewController.h"
#import "NetDataEngine.h"
#import "SelectedModel.h"
#import "HotRankingTableViewCell.h"
#import "TempViewController.h"
#import "DetailViewController.h"
#import "EGOCache.h"
#import "JHRefresh.h"

@interface SelectedViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) NSMutableArray * dataSource;

@property (nonatomic) id object;;

@property (nonatomic) UITableView * tableView;

@property (nonatomic) DetailViewController * detailVC;

@property (nonatomic) NSString * url;

@property (nonatomic) NSInteger count;

@property (nonatomic) BOOL isRefresh;

@end

@implementation SelectedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _count = 2;
    
    [self createTableView];
    
    [self createRefreshHeaderView];
    
    [self createRefreshFootView];
    
    _url = [NSString stringWithFormat:dayChose,_count];
    
    [self fetchData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToDetailViewController:) name:@"AnimationsEnd" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTableViewOffset:) name:@"ChangeTableViewOffset" object:nil];
}

#pragma mark - tableView
- (void) createTableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SW, SH - 49 - 64)];
        
        _tableView.delegate = self;
        
        _tableView.dataSource = self;
        
        _tableView.separatorStyle = NO;
        
        _tableView.scrollsToTop = YES;
        
        _tableView.showsVerticalScrollIndicator = NO;
        
        [self.view addSubview:_tableView];
    }
}

#pragma mark - tableView dataSource And delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotRankingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HotRankingTableViewCell" owner:self options:nil] lastObject];
    }
    
    [cell updateWithSource:self.dataSource :indexPath];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SW * 387 / 620;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HiddenLeftButton" object:nil];
    
    HotRankingTableViewCell *cell = (HotRankingTableViewCell *)[self.tableView cellForRowAtIndexPath: indexPath];
    
    CGRect rect = [cell convertRect:cell.bgImageView.frame toView:self.view];
    
    HotRankingModel * tempModel = _dataSource[indexPath.row];
    
    TempViewController * tempVC = [[TempViewController alloc] init];
    
    [tempVC createImageView:1];
    
    [tempVC createBottomImageView:tempModel rect:rect indexPath:indexPath dataSource:_dataSource];
    
    [tempVC createTopImageView:tempModel rect:rect];
}

#pragma mark - 获取数据
- (void) fetchData
{
    if ([[EGOCache globalCache] hasCacheForKey:@"daychose"] && _count == 2)
    {
        id cacheData = [[EGOCache globalCache] objectForKey:@"daychose"];
        
        self.dataSource = [SelectedModel parseData:cacheData];
        
        _object = cacheData;
        
        [_tableView reloadData];
        
        [self endRefreshing];
    }
    else
    {
        [[NetDataEngine sharedInstance] requestAppHome:_url success:^(id respondObject) {
            
            if (_count == 2)
            {
                [[EGOCache globalCache] setObject:respondObject forKey:@"daychose"];
            }
            self.dataSource = [SelectedModel parseData:respondObject];
            
            [_tableView reloadData];
            
            [self endRefreshing];
            
        } falied:^(NSError *error) {
            
        }];
    }
}

#pragma mark - 下拉刷新
- (void) createRefreshHeaderView
{
    __weak typeof(self) weakSelf = self;
    
    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        
        if (weakSelf.isRefresh)
        {
            return ;
        }
        weakSelf.isRefresh = YES;
        
        weakSelf.count = 2;
        
        weakSelf.url = [NSString stringWithFormat:dayChose,weakSelf.count];
        
        [weakSelf fetchData];
    }];
}
#pragma mark - 上拉加载
- (void) createRefreshFootView
{
    __weak typeof(self) weakSelf = self;
    
    [self.tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        
        if (weakSelf.isRefresh)
        {
            return ;
        }
        weakSelf.isRefresh = YES;
        
        weakSelf.count = weakSelf.count + 2;
        
        weakSelf.url = [NSString stringWithFormat:dayChose,weakSelf.count];
        
        [weakSelf fetchData];
        
    }];
}
#pragma mark - 结束刷新
- (void) endRefreshing
{
    self.isRefresh = NO;
    
    [self.tableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
    
    [self.tableView footerEndRefreshing];
}



- (void) pushToDetailViewController:(NSNotification *)info
{
    _detailVC = [[DetailViewController alloc] init];
    
    _detailVC.indexPath = info.object[@"indexPath"];
    
    _detailVC.dataSource = info.object[@"dataSource"];
    
    _detailVC.flag = 1;
    
    NSLog(@"%@",_detailVC.indexPath);
    
    [self addChildViewController:_detailVC];
#warning 不可不要的NSLog
    NSLog(@"%@",_detailVC.view.subviews);
    
    NSLog(@"%@",_detailVC.rootView);
    
    [self.view addSubview:_detailVC.rootView];
    
    [self.view bringSubviewToFront:_detailVC.rootView];
}

- (void) changeTableViewOffset:(NSNotification *)info
{
    float xoffset = [info.object integerValue];
    
    [_tableView setContentOffset:CGPointMake(0, xoffset * SW * 387 / 620)];
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
