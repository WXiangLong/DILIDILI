//
//  SelectedViewController.m
//  DILIDILI
//
//  Created by LONG on 16/4/21.
//  Copyright © 2016年 LONG. All rights reserved.
//

#import "SelectedViewController.h"
#import "NetDataEngine.h"

@interface SelectedViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) NSMutableArray * dataSource;

@property (nonatomic) UITableView * tableView;

@end

@implementation SelectedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - tableView
- (void) createTableView
{
    if (_tableView == nil)
    {
        // 需要子类确定frame
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SW, SH - 64 - 40- 49)];
        
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
//    HotRankingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
//    
//    if (!cell)
//    {
//        cell = [[[NSBundle mainBundle] loadNibNamed:@"HotRankingTableViewCell" owner:self options:nil] lastObject];
//    }
//    [cell updateWithSource:self.dataSource :indexPath];
//    
//    return cell;
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SW * 387 / 620;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击cell");
}

#pragma mark - 获取数据
- (void) fetchData
{
    NSString * url = dayChose;
    
    [[NetDataEngine sharedInstance] requestAppHome:url success:^(id respondObject) {
        
//        self.dataSource = [HotRankingModel parseData:respondObject];
        
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
