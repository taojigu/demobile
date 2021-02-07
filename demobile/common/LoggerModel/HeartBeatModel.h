//
//  HeartBeatModel.h
//  demobile
//
//  Created by GuJitao on 2021/2/5.
//  Copyright © 2021 GuJitao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseLKModel.h"
#import "NSObject+LKDBHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeartBeatModel : BaseLKModel

@property (nonatomic, assign) NSTimeInterval timeInterval;
@property (nonatomic, assign) NSDate *date;

@end

NS_ASSUME_NONNULL_END
