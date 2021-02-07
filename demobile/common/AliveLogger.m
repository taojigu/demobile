//
//  AliveLogger.m
//  demobile
//
//  Created by GuJitao on 2021/2/1.
//  Copyright © 2021 GuJitao. All rights reserved.
//

#import "AliveLogger.h"
#import "LogAdaptor.h"

typedef NS_ENUM (NSUInteger, LoggerState) {
    LoggerStateNone = -1,
    LoggerStateStart = 0,
    LoggerStateLoggin = 1,
    LoggerStatePaused  = 2,
    LoggerStateStop = 3
};

@interface AliveLogger ()

@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) NSInteger interval;

@end


@implementation AliveLogger


+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static AliveLogger *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[AliveLogger alloc] init];
    });
    
    return manager;
}



//开始启动计时
- (void) startLogger {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(recordTimerLog) userInfo:nil repeats:YES];
    [self.timer fire];
    

}

// 暂停计时
- (void) pauseLogger {
    
}

// 重启计时
- (void)restartLogger {
    
}

- (void)recordTimerLog {
    static int counter = 0;
    NSLog(@"Current Counter is %@",@(counter++));
    NSDate *date = [NSDate date];
    [[LogAdaptor sharedInstance] logHeartBeat:date];
    //获取当前时间
    //调用数据库adaptor,保存
}

- (NSInteger) fetchTodayMinutes {
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents * components = [calendar components:NSCalendarUnitYear |  NSCalendarUnitMonth  | NSCalendarUnitDay fromDate:date];

    NSDate *startDate = [self dateFromYear:components.year month:components.month day:components.day];
    NSInteger count = [[LogAdaptor sharedInstance] fetchHeartBeatCounts:startDate endDate:date];
    
    NSInteger minute = count / 10;
    
    return minute;
}

- (NSDate *)dateFromYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSDateComponents *dcpt = [[NSDateComponents alloc] init];
    dcpt.year = year;
    dcpt.month = month;
    dcpt.day = day;
    dcpt.hour = 0;
    dcpt.minute = 0;
    dcpt.second = 0;
    
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDate *date = [calendar dateFromComponents:dcpt];
    return date;
}




@end
