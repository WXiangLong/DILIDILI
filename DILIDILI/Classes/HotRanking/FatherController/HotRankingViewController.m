//
//  HotRanking ViewController.m
//  DiLiDiLi
//
//  Created by qianfeng on 16/3/28.
//  Copyright © 2016年 BJ. All rights reserved.
//

#import "HotRankingViewController.h"
#import "WeeklySortViewController.h"
#import "MonthlySortViewController.h"
#import "HistorySortViewController.h"
#import "DetailViewController.h"

@interface HotRankingViewController () <UIScrollViewDelegate>

@property (nonatomic) NSMutableArray * dataSource;

@property (nonatomic) NSMutableArray * buttonArray;

@property (nonatomic) UIView * myView;

@property (nonatomic) UIScrollView * myScrollView;

@property (nonatomic) WeeklySortViewController * weeklyVC;

@property (nonatomic) MonthlySortViewController * monthlyVC;

@property (nonatomic) HistorySortViewController * historyVC;

@property (nonatomic) DetailViewController * detailVC;

@end

@implementation HotRankingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createTopView];
    
    [self createScrollView];
    
    [self addChildViewControllers];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToDetailViewController:) name:@"AnimationsEnd" object:nil];
}

#pragma mark - 标签
- (void) createTopView
{
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SW, 40)];
    
    topView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:topView];
    
    NSArray * buttonTitle = @[@"周排行",@"月排行",@"总排行"];
    
    for (int i = 0; i < 3; i++)
    {
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake((SW/3)*i+30, 3, (SW-150)/3, 34)];
        
        button.tag = 10 + i;
        
        [button setTitle:buttonTitle[i] forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        button.backgroundColor = [UIColor whiteColor];
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_buttonArray addObject:button];
        
        [topView addSubview:button];
    }
    [self createMoveView];
    
    [topView addSubview:_myView];
}
- (void) createMoveView
{
    _myView = [[UIView alloc] initWithFrame:CGRectMake(30, 0, (SW-150)/3, 40)];
    
    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 5, (SW-150)/3, 1)];
    
    view1.backgroundColor = [UIColor grayColor];
    
    UIView * view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 33, (SW-150)/3, 1)];
    
    view2.backgroundColor = [UIColor grayColor];
    
    [_myView addSubview:view1];
    
    [_myView addSubview:view2];
}
#pragma mark - button触发事件
//通过button切换实现下面scrollView 的滚动
- (void) buttonClick:(UIButton *)button
{    
    _myScrollView.contentOffset = CGPointMake(SW * (button.tag - 10), 0);
}

#pragma mark - scrollView
- (void) createScrollView
{
    _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64+40, SW, SH - 64 - 40 - 49)];
    
    _myScrollView.contentSize = CGSizeMake(SW * 3, SH - 64 - 40 - 49);
    
    _myScrollView.delegate = self;
    
    _myScrollView.backgroundColor = [UIColor whiteColor];
    
    _myScrollView.pagingEnabled = YES;

    _myScrollView.showsHorizontalScrollIndicator = NO;
    
    _myScrollView.showsVerticalScrollIndicator = NO;
    
    _myScrollView.scrollsToTop = YES;
    
    _myScrollView.bounces = NO;
    
    _myScrollView.directionalLockEnabled = YES;
    
    [self.view addSubview:_myScrollView];
}

// scrollView滚动触发View的动画
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float x = scrollView.contentOffset.x;
    
    [UIView animateWithDuration:0.1 animations:^{
        
        [_myView setFrame:CGRectMake(30 + x/3,
                                     _myView.frame.origin.y,
                                     _myView.frame.size.width,
                                     _myView.frame.size.height)];
        
    } completion:nil];
}

- (void) addChildViewControllers
{
    self.weeklyVC = [[WeeklySortViewController alloc] init];

    [self.myScrollView addSubview:self.weeklyVC.view.subviews[0]];
    
    
    self.monthlyVC = [[MonthlySortViewController alloc] init];

    [self.myScrollView addSubview:self.monthlyVC.view.subviews[0]];
    
    
    self.historyVC = [[HistorySortViewController alloc] init];
    
    [self.myScrollView addSubview:self.historyVC.view.subviews[0]];
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



- (void)didReceiveMemoryWarning
{
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