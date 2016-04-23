//
//  WeeklySortViewController.m
//  DiLiDiLi
//
//  Created by LONG on 16/3/29.
//  Copyright © 2016年 BJ. All rights reserved.
//

#import "WeeklySortViewController.h"

@interface WeeklySortViewController ()

@end

@implementation WeeklySortViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.num = 0;
    }
    return self;
}

- (NSString *)getUrl
{
    return weekSort;
}
- (NSString *)getCategry
{
    return @"weeksort";
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
