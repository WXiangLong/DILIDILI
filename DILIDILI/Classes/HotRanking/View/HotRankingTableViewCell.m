//
//  HotRankingTableViewCell.m
//  DiLiDiLi
//
//  Created by LONG on 16/3/30.
//  Copyright © 2016年 BJ. All rights reserved.
//

#import "HotRankingTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface HotRankingTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *myView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *categoryAndTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *indexLabel;

@end

@implementation HotRankingTableViewCell

- (void) updateWithSource:(NSMutableArray *)array :(NSIndexPath *)indexPath
{
    HotRankingModel * model = array[indexPath.row];
    
    [self.bgImageView sd_setImageWithURL:model.cover[@"feed"]];
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@",model.title];
    
    self.categoryAndTimeLabel.text = [NSString stringWithFormat:@"#%@ / %02ld'%02ld''",model.category,[model.duration integerValue]/60,[model.duration integerValue]%60];
    
    self.categoryAndTimeLabel.font = [UIFont fontWithName:@"fzltzchjwgb10" size:15];
    
    self.indexLabel.text = [NSString stringWithFormat:@"%ld.",indexPath.row+1];
    
    self.indexLabel.font = [UIFont fontWithName:@"Lobster 1.4" size:15];
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted)
    {
        [UIView animateWithDuration:0.3 animations:^{
            
            _myView.alpha = 0;
            
        } completion:nil];
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            
            _myView.alpha = 1;
            
        } completion:nil];
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}



@end
