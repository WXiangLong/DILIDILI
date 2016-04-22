//
//  NetDataEngine.m
//  xiangmu
//
//  Created by qianfeng0 on 16/3/13.
//  Copyright © 2016年 李俊亮. All rights reserved.
//

#import "NetDataEngine.h"
#import "AFNetworking.h"

@implementation NetDataEngine

+ (instancetype)sharedInstance{
    static NetDataEngine *s_intance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_intance = [[NetDataEngine alloc]init];
    });
    return s_intance;
}

- (NSString *)urlEncode:(NSString *)urlInput{
    return [urlInput stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
}
- (void)GET:(NSString *)url success:(SuccessBlockType)successBlock failed:(FailedBlockType)failedBlock{
    NSString *urlEncoded = [self urlEncode:url];
    
    AFHTTPRequestOperationManager *manage = [AFHTTPRequestOperationManager manager];
    
    NSSet *set = manage.responseSerializer.acceptableContentTypes;
    NSMutableSet *acceptSet = [NSMutableSet setWithSet:set];
    [acceptSet addObject:@"text/html"];
    manage.responseSerializer.acceptableContentTypes = acceptSet;
    [manage GET:urlEncoded parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failedBlock) {
            failedBlock(error);
        }
    }];
}
- (void)requestAppHome:(NSString *)url success:(SuccessBlockType)successBlock falied:(FailedBlockType)failedBlock{
    [self GET:url success:successBlock failed:failedBlock];
}



@end
