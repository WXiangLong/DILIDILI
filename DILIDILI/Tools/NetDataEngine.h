//
//  NetDataEngine.h
//  xiangmu
//
//  Created by qianfeng0 on 16/3/13.
//  Copyright © 2016年 李俊亮. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlockType) (id respondObject);
typedef void(^FailedBlockType) (NSError *error);


@interface NetDataEngine : NSObject

+ (instancetype)sharedInstance;


- (void)requestAppHome:(NSString *)url success:(SuccessBlockType)successBlock falied:(FailedBlockType)failedBlock;

@end
