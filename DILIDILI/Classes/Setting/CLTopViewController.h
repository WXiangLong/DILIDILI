//
//  CLTopViewController.h
//  DiLiDiLi
//
//  Created by qianfeng on 16/3/29.
//  Copyright © 2016年 BJ. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol closeDelegate <NSObject>

- (void)closeBtnPressed;

@end


@interface CLTopViewController : UIViewController

@property (nonatomic, weak) id<closeDelegate>delegate;

@end
