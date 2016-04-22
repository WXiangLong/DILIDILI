//
//  DetailViewViewController.h
//  DILIDILI
//
//  Created by LONG on 16/4/22.
//  Copyright © 2016年 LONG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotRankingModel.h"

@interface DetailViewViewController : UIViewController

@property (nonatomic) UIView * rootView;

@property (nonatomic) UIView * nextView;

- (void) createCurrentViewModel:(HotRankingModel *)model;

- (void) createNextViewModel:(HotRankingModel *)model;

@end
