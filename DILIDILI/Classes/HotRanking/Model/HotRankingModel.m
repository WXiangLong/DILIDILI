//
//  HotRangingModel.m
//  DiLiDiLi
//
//  Created by LONG on 16/3/30.
//  Copyright © 2016年 BJ. All rights reserved.
//

#import "HotRankingModel.h"

@implementation HotRankingModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description":@"myDescription"}];
}

+ (NSMutableArray *) parseData:(id) respondObject
{
    NSMutableArray * resultArray = [NSMutableArray array];
    
    NSArray * array = respondObject[@"itemList"];
    
    for (NSDictionary * dict in array)
    {
        HotRankingModel * model = [[HotRankingModel alloc] initWithDictionary:dict[@"data"] error:nil];
        
        [resultArray addObject:model];
    }
    return resultArray;
}




@end
