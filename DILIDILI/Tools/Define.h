//
//  Define.h
//  DiLiDiLi
//
//  Created by qianfeng on 16/3/28.
//  Copyright © 2016年 BJ. All rights reserved.
//

#ifndef Define_h
#define Define_h

#define SW [UIScreen mainScreen].bounds.size.width
#define SH [UIScreen mainScreen].bounds.size.height
#define SF [UIScreen mainScreen].bounds

// 搜索
#define Search @"http://baobab.wandoujia.com/api/v1/search?num=20&query=%@"


//每日精选
#define dayChose @"http://baobab.wandoujia.com/api/v2/feed?&num=5"


// 时间排行
#define timeSort @"http://baobab.wandoujia.com/api/v3/videos?categoryId=%@&start=%ld&num=%ld&strategy=date"
//分享排行
#define shareSort @"http://baobab.wandoujia.com/api/v3/videos?categoryId=%@&start=%ld&num=%ld&strategy=shareCount"


//周排行
#define weekSort @"http://baobab.wandoujia.com/api/v3/ranklist?&strategy=weekly"
//月排行
#define monthSort @"http://baobab.wandoujia.com/api/v3/ranklist?&strategy=monthly"
//总排行榜
#define historySort @"http://baobab.wandoujia.com/api/v3/ranklist?&strategy=historical"


#endif /* Define_h */
