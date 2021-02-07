//
//  LogAdaptor.h
//  记录Log数据，直接对接数据库
//
//  Created by GuJitao on 2021/2/2.
//  Copyright © 2021 GuJitao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LogAdaptor : NSObject

+ (instancetype) sharedInstance;

- (void)logHeartBeat:(NSDate*) date ;

// 获取两个时间时间段内心跳次数
- (NSInteger)fetchHeartBeatCounts:(NSDate *)startDate endDate:(NSDate *)endDate;



@end

NS_ASSUME_NONNULL_END
