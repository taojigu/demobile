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
        [self initDB];
    }
    return self;
}

- (void)logHeartBeat:(NSDate*) date {
    HeartBeatModel * hbm = [[HeartBeatModel alloc] init];
    hbm.timeInterval = [date timeIntervalSince1970];
    hbm.date = date;
    [hbm saveToDB];
}

- (void)initDB {
    
}

#pragma mark -- init



@end
