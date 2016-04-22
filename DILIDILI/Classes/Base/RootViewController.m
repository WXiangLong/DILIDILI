//
//  RootViewController.m
//  DILIDILI
//
//  Created by LONG on 16/4/21.
//  Copyright © 2016年 LONG. All rights reserved.
//

#import "RootViewController.h"
#import "AppDelegate.h"
#import "SelectedViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LaunchImage-700"]];
    
    image.frame = self.view.frame;
    
    [self.view addSubview:image];
    
    // 启动页缩放动画
    [UIView animateWithDuration:1. animations:^{
        
        image.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1 animations:^{
            
            image.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
            AppDelegate *app = [UIApplication sharedApplication].delegate;
            
            app.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[SelectedViewController alloc] init]];
            
        }];
        
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
