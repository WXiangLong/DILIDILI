//
//  DetailViewController.h
//  DILIDILI
//
//  Created by LONG on 16/4/22.
//  Copyright © 2016年 LONG. All rights reserved.
//

#import "BaseViewController.h"

@interface DetailViewController : BaseViewController

@property (nonatomic) UIView * rootView;

@property (nonatomic) NSIndexPath * indexPath;

@property (nonatomic) NSMutableArray * dataSource;

@end
