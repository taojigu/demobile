//
//  LogAdaptor.m
//  demobile
//
//  Created by GuJitao on 2021/2/2.
//  Copyright © 2021 GuJitao. All rights reserved.
//

#import "LogAdaptor.h"
#import "HeartBeatModel.h"
#import "BaseLKModel.h"
#import "NSObject+LKModel.h"

@implementation LogAdaptor


+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static LogAdaptor *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[LogAdaptor alloc] init];
    });
    
    return manager;
}

- (instancetype) init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)logHeartBeat:(NSDate*) date {
    HeartBeatModel * hbm = [[HeartBeatModel alloc] init];
    hbm.timeInterval = [date timeIntervalSince1970];
    hbm.date = date;
    [hbm saveToDB];
}

// 获取两个时间时间段内心跳次数
- (NSInteger)fetchHeartBeatCounts:(NSDate *)startDate endDate:(NSDate *)endDate {
    
    NSString *startDateString = [self dateString:startDate];
    NSString *endDateString = [self dateString:endDate];
    
    NSString *whereSttring = [NSString stringWithFormat:@"date >= \'%@\' and date <= \'%@\'",startDateString,endDateString];
    NSInteger rowCount = [HeartBeatModel rowCountWithWhere:whereSttring];
    return rowCount;
}

- (NSString *)dateString:(NSDate *)date {
     //@"date >= '2013-04-01 00:00:00'"
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}



#pragma mark -- init



@end
