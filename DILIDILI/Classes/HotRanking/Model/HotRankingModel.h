//
//  HotRangingModel.h
//  DiLiDiLi
//
//  Created by LONG on 16/3/30.
//  Copyright © 2016年 BJ. All rights reserved.
//

#import "JSONModel.h"

@interface HotRankingModel : JSONModel

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) long long date;

@property (nonatomic, assign) NSInteger idx;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *myDescription;

@property (nonatomic, copy) NSString *category;

@property (nonatomic, assign) NSInteger duration;

@property (nonatomic, copy) NSString *playUrl;

@property (nonatomic, copy) NSArray * playInfo;

@property (nonatomic, copy) NSDictionary * consumption;

@property (nonatomic, copy) NSDictionary * cover;


+ (NSMutableArray *) parseData:(id) respondObject;

@end
