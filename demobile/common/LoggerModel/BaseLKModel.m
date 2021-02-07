//
//  BaseLKModel.m
//  demobile
//
//  Created by GuJitao on 2021/2/5.
//  Copyright © 2021 GuJitao. All rights reserved.
//

#import "BaseLKModel.h"
#import "NSObject+LKModel.h"

@implementation BaseLKModel


+ (LKDBHelper *)getUsingLKDBHelper {
    
    static LKDBHelper* db;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //DB 路径
        NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString* DBPath = [documentsDirectory stringByAppendingPathComponent:@"logData.db"];
        NSLog(@"%@", DBPath);
        db = [[LKDBHelper alloc] initWithDBPath:DBPath];
    });
    return db;
}


@end
