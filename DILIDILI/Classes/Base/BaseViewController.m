//
//  BaseViewController.m
//  DILIDILI
//
//  Created by LONG on 16/4/21.
//  Copyright © 2016年 LONG. All rights reserved.
//

#import "BaseViewController.h"
#import "CLTopViewController.h"
#import "BottomToolBar.h"
#import "AppDelegate.h"

@interface BaseViewController ()<closeDelegate>
{
    BOOL isRotate;
}

@property (nonatomic, strong) CLTopViewController *vc;

@property (nonatomic, strong) NSArray *array;



@property (nonatomic, strong) UIButton *button;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _array = @[@"SelectedViewController",@"FindViewController",@"HotRankingViewController"];
    
    [self createToolBar];
    
    [self createTitleView];
    
    [self createLeftBarBtnItem];
    
    [self addView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenLeftButton) name:@"HiddenLeftButton" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLeftButton) name:@"ChangeTableViewOffset" object:nil];
    
}

- (void) hiddenLeftButton
{
    self.navigationItem.leftBarButtonItem = nil;
}

- (void) showLeftButton
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_btn];
}

- (void)createLeftBarBtnItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    btn.frame = CGRectMake(0, 0, 30, 30);
    
    self.btn = btn;
    
    [btn setTitle:@"≡" forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:25];
    
    [btn addTarget:self action:@selector(btn1) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)btn1
{
    if (!isRotate)
    {
        [self show];
        
    }
    else
    {
        [self close];
    }
}


- (void)show
{
    isRotate = YES;
    
    [self.vc.view bringSubviewToFront:self.view];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.btn.transform = CGAffineTransformRotate(self.btn.transform, M_PI_2);
        
        self.vc.view.frame = CGRectMake(0, 64, SW, SH-64);
    }];
}

- (void)close
{
    isRotate = NO;
 
    [UIView animateWithDuration:0.5 animations:^{
    
        self.btn.transform = CGAffineTransformIdentity;
        
        self.vc.view.frame = CGRectMake(0, SH*(-1), SW, SH-64);
    }];
}


#pragma mark - closeDelegate 代理
- (void)closeBtnPressed
{
    [self close];
}

- (void)addView
{
    CLTopViewController *vc = [CLTopViewController new];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:vc.view];
    //    [self.view addSubview:vc.view];
    self.vc = vc;
 
    self.vc.delegate =self;
    
    self.vc.view.frame = CGRectMake(0, SH*(-1), SW, SH-64);
    
    [self.view bringSubviewToFront:vc.view];
}

- (void)createTitleView
{
    UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, SW-200, 44)];
    
    lable.text = @"DILIDILI";
    
    lable.textAlignment = NSTextAlignmentCenter;
    
    lable.textColor = [UIColor blackColor];
    
    lable.font = [UIFont fontWithName:@"Lobster 1.4" size:28];
    
    self.navigationItem.titleView = lable;
}


- (void)createToolBar
{
    BottomToolBar *bar = [[BottomToolBar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-49, self.view.frame.size.width, 49) AndTitleList:@[@"每日精选",@"发现更多",@"热门排行"] andBlock:^(NSInteger Num) {
        
        [self configViewController:Num];
    }];
    [self.view addSubview:bar];
}


- (void)configViewController:(NSInteger)num  {
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    
    UIViewController *vc = [[NSClassFromString(_array[num]) alloc] init];
    
    app.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self.view bringSubviewToFront:vc.view];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"click" object:@(num)];
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
