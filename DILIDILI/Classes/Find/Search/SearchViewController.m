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
#import "DetailViewController.h"

@interface SearchViewController () <UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) UILabel * label;

@property (nonatomic) UITableView * tableView;

@property (nonatomic) NSMutableArray * dataSource;

@property (nonatomic) NSString * searchString;

@property (nonatomic) NSInteger count;

@property (nonatomic) DetailViewController * detailVC;

@end

@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTableViewOffset:) name:@"ChangeTableViewOffset" object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToDetailViewController:) name:@"AnimationsEnd" object:nil];

    [self createSearchView];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void) createSearchView
{
    UISearchBar * searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 20, SW, 44)];
    
    searchBar.placeholder = @"帮你快速找到往期视频";
    
    searchBar.delegate = self;
    
    [self.view addSubview:searchBar];
    
    
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, searchBar.frame.origin.y + searchBar.frame.size.height + SH*0.01, SW, 20)];
    
    _label.textAlignment = NSTextAlignmentCenter;
    
    _label.text = @"输入标题或描述中的关键词找到往期视频";
    
    _label.font = [UIFont systemFontOfSize:15];
    
    _label.textColor = [UIColor grayColor];
    
    [self.view addSubview:_label];
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
-(void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //textfield的第一响应者状态就会取消，然后键盘就消失了
    //结束搜索状态
    [searchBar resignFirstResponder];
    
//    CATransition *transition = [CATransition animation];
//    transition.duration = 0;
//    transition.type = kCATransitionMoveIn;
//    transition.subtype = kCATransitionFromBottom;
//    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    
    [self.navigationController popViewControllerAnimated:NO];
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
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SW, SH - 64)];
    
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
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SW, 40)];
    
    label.text = [NSString stringWithFormat:@"-「%@」搜索结果共%ld个-",self.searchString,self.count];
    
    label.backgroundColor = [UIColor whiteColor];
    
    label.textColor = [UIColor blackColor];

    label.font = [UIFont systemFontOfSize:15];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击cell");
    
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
    
    [_tableView setContentOffset:CGPointMake(0, xoffset * SW * 387 / 620)];
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
        
        [self.view addSubview:label];
    }
}


- (void) pushToDetailViewController:(NSNotification *)info
{
    NSLog(@"%@",info.object);
    
    _detailVC = [[DetailViewController alloc] init];
    
    _detailVC.indexPath = info.object[@"indexPath"];
    
    _detailVC.dataSource = info.object[@"dataSource"];
    
    NSLog(@"%@",_detailVC.indexPath);
    
    [self addChildViewController:_detailVC];
#warning 不可不要的NSLog
    NSLog(@"%@",_detailVC.view.subviews);
    
    NSLog(@"%@",_detailVC.rootView);
    
    [self.view addSubview:_detailVC.rootView];
    
    [self.view bringSubviewToFront:_detailVC.rootView];
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
