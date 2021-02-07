//
//  SummaryModel.h
//  demobile
//
//  Created by GuJitao on 2021/2/2.
//  Copyright © 2021 GuJitao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 逻辑数据结果
@interface SummaryModel : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *desc;
@property (nonatomic,assign) NSInteger seconds;

@end

NS_ASSUME_NONNULL_END
