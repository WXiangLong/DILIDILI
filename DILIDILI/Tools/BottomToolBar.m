//
//  BottomToolBar.m
//  DiLiDiLi
//
//  Created by qianfeng on 16/3/28.
//  Copyright © 2016年 BJ. All rights reserved.
//

#import "BottomToolBar.h"

#define Frame self.frame
#define Width self.bounds.size.width/3
#define Height self.bounds.size.height

@interface BottomToolBar ()

@property (nonatomic, strong) NSArray *array;

@property (nonatomic) NSInteger recorder;

@end

@implementation BottomToolBar


- (instancetype)initWithFrame:(CGRect)frame AndTitleList:(NSArray *)titleList andBlock:(Block)block
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.block = block;
        self.recorder = 1;
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
        
        [self createSELFViewWithTitleList:titleList];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeButtonColor:) name:@"click" object:nil];
        
    }
    
    return self;
}

- (void)createSELFViewWithTitleList:(NSArray *)titleList {
    CGFloat size = [UIScreen mainScreen].bounds.size.width/3;
    [self createBtnWithTitle:titleList];
     [self createView:size];
    [self createView:size*2];
}


- (void)createView:(CGFloat)X {
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(X, 8, 0.8, Height-16);
    [self addSubview:view];
    view.backgroundColor = [UIColor grayColor];
}

- (void)createBtnWithTitle:(NSArray *)title {
    
    CGFloat size = [UIScreen mainScreen].bounds.size.width/3;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(0, 0,size , Height);
    btn.tag = 1;
    [btn setTitle:title[0] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.frame = CGRectMake(size, 0,size , Height);
    btn1.tag = 2;
    [btn1 setTitle:title[1] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn1];
    
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn2.frame = CGRectMake(size*2,0, size , Height);
    btn2.tag = 3;
    [btn2 setTitle:title[2] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn2];
    
    _array = @[btn, btn1, btn2];
}

- (void)btn:(UIButton *)sender
{
    if (_block)
    {
        self.block(sender.tag-1);
    }
}
- (void) changeButtonColor:(NSNotification *)notification
{
    int index = [notification.object intValue];
    
    UIButton *btn = _array[index];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    NSMutableArray * arr = [NSMutableArray arrayWithArray:_array];
    
    [arr removeObjectAtIndex:index];
    
    for (UIButton * btn in arr)
    {
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
}

@end
