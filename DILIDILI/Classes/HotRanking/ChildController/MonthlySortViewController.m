//
//  MonthlyViewController.m
//  DiLiDiLi
//
//  Created by LONG on 16/3/29.
//  Copyright © 2016年 BJ. All rights reserved.
//

#import "MonthlySortViewController.h"

@interface MonthlySortViewController ()

@end

@implementation MonthlySortViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.num = 1;
        
    }
    return self;
}

- (NSString *)getUrl
{
    return monthSort;
}
- (NSString *)getCategry
{
    return @"monthsort";
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
