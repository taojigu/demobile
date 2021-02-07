//
//  BaseLKModel.h
//  LKDBHelper Model 的基类
//
//  Created by GuJitao on 2021/2/5.
//  Copyright © 2021 GuJitao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+LKDBHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseLKModel : NSObject

+ (LKDBHelper *)sharedLKDBHelper;

@end

NS_ASSUME_NONNULL_END
