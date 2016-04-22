//
//  FindCollectionViewCell.h
//  DILIDILI
//
//  Created by LONG on 16/4/21.
//  Copyright © 2016年 LONG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@property (weak, nonatomic) IBOutlet UILabel *categaryLabel;

- (void)updateCollectionViewCellWith:(NSString *)imageName categary:(NSString *)categary;

@end
