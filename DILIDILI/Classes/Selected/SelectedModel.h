//
//  SelectedModel.h
//  DILIDILI
//
//  Created by LONG on 16/4/21.
//  Copyright © 2016年 LONG. All rights reserved.
//

#import "JSONModel.h"

@interface SelectedModel : JSONModel

@property (nonatomic, assign) NSString<Optional>* text;

@property (nonatomic, assign) NSString<Optional>* image;




@property (nonatomic, assign) NSString<Optional>* id;

@property (nonatomic, assign) NSString<Optional>* date;

@property (nonatomic, assign) NSString<Optional>* idx;

@property (nonatomic, copy) NSString<Optional> *title;

@property (nonatomic, copy) NSString<Optional> *myDescription;

@property (nonatomic, copy) NSString<Optional> *category;

@property (nonatomic, assign) NSString<Optional>* duration;

@property (nonatomic, copy) NSString<Optional> *playUrl;

@property (nonatomic, copy) NSArray<Optional> * playInfo;

@property (nonatomic, copy) NSDictionary<Optional> * consumption;

@property (nonatomic, copy) NSDictionary<Optional> * cover;

+ (NSMutableArray *) parseData:(id) respondObject;

@end
