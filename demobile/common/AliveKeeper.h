//
//  AliveKeeper.h
//  demobile
//
//  Created by GuJitao on 2021/2/1.
//  Copyright © 2021 GuJitao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AliveKeeper : NSObject

+ (instancetype)sharedInstance;


- (void)startBackgroundAlive;

- (void)pauseBackgroudAlive;

- (void)stopBackgroundAlive;

@end

NS_ASSUME_NONNULL_END
