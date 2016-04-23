//
//  DetailViewController.m
//  DILIDILI
//
//  Created by LONG on 16/4/22.
//  Copyright © 2016年 LONG. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailCollectionViewCell.h"
#import "TempViewController.h"
#import "MoviePlayerViewController.h"
#import "DetailViewViewController.h"
#import "HotRankingModel.h"

@interface DetailViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic) UICollectionView * myCollectionView;

@property (nonatomic) UICollectionView * topCollectionView;

@property (nonatomic) UICollectionView * bottomCollectionView;

@property (nonatomic) MoviePlayerViewController *mpVC;

@property (nonatomic) DetailViewViewController * detailVVC;

// 开始时x的偏移量
@property (nonatomic) float oldX;
// 滚动时x的偏移量
@property (nonatomic) float newX;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}

- (void) createUI
{
    _rootView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SW, SH - 64)];
    
    _rootView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_rootView];
    
    [self createTopCollectionView:_indexPath];
    
    _detailVVC = [[DetailViewViewController alloc] init];
    
    HotRankingModel * model = _dataSource[_indexPath.row];
    
    [_detailVVC createNextViewModel:model];
    
    [_detailVVC createCurrentViewModel:model];
}

- (void) createTopCollectionView:(NSIndexPath *)indexPath
{
    for (int i = 0; i < 2; i++)
    {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.minimumLineSpacing = 0;
        
        layout.minimumInteritemSpacing = 0;
        
        layout.itemSize = CGSizeMake(SW, SH/2);
        
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, SH / 2 * i, SW, SH/2) collectionViewLayout:layout];
        
        _myCollectionView.delegate = self;
        
        _myCollectionView.dataSource = self;
        
        _myCollectionView.bounces = NO;
        
        _myCollectionView.tag = 100 + i;
        
        _myCollectionView.showsHorizontalScrollIndicator = NO;
        
        _myCollectionView.pagingEnabled = YES;
        
        [_myCollectionView setContentOffset:CGPointMake(indexPath.row * SW, 0)];
        
        _myCollectionView.backgroundColor = [UIColor whiteColor];
        
        [_myCollectionView registerNib:[UINib nibWithNibName:@"DetailCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellId"];
        
        [_rootView addSubview:_myCollectionView];
    }
    _bottomCollectionView = [self.view viewWithTag:101];
    
    _topCollectionView = [self.view viewWithTag:100];
}
#pragma mark - collection delegate And dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HotRankingModel * model = self.dataSource[indexPath.row];
    
    DetailCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];

    if (collectionView.tag == 101)
    {
        UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
        
        swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
        
        [cell.bgImageVIew addGestureRecognizer:swipeUp];
    }
    cell.bgImageVIew.userInteractionEnabled = YES;
    
    [cell updateCell:model tag:collectionView.tag];
    
    return cell;
}

// 点击collectionViewCell调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _topCollectionView)
    {
        HotRankingModel * model = self.dataSource[indexPath.row];
        
        _mpVC = [[MoviePlayerViewController alloc] init];
        
        _mpVC.playUrl = [model.playInfo lastObject][@"url"];
        
        [self presentViewController:_mpVC animated:YES completion:nil];
    }
}
// 行将要出现时调用
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    HotRankingModel * model = self.dataSource[indexPath.row];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"willDisplayCell" object:model];
}
// 开始滚动时调用的方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _oldX = _topCollectionView.contentOffset.x;
}
// 滚动时调用的方法
// 实现上下两个collectionView的联动
- (void)scrollViewDidScroll:(UIScrollView *)collectionView
{
    _newX = _topCollectionView.contentOffset.x;
    
    // 滚动，发送通知，改变透明度
    [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollBegan" object:@{@"oldX":@(_oldX),@"newX":@(_newX)}];
    
    if (collectionView.tag == 101)
    {
        _topCollectionView.contentOffset = collectionView.contentOffset;
    }
    else
    {
        _bottomCollectionView.contentOffset = collectionView.contentOffset;
    }
}
// 滚动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_topCollectionView.contentOffset.x != _oldX)
    {
        int page = (_topCollectionView.contentOffset.x)/SW;
        
        HotRankingModel * model = self.dataSource[page];
        // 滚动结束，发送通知，改变UI
        [[NSNotificationCenter defaultCenter] postNotificationName:@"scrollEnd" object:model];
    }
}
#pragma 上滑手势
- (void) swipe:(UISwipeGestureRecognizer *)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionUp)
    {
        [_rootView removeFromSuperview];
        
        NSInteger page = _bottomCollectionView.contentOffset.x/SW;
        
        HotRankingModel * tempModel = _dataSource[page];
        
        TempViewController * tempVC = [[TempViewController alloc] init];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeTableViewOffset" object:@(page)];
        
        [tempVC createImageView:_flag];
        
        [tempVC removeBottomImageView:tempModel];
        
        [tempVC removeTopImageView:tempModel];
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
