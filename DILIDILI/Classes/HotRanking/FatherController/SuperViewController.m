//
//  SuperViewController.m
//  DiLiDiLi
//
//  Created by LONG on 16/3/29.
//  Copyright © 2016年 BJ. All rights reserved.
//

#import "SuperViewController.h"
#import "NetDataEngine.h"
#import "HotRankingTableViewCell.h"
#import "TempViewController.h"


@interface SuperViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) NSMutableArray * dataSource;

@property (nonatomic) UITableView * tableView;

@property (nonatomic) UITableView * chooseTableView;

@end

@implementation SuperViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createTableView];
    
    [self fetchData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTableViewOffset:) name:@"ChangeTableViewOffset" object:nil];
}

#pragma mark - tableView
- (void) createTableView
{
    if (_tableView == nil)
    {
        // 需要子类确定frame
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(SW * _num, 0, SW, SH - 64 - 40- 49)];
        
        _tableView.bounces = NO;
        
        _tableView.delegate = self;
        
        _tableView.dataSource = self;
        
        _tableView.separatorStyle = NO;
        
        _tableView.scrollsToTop = NO;
        
        _tableView.tag = 100 + _num;
        
        _tableView.showsVerticalScrollIndicator = NO;
        
        [self.view addSubview:_tableView];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SW, 44)];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.text = @"- The End -";
        
        label.font = [UIFont fontWithName:@"Lobster 1.4" size:17];
        
        _tableView.tableFooterView = label;
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
    
    [tempVC createImageView];
    
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
    NSString * url = [self getUrl];
    
    [[NetDataEngine sharedInstance] requestAppHome:url success:^(id respondObject) {
        
        self.dataSource = [HotRankingModel parseData:respondObject];
        
        [_tableView reloadData];
        
    } falied:^(NSError *error) {
        
    }];

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
