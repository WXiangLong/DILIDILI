//
//  FindCollectionViewCell.m
//  DILIDILI
//
//  Created by LONG on 16/4/21.
//  Copyright © 2016年 LONG. All rights reserved.
//

#import "FindCollectionViewCell.h"

@implementation FindCollectionViewCell

- (void)updateCollectionViewCellWith:(NSString *)imageName categary:(NSString *)categary
{
    self.bgImageView.image = [UIImage imageNamed:imageName];
    
    self.categaryLabel.text = categary;
    
    self.categaryLabel.textColor = [UIColor whiteColor];
    
    self.categaryLabel.font = [UIFont fontWithName:@"Lobster 1.4" size:28];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
