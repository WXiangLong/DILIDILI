//
//  BottomToolBar.h
//  DiLiDiLi
//
//  Created by qianfeng on 16/3/28.
//  Copyright © 2016年 BJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Block)(NSInteger Num);


@interface BottomToolBar : UIView


- (instancetype)initWithFrame:(CGRect)frame AndTitleList:(NSArray *)titleList andBlock:(Block)block;

@property (nonatomic, copy) Block block;

@end
