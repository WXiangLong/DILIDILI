//
//  FindViewController.m
//  DILIDILI
//
//  Created by LONG on 16/4/21.
//  Copyright © 2016年 LONG. All rights reserved.
//

#import "FindViewController.h"
#import "FindCollectionViewCell.h"
#import "FindNextViewController.h"
#import "SearchViewController.h"
@interface FindViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic) NSArray * imageArray;

@property (nonatomic) NSArray * categaryArray;

@property (nonatomic) NSArray * categaryArray1;

@property (nonatomic) NSArray * categaryIdArray;

@property (nonatomic) UICollectionView * findCollectionView;

@end

@implementation FindViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNav];
    
    [self creatData];
    
    [self CreateCollectionView];
}
#pragma mark - 设置导航条
- (void) setNav
{
    UIButton * searchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    
    [searchButton setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    
    [searchButton addTarget:self action:@selector(clickSearchButton) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:searchButton];
}
// 点击搜索按钮调用的方法
- (void) clickSearchButton
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromBottom;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    
    SearchViewController * searchVC = [[SearchViewController alloc] init];
    
    [self.navigationController pushViewController:searchVC animated:NO];
}

#pragma mark - 创建数据源
- (void) creatData
{
    _imageArray = @[@"11.jpeg",@"12.jpeg",@"13.jpeg",@"14.jpeg",@"15.jpeg",@"16.jpeg",@"17.jpeg",@"18.jpeg",@"19.jpeg",@"20.jpeg",@"21.jpeg",@"22.jpeg"];
    
    _categaryArray = @[@"Fashion",@"Sports",@"Travel",@"Opera",@"animation",@"AD",@"Miusic",@"Haw",@"Advance",@"Sum",@"Notes",@"Idea"];
    
    _categaryArray1 = @[@"时尚",@"运动",@"旅行",@"剧情",@"动画",@"广告",@"音乐",@"开胃",@"预告",@"综合",@"记录",@"创意"];
    
    _categaryIdArray = @[@"24",@"18",@"6",@"12",@"10",@"14",@"20",@"4",@"8",@"16",@"22",@"2"];
}
#pragma mark - 创建collectionView
- (void)CreateCollectionView
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    layout.minimumInteritemSpacing = 3;
    
    layout.minimumLineSpacing = 3;
    
    layout.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3);
    
    layout.itemSize = CGSizeMake(SW/2 - 5, SW/2 - 5);
    /******************/
    _findCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SW, SH - 64 -49) collectionViewLayout:layout];
    
    _findCollectionView.backgroundColor = [UIColor whiteColor];
    
    _findCollectionView.dataSource = self;
    
    _findCollectionView.delegate = self;
    
    _findCollectionView.showsVerticalScrollIndicator = NO;
    
    [_findCollectionView registerNib:[UINib nibWithNibName:@"FindCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellId"];
    
    [self.view addSubview:_findCollectionView];
}

#pragma mark -- UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageArray.count;
}
//  设置cell
- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FindCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    [cell updateCollectionViewCellWith:_imageArray[indexPath.row] categary:_categaryArray[indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FindNextViewController * FindNextVC = [[FindNextViewController alloc] init];
    
    FindNextVC.categaryId = _categaryIdArray[indexPath.row];
    
    FindNextVC.navTitle = _categaryArray1[indexPath.row];
    
    [self.navigationController pushViewController:FindNextVC animated:YES];
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
