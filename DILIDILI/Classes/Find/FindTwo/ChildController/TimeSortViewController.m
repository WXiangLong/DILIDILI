//
//  TimeSortViewController.m
//  DILIDILI
//
//  Created by LONG on 16/4/21.
//  Copyright © 2016年 LONG. All rights reserved.
//

#import "TimeSortViewController.h"

@interface TimeSortViewController ()

@end

@implementation TimeSortViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.num = 0;
        
    }
    return self;
}

- (void)getUrlWithStart:(NSInteger)start num:(NSInteger)num
{
    self.url = [NSString stringWithFormat:timeSort,_categaryId,start,num];
}

- (NSString *)getCategry
{
    return [NSString stringWithFormat:@"%@timeSort",_categaryId];
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
