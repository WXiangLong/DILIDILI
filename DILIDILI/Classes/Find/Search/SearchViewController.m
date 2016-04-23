//
//  SearchViewController.m
//  DILIDILI
//
//  Created by LONG on 16/4/21.
//  Copyright © 2016年 LONG. All rights reserved.
//

#import "SearchViewController.h"
#import "NetDataEngine.h"
#import "HotRankingTableViewCell.h"
#import "HotRankingModel.h"
#import "TempViewController.h"

@interface SearchViewController () <UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UILabel * label;

@property (nonatomic) UIView * searchView;

@property (nonatomic) UITableView * tableView;

@property (nonatomic) NSMutableArray * dataSource;

@property (nonatomic) NSString * searchString;

@property (nonatomic) NSInteger count;

@property (nonatomic) UITableView * chooseTableView;

@end

@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.backgroundColor = [UIColor blueColor];
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self createSearchView];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _searchView.frame = CGRectMake(0, 0, SW, SH);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTableViewOffset:) name:@"ChangeTableViewOffset" object:nil];

}

- (void) createSearchView
{
    _searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SW, SH)];
    
    _searchView.backgroundColor = [UIColor whiteColor];
    
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SW, 44)];
    
    UISearchBar * searchBar= [[UISearchBar alloc]initWithFrame:searchView.frame];
    
    searchBar.placeholder = @"帮你快速找到往期视频";
    
    searchBar.delegate = self;
    
    [searchView addSubview:searchBar];
    
    [self.navigationController.navigationBar addSubview:searchView];
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SW, 20)];
    
    _label.textAlignment = NSTextAlignmentCenter;
    
    _label.text = @"输入标题或描述中的关键词找到往期视频";
    
    _label.font = [UIFont systemFontOfSize:15];
    
    _label.textColor = [UIColor grayColor];
    
    [_searchView addSubview:_label];
    
    [self.view addSubview:_searchView];
}
//让按钮显示
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    
    return YES;
}
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    
    return YES;
}
// 点击cancel 按钮调用的方法
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //textfield的第一响应者状态就会取消，然后键盘就消失了
    //结束搜索状态
    [searchBar resignFirstResponder];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 执行搜索 时的方法
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    self.searchString = searchBar.text;
    
    [self fetchData];
}

#pragma mark - tableView
- (void) createTableView
{
    if (_tableView != nil)
    {
        [_tableView removeFromSuperview];
    }
    // 需要子类确定frame
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SW, SH - 64)];
    
    _tableView.bounces = NO;
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    _tableView.separatorStyle = NO;
    
    _tableView.scrollsToTop = NO;
    
    _tableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_tableView];
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SW, 44)];
    
    label.text = [NSString stringWithFormat:@"-「%@」搜索结果共%ld个-",self.searchString,self.count];
    
    label.backgroundColor = [UIColor whiteColor];
    
    label.textColor = [UIColor blackColor];

    label.font = [UIFont systemFontOfSize:15];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击cell");
    
    _chooseTableView = tableView;
    
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
    NSString * url = [NSString stringWithFormat:Search,self.searchString];
    
    [[NetDataEngine sharedInstance] requestAppHome:url success:^(id respondObject) {
        
        self.count = [respondObject[@"total"] integerValue];
        
        if ([respondObject[@"count"] integerValue] == 0)
        {
            if (_tableView != nil)
            {
                [_tableView removeFromSuperview];
            }
            
            [self createLabel];
        }
        else
        {
            [self createTableView];
            
            self.dataSource = [HotRankingModel parseData:respondObject];
            
            [_tableView reloadData];
        }

    } falied:^(NSError *error) {
        
    }];
}

- (void) createLabel
{
    self.label.alpha = 0;
    
    for (int i = 0; i < 2; i++)
    {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, SH / 4, SW, 20)];
        
        label.text = @"很抱歉没有找到相匹配的内容";
        
        label.textColor = [UIColor blackColor];
        
        if (i == 1)
        {
            label.frame = CGRectMake(0, SH / 4 + 20, SW, 50);
            
            label.text = @"可以通过所属分类，\n以及标题或描述中的关键字来查找";
            
            label.textColor = [UIColor grayColor];
        }
        label.font = [UIFont systemFontOfSize:15];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.numberOfLines = 0;
        
        [_searchView addSubview:label];
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
