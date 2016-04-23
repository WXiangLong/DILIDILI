//
//  FindTableViewController.m
//  DILIDILI
//
//  Created by LONG on 16/4/21.
//  Copyright © 2016年 LONG. All rights reserved.
//

#import "FindTableViewController.h"
#import "HotRankingTableViewCell.h"
#import "HotRankingModel.h"
#import "NetDataEngine.h"
#import "TempViewController.h"
#import "EGOCache.h"
#import "JHRefresh.h"

@interface FindTableViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) NSMutableArray * dataSource;

@property (nonatomic) UITableView * chooseTableView;


@property (nonatomic) NSInteger start;

@property (nonatomic) NSInteger count;

@property (nonatomic) BOOL isRefresh;

@end

@implementation FindTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _start = 0;
    
    _count = 10;
    
    [self createTableView];
    
    [self createRefreshFootView];
    
    [self getUrlWithStart:_start num:_count];
    
    [self fetchData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTableViewOffset:) name:@"ChangeTableViewOffset" object:nil];
}

#pragma mark - tableView
- (void) createTableView
{
    if (_tableView == nil)
    {
        // 需要子类确定frame
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(SW * _num, 0, SW, SH - 64 - 40)];
        
//        _tableView.bounces = NO;
        
        _tableView.delegate = self;
        
        _tableView.dataSource = self;
        
        _tableView.separatorStyle = NO;
        
        _tableView.scrollsToTop = NO;
        
        _tableView.tag = 100 + _num;
        
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
    _chooseTableView = tableView;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HiddenLeftButton" object:nil];
    
    HotRankingTableViewCell *cell = (HotRankingTableViewCell *)[self.tableView cellForRowAtIndexPath: indexPath];
    
    CGRect rect = [cell convertRect:cell.bgImageView.frame toView:self.view];
    
    HotRankingModel * tempModel = _dataSource[indexPath.row];
    
    TempViewController * tempVC = [[TempViewController alloc] init];
    
    [tempVC createImageView:0];
    
    [tempVC createBottomImageView:tempModel rect:rect indexPath:indexPath dataSource:_dataSource];
    
    [tempVC createTopImageView:tempModel rect:rect];
}
- (void) changeTableViewOffset:(NSNotification *)info
{
    float xoffset = [info.object integerValue];
    
    [_chooseTableView setContentOffset:CGPointMake(0, xoffset * SW * 387 / 620)];
    
    _chooseTableView = nil;
}
#pragma mark - 获取数据
- (void) fetchData
{
    NSString * categry = [self getCategry];
    
    if ([[EGOCache globalCache] hasCacheForKey:categry] && _count == 10)
    {
        id cacheData = [[EGOCache globalCache] objectForKey:categry];
        
        self.dataSource = [HotRankingModel parseData:cacheData];
        
        [_tableView reloadData];
        
        [self endRefreshing];
    }
    else
    {
        [[NetDataEngine sharedInstance] requestAppHome:_url success:^(id respondObject) {
            
            if (_count == 10)
            {
                [[EGOCache globalCache] setObject:respondObject forKey:categry];
            }
            self.dataSource = [HotRankingModel parseData:respondObject];
            
            [_tableView reloadData];
            
            [self endRefreshing];
            
        } falied:^(NSError *error) {
            
        }];
    }
}

#pragma mark - 下拉刷新
- (void) createRefreshHeaderView
{
    
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
        
        weakSelf.count = weakSelf.count + 10;
        
        [weakSelf getUrlWithStart:weakSelf.start num:weakSelf.count];
        
        [weakSelf fetchData];
    }];
}
#pragma mark - 结束刷新
- (void) endRefreshing
{
    self.isRefresh = NO;
    
    [self.tableView footerEndRefreshing];
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
