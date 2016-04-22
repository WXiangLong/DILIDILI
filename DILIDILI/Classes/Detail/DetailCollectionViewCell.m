//
//  DetailCollectionViewCell.m
//  DILIDILI
//
//  Created by LONG on 16/4/22.
//  Copyright © 2016年 LONG. All rights reserved.
//

#import "DetailCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface DetailCollectionViewCell()

@property (nonatomic) NSTimer * timer;

@end

@implementation DetailCollectionViewCell

- (void)updateCell:(HotRankingModel *)model tag:(NSInteger)tag
{
    if (tag == 100)
    {
        self.bgImageVIew.contentMode = UIViewContentModeScaleAspectFill;
        
        [self.bgImageVIew sd_setImageWithURL:[NSURL URLWithString:model.cover[@"detail"]]];
        
        _bgImageVIew.userInteractionEnabled = NO;
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2.f target:self selector:@selector(beganTransform) userInfo:nil repeats:YES];
        
        [self.timer setFireDate:[NSDate distantPast]];
    }
    else
    {
        self.bgImageVIew.contentMode = UIViewContentModeScaleAspectFill;
        
        [self.bgImageVIew sd_setImageWithURL:[NSURL URLWithString:model.cover[@"blurred"]]];
    }
}

- (void) beganTransform
{
    [UIView animateWithDuration:1.5 animations:^{
        
        self.bgImageVIew.transform = CGAffineTransformMakeScale(1.05, 1.05);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.5 animations:^{
            
            self.bgImageVIew.transform = CGAffineTransformIdentity;
            
        } completion:nil];
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
