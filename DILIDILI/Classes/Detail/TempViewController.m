//
//  TempViewController.m
//  DiLiDiLi
//
//  Created by LONG on 16/4/4.
//  Copyright © 2016年 BJ. All rights reserved.
//

#import "TempViewController.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"

@interface TempViewController ()

@property (nonatomic) UIImageView * topImageView;

@property (nonatomic) UIImageView * bottomImageView;

@property (nonatomic) UIView * rootView;


@property (nonatomic) int flag;

@property (nonatomic) CGRect rect;


@end

@implementation TempViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) createImageView:(int)flag
{
    _rootView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SW, SH - 64)];
    
    _rootView.clipsToBounds = YES;
    
    AppDelegate * app = [UIApplication sharedApplication].delegate;
    
    [app.window.rootViewController.view addSubview:_rootView];
    
    _flag = flag;
    if (flag == 1)
    {
        _rect = CGRectMake(0, 0, SW, SW * 387 / 620);
    }
    else
    {
        _rect = CGRectMake(0, 40, SW, SW * 387 / 620);
    }
}



- (void) createTopImageView:(HotRankingModel *)model rect:(CGRect)rect
{
    _topImageView = [[UIImageView alloc] initWithFrame:rect];
    
    [_topImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.cover[@"detail"]]]];
    
    _topImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [_rootView addSubview:_topImageView];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [_topImageView setFrame:CGRectMake(0, 0, SW, SH/2)];
        
    } completion:nil];
}

- (void) createBottomImageView:(HotRankingModel *)model rect:(CGRect)rect indexPath:(NSIndexPath *)indexPath dataSource:(NSMutableArray *)dataSource
{
    _bottomImageView = [[UIImageView alloc] initWithFrame:rect];
    
    [_bottomImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.cover[@"blurred"]]]];
    
    _bottomImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [_rootView addSubview:_bottomImageView];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [_bottomImageView setFrame:CGRectMake(0, _topImageView.frame.size.height, SW, _rootView.frame.size.height - _topImageView.frame.size.height)];
        
    } completion:^(BOOL finished) {
        
        [self.rootView removeFromSuperview];
    
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AnimationsEnd" object:@{@"indexPath":indexPath,@"dataSource":dataSource}];
    }];
}

- (void) removeTopImageView:(HotRankingModel *)model
{
    _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SW, SH/2)];
    
    [_topImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.cover[@"detail"]]]];
    
    _topImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [_rootView addSubview:_topImageView];
    
    [UIView animateWithDuration:0.5 animations:^{
        
            [_topImageView setFrame:_rect];
        
    } completion:nil];
}

- (void) removeBottomImageView:(HotRankingModel *)model
{
    _bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _topImageView.frame.size.height, SW, _rootView.frame.size.height - _topImageView.frame.size.height)];
    
    [_bottomImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.cover[@"blurred"]]]];
    
    _bottomImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [_rootView addSubview:_bottomImageView];
    
    [UIView animateWithDuration:0.5 animations:^{
        
            [_bottomImageView setFrame:_rect];
        
    } completion:^(BOOL finished) {
        [_rootView removeFromSuperview];
    }];
}

//- (void) removeFirstTopImageView:(HotRankingModel *)model
//{
//    _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SW, SH/2)];
//    
//    [_topImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.cover[@"detail"]]]];
//    
//    _topImageView.contentMode = UIViewContentModeScaleAspectFill;
//    
//    [_rootView addSubview:_topImageView];
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        
//        [_topImageView setFrame:CGRectMake(0, 0, SW, SW * 387 / 620)];
//        
//    } completion:nil];
//}
//
//- (void) removeFirstBottomImageView:(HotRankingModel *)model
//{
//    _bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _topImageView.frame.size.height, SW, _rootView.frame.size.height - _topImageView.frame.size.height)];
//    
//    [_bottomImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.cover[@"blurred"]]]];
//    
//    _bottomImageView.contentMode = UIViewContentModeScaleAspectFill;
//    
//    [_rootView addSubview:_bottomImageView];
//    
//    [UIView animateWithDuration:0.5 animations:^{
//        
//        [_bottomImageView setFrame:CGRectMake(0, 0, SW, SW * 387 / 620)];
//        
//    } completion:^(BOOL finished) {
//        [_rootView removeFromSuperview];
//    }];
//}

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
