//
//  DetailViewViewController.m
//  DILIDILI
//
//  Created by LONG on 16/4/22.
//  Copyright © 2016年 LONG. All rights reserved.
//

#import "DetailViewViewController.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "HotRankingModel.h"

@interface DetailViewViewController ()

@property (nonatomic) UIImageView * nextImageView;

@property (nonatomic) UIImageView * currentImageView;

@property (nonatomic) UILabel * titleLabel;

@property (nonatomic) UIView * line;

@property (nonatomic) UILabel * categryAndTimeLabel;

@property (nonatomic) UILabel * descriptionLabel;

@end

@implementation DetailViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void) createCurrentViewModel:(HotRankingModel *)model
{
    // 上滑返回，删除view
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeView) name:@"ChangeTableViewOffset" object:nil];
    // 滚动，改变透明度
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeAlpha:) name:@"scrollBegan" object:nil];
    
    // 滚动结束，透明度为1，改变UI
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI:) name:@"scrollEnd" object:nil];
    
    
    
    _rootView = [[UIView alloc] initWithFrame:CGRectMake(0, SH - SH / 2 + 64, SW, SH / 2 + 64)];
    
    _rootView.userInteractionEnabled = NO;

    AppDelegate * app = [UIApplication sharedApplication].delegate;
    
    [app.window.rootViewController.view addSubview:_rootView];
    
    [self createUI:model];
}
- (void) createNextViewModel:(HotRankingModel *)model
{
    // cell将要出现时候改变nextimageView的图片
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNextImageView:) name:@"willDisplayCell" object:nil];
    
    _nextView = [[UIView alloc] initWithFrame:CGRectMake(0, SH - SH / 2 + 64, SW, SH / 2 + 64)];
    
    _nextView.userInteractionEnabled = NO;
    
    AppDelegate * app = [UIApplication sharedApplication].delegate;
    
    [app.window.rootViewController.view addSubview:_nextView];
    
    [self createNextUI:model];
}

- (void) createNextUI:(HotRankingModel *)model
{
    _nextImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SW, _nextView.frame.size.height)];
    
        [_nextImageView sd_setImageWithURL:model.cover[@"blurred"]];
    
    [_nextView addSubview:_nextImageView];
}

- (void) createUI:(HotRankingModel *)model
{
    _currentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SW, _rootView.frame.size.height)];
    
    [_currentImageView sd_setImageWithURL:model.cover[@"blurred"]];
    
    [_rootView addSubview:_currentImageView];
    
    
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _rootView.frame.size.height * 0.03, SW - 20, _rootView.frame.size.height * 0.07)];
    
    _titleLabel.font = [UIFont systemFontOfSize:20];
    
    _titleLabel.textColor = [UIColor whiteColor];
    
    _titleLabel.text = model.title;
    
    [_rootView addSubview:_titleLabel];
    
    
    
    CGSize contentSize1 = [self contentSizeOfString:_titleLabel.text maxWidth:SW-20 font:[UIFont systemFontOfSize:20]];
    
    _line = [[UIView alloc] initWithFrame:CGRectMake(10, _titleLabel.frame.origin.y + _titleLabel.frame.size.height + _rootView.frame.size.height * 0.03, contentSize1.width * 0.8, 1)];
    
    _line.backgroundColor = [UIColor whiteColor];
    
    [_rootView addSubview:_line];
    
    
    
    
    _categryAndTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _line.frame.origin.y + _line.frame.size.height + _rootView.frame.size.height * 0.03, SW - 20, _rootView.frame.size.height * 0.05)];
    
    _categryAndTimeLabel.font = [UIFont systemFontOfSize:17];
    
    _categryAndTimeLabel.textColor = [UIColor whiteColor];
    
    _categryAndTimeLabel.text = [NSString stringWithFormat:@"#%@ / %02ld'%02ld''",model.category,model.duration/60,model.duration%60];
    
    [_rootView addSubview:_categryAndTimeLabel];
    
    
    
    CGSize contentSize = [self contentSizeOfString:model.myDescription maxWidth:SW-20 font:[UIFont systemFontOfSize:15]];
    
    _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _categryAndTimeLabel.frame.origin.y + _categryAndTimeLabel.frame.size.height + _rootView.frame.size.height * 0.03, SW - 20, contentSize.height)];
    
    _descriptionLabel.font = [UIFont systemFontOfSize:15];
    
    _descriptionLabel.textColor = [UIColor whiteColor];
    
    _descriptionLabel.numberOfLines = 0;
    
    _descriptionLabel.text = model.myDescription;
    
    [_rootView addSubview:_descriptionLabel];
#warning 收藏下载
}
// 计算label高度
- (CGSize) contentSizeOfString:(NSString *)content maxWidth:(CGFloat)width font:(UIFont *)font
{
    CGRect rect = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    
    return rect.size;
}

#pragma mark - 通知方法
- (void) removeView
{
    [_rootView removeFromSuperview];
    
    [_nextView removeFromSuperview];
}

- (void) changeAlpha:(NSNotification *)info
{
    float newX = [info.object[@"newX"] floatValue];
    
    float oldX = [info.object[@"oldX"] floatValue];
    
    _rootView.alpha = 1 - fabsf(newX - oldX)/ SW;
}

- (void) changeNextImageView:(NSNotification *)info
{
    HotRankingModel * model = info.object;
    
    [_nextImageView sd_setImageWithURL:model.cover[@"blurred"]];
}

- (void) updateUI:(NSNotification *)info
{
    HotRankingModel * model = info.object;
    
    // 改变imageView的内容
    [_currentImageView sd_setImageWithURL:model.cover[@"blurred"]];
    
    // 改变titleLabel
    _titleLabel.text = model.title;
    
    // 重新计算line的长度
    CGSize contentSize1 = [self contentSizeOfString:model.title maxWidth:SW-20 font:[UIFont systemFontOfSize:20]];
    
    [_line setFrame:CGRectMake(_line.frame.origin.x, _line.frame.origin.y, contentSize1.width*0.8, _line.frame.size.height)];
    
    // 改变第二个label
    _categryAndTimeLabel.text = [NSString stringWithFormat:@"#%@ / %02ld'%02ld''",model.category,model.duration/60,model.duration%60];
    
    // 重新计算第三个label的高度，改变label的内容
    CGSize contentSize = [self contentSizeOfString:model.myDescription maxWidth:SW-20 font:[UIFont systemFontOfSize:15]];
    
    [_descriptionLabel setFrame:CGRectMake(_descriptionLabel.frame.origin.x, _descriptionLabel.frame.origin.y, _descriptionLabel.frame.size.width, contentSize.height)];
    
    _descriptionLabel.text = model.myDescription;
    
    _rootView.alpha = 1;
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
