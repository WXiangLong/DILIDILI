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

@interface SelectedViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) NSMutableArray * dataSource;

@property (nonatomic) UITableView * tableView;

@property (nonatomic) DetailViewController * detailVC;

@end

@implementation SelectedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createTableView];
    
    [self fetchData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToDetailViewController:) name:@"AnimationsEnd" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTableViewOffset:) name:@"ChangeTableViewOffset" object:nil];
}

#pragma mark - tableView
- (void) createTableView
{
    if (_tableView == nil)
    {
        // 需要子类确定frame
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SW, SH - 49 - 64)];
        
        _tableView.bounces = NO;
        
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
    NSLog(@"点击cell");
    
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
    NSString * url = dayChose;
    
    [[NetDataEngine sharedInstance] requestAppHome:url success:^(id respondObject) {
        
        self.dataSource = [SelectedModel parseData:respondObject];
        
        [_tableView reloadData];
        
    } falied:^(NSError *error) {
        
    }];
    
}

- (void) pushToDetailViewController:(NSNotification *)info
{
    NSLog(@"%@",info.object);
    
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
