//
//  CLTopViewController.m
//  DiLiDiLi
//
//  Created by qianfeng on 16/3/29.
//  Copyright © 2016年 BJ. All rights reserved.
//

#import "CLTopViewController.h"
#import "CLUserModel.h"


@interface CLTopViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation CLTopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SW, SH)];
    [self.view addSubview:_scrollView];
    self.view.backgroundColor = [UIColor colorWithWhite:0.87 alpha:1];
    [self createHeaderView];
}

- (void)createHeaderView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SW, self.view.frame.size.height/3)];
    [_scrollView addSubview:view];
    view.backgroundColor = [UIColor colorWithWhite:0.87 alpha:0.7];
    
    
    UIImage *image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"icon"]];
    if (!image) {
        image = [UIImage imageNamed:@"AppIcon60x60"];
    }
    
    UIImageView *imageView = [[UIImageView alloc] init];
    
    imageView.image = image;
    imageView.frame = CGRectMake(SW/2-SW*0.15, SW*0.15, SW*0.3, SW*0.3);
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    imageView.layer.borderWidth = 2;
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 50;
    imageView.userInteractionEnabled = YES;
    [view addSubview:imageView];
    self.iconImageView = imageView;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [imageView addGestureRecognizer:tap];
    
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(SW/2-50, CGRectGetMaxY(imageView.frame)+5, 100, 20)];
    [view addSubview:textField];
    textField.borderStyle = UITextBorderStyleNone;
    textField.textAlignment = NSTextAlignmentCenter;
    self.textField = textField;
    
    
    
    self.textField.delegate = self;
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"userName"]) {
        self.textField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    } else {
        self.textField.text = @"Eyepetizer";
    }
    
    
    
    
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(SW/2-50, CGRectGetMaxY(textField.frame)+8, 100, 1)];
    view1.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
    [view addSubview:view1];
    
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(50, CGRectGetMaxY(view1.frame)+15, SW/2-50, 44);
    [view addSubview:btn];
    [btn setTitle:@"我的收藏" forState: UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btn) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.frame = CGRectMake(CGRectGetMaxX(btn.frame), CGRectGetMaxY(view1.frame)+15, SW/2-50, 44);
    [view addSubview:btn1];
    btn1.backgroundColor = [UIColor greenColor];
    [btn1 setTitle:@"我的缓存" forState: UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btn1) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(SW/2, CGRectGetMaxY(view.frame)-44, 1, 24)];
    lineView2.backgroundColor = [UIColor colorWithWhite:0.7 alpha:1];
    [view addSubview:lineView2];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame)-0.5, SW, 0.5)];
    lineView1.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
    [view addSubview:lineView1];
    
    
    NSArray *titleNames = @[@"清除缓存",@"功能开关",@"我要投稿",@""];
    
    for (int i = 0 ; i < 4; i++) {
        
        UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
        btn2.frame = CGRectMake(0,i*SH*0.11+CGRectGetMaxY(btn.frame)+SH*0.01,SW,SH*0.1);
        
        [btn2 setTitle:titleNames[i] forState: UIControlStateNormal];
        [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn2.tag = i+1;
        btn2.backgroundColor = [UIColor blueColor];
        [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_scrollView addSubview:btn2];
        
    }
    
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn4 setTitle:@"关闭" forState: UIControlStateNormal];
    
    [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    btn4.backgroundColor = [UIColor whiteColor];
    
    [btn4 addTarget:self action:@selector(CloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    btn4.frame = CGRectMake(0, SH-49-64, SW, 49);
    [self.view addSubview:btn4];
    
    UIView *view4= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SW, 0.5)];
    view4.backgroundColor = [UIColor blackColor];
    [btn4 addSubview:view4];
    
    [btn4 bringSubviewToFront:_scrollView];
    
    UIButton *btnds = [self.view viewWithTag:4];
    
    _scrollView.contentSize = CGSizeMake(SW, CGRectGetMaxY(btnds.frame)-CGRectGetMinY(view.frame));
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    
    
}

//
- (void)btn {}

- (void)btn1 {}

// 头像点击事件
- (void)tap:(UIGestureRecognizer *)tap {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择照片" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        UIImagePickerController *pvc = [[UIImagePickerController alloc] init];
        
        pvc.delegate = self;
        
        pvc.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:pvc animated:YES completion:nil];
        
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相册" style: UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *pvc = [[UIImagePickerController alloc] init];
        
        pvc.delegate = self;
        pvc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:pvc animated:YES completion:nil];
        
        
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style: UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    
    [alert addAction:action];
    [alert addAction:action1];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    
    _iconImageView.image = image;
    
    NSData *data = UIImageJPEGRepresentation(image, 1);
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"icon"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [picker dismissViewControllerAnimated:NO completion:^{
        
        self.view.frame = CGRectMake(0, 64, SW, SH);
        
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    
    if (![self.textField.text isEqualToString:@""]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:self.textField.text forKey:@"userName"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        self.textField.text = textField.text;
    }
    
}

- (void)btnClick:(UIButton *)sender {
    
    switch (sender.tag) {
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
        {

        }
            break;
        default:
            break;
    }
    
    
}

- (void)CloseBtn:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(closeBtnPressed)]) {
        
        [_delegate closeBtnPressed];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
