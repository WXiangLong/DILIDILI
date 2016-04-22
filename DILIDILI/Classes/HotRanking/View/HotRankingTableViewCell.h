//
//  HotRankingTableViewCell.h
//  DiLiDiLi
//
//  Created by LONG on 16/3/30.
//  Copyright © 2016年 BJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotRankingModel.h"
@interface HotRankingTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

- (void) updateWithSource:(NSMutableArray *)array :(NSIndexPath *)indexPath;

@end
