//
//  FindTableViewController.h
//  DILIDILI
//
//  Created by LONG on 16/4/21.
//  Copyright © 2016年 LONG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindTableViewController : UIViewController

@property (nonatomic) NSInteger num;

@property (nonatomic) NSString * url;

@property (nonatomic) UITableView * tableView;

- (void) getUrlWithStart:(NSInteger)start num:(NSInteger)num;

- (NSString *) getCategry;

@end
