//
//  SelectedModel.h
//  DILIDILI
//
//  Created by LONG on 16/4/21.
//  Copyright © 2016年 LONG. All rights reserved.
//

#import "JSONModel.h"

@interface SelectedModel : JSONModel

@property (nonatomic) NSString * id;

@property (nonatomic) NSString * title;

@property (nonatomic) NSString * myDescription;

@property (nonatomic) NSString * category;

@property (nonatomic) NSDictionary * cover;

@property (nonatomic) NSString * duration;

@property (nonatomic) NSArray * playInfo;

@property (nonatomic) NSDictionary * consumption;

@end
