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

@interface DetailViewViewController ()

@end

@implementation DetailViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void) removeView
{
    [_rootView removeFromSuperview];
}

- (void) createCurrentViewModel:(HotRankingModel *)model
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeView) name:@"ChangeTableViewOffset" object:nil];
    
    _rootView = [[UIView alloc] initWithFrame:CGRectMake(0, SH - SH / 2 + 64, SW, SH / 2 + 64)];
    
    _rootView.userInteractionEnabled = NO;

    AppDelegate * app = [UIApplication sharedApplication].delegate;
    
    [app.window.rootViewController.view addSubview:_rootView];
    
    [self createUI:model];
}

- (void) createUI:(HotRankingModel *)model
{
    UIImageView * currentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SW, _rootView.frame.size.height)];
    
    [currentImageView sd_setImageWithURL:model.cover[@"blurred"]];
    
    [_rootView addSubview:currentImageView];
    
    
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _rootView.frame.size.height * 0.03, SW - 20, _rootView.frame.size.height * 0.07)];
    
    titleLabel.font = [UIFont systemFontOfSize:20];
    
    titleLabel.textColor = [UIColor whiteColor];
    
    titleLabel.text = model.title;
    
    [_rootView addSubview:titleLabel];
    
    
    
    CGSize contentSize1 = [self contentSizeOfString:titleLabel.text maxWidth:SW-20 font:[UIFont systemFontOfSize:20]];
    
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(10, titleLabel.frame.origin.y + titleLabel.frame.size.height + _rootView.frame.size.height * 0.03, contentSize1.width * 0.8, 1)];
    
    line.backgroundColor = [UIColor whiteColor];
    
    [_rootView addSubview:line];
    
    
    
    
    UILabel * categryAndTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, line.frame.origin.y + line.frame.size.height + _rootView.frame.size.height * 0.03, SW - 20, _rootView.frame.size.height * 0.05)];
    
    categryAndTimeLabel.font = [UIFont systemFontOfSize:17];
    
    categryAndTimeLabel.textColor = [UIColor whiteColor];
    
    categryAndTimeLabel.text = [NSString stringWithFormat:@"#%@ / %02ld'%02ld''",model.category,model.duration/60,model.duration%60];
    
    [_rootView addSubview:categryAndTimeLabel];
    
    
    
    CGSize contentSize = [self contentSizeOfString:model.myDescription maxWidth:SW-20 font:[UIFont systemFontOfSize:15]];
    
    UILabel * descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, categryAndTimeLabel.frame.origin.y + categryAndTimeLabel.frame.size.height + _rootView.frame.size.height * 0.03, SW - 20, contentSize.height)];
    
    descriptionLabel.font = [UIFont systemFontOfSize:15];
    
    descriptionLabel.textColor = [UIColor whiteColor];
    
    descriptionLabel.numberOfLines = 0;
    
    descriptionLabel.text = model.myDescription;
    
    [_rootView addSubview:descriptionLabel];
#warning 收藏下载
}
// 计算label高度
- (CGSize) contentSizeOfString:(NSString *)content maxWidth:(CGFloat)width font:(UIFont *)font
{
    CGRect rect = [content boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    
    return rect.size;
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
