//
//  SelectedModel.m
//  DILIDILI
//
//  Created by LONG on 16/4/21.
//  Copyright © 2016年 LONG. All rights reserved.
//

#import "SelectedModel.h"

@implementation SelectedModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description":@"myDescription"}];
}



+ (NSMutableArray *) parseData:(id) respondObject
{
    NSMutableArray * resultArray = [NSMutableArray array];
    
    NSArray * array = respondObject[@"issueList"];
    
    for (NSDictionary * dict1 in array)
    {
        for (NSDictionary * dict in dict1[@"itemList"])
        {
            if ([dict[@"type"] isEqualToString:@"video"])
            {
                SelectedModel * model = [[SelectedModel alloc] initWithDictionary:dict[@"data"] error:nil];
                
                [resultArray addObject:model];
            }
        }
    }
    return resultArray;
}

@end
