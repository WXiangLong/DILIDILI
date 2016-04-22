//
//  TempViewController.h
//  DiLiDiLi
//
//  Created by LONG on 16/4/4.
//  Copyright © 2016年 BJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotRankingModel.h"
#import "SelectedModel.h"
@interface TempViewController : UIViewController


- (void) createImageView;

- (void) createTopImageView:(HotRankingModel *)model rect:(CGRect)rect;

- (void) createBottomImageView:(HotRankingModel *)model rect:(CGRect)rect indexPath:(NSIndexPath *)indexPath dataSource:(NSMutableArray *)dataSource;

- (void) removeTopImageView:(HotRankingModel *)model;

- (void) removeBottomImageView:(HotRankingModel *)model;

@end
