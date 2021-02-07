//
//  AliveLogger.h
//  demobile
//
//  Created by GuJitao on 2021/2/1.
//  Copyright © 2021 GuJitao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AliveLogger : NSObject

+ (instancetype)sharedInstance;

//开始启动计时
- (void) startLogger;

// 暂停计时
- (void) pauseLogger;

// 重启计时
- (void)restartLogger;



// 读取今天的消耗的分钟数
- (int) fetchTodayMinutes;




@end

NS_ASSUME_NONNULL_END
