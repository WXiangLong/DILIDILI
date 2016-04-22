//
//  DetailCollectionViewCell.h
//  DILIDILI
//
//  Created by LONG on 16/4/22.
//  Copyright © 2016年 LONG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotRankingModel.h"

@interface DetailCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bgImageVIew;

@property (weak, nonatomic) IBOutlet UIImageView *playImageView;


- (void)updateCell:(HotRankingModel *)model tag:(NSInteger)tag;

@end
