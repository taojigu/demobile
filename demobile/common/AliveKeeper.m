//
//  AliveKeeper.m
//  demobile
//
//  Created by GuJitao on 2021/2/1.
//  Copyright © 2021 GuJitao. All rights reserved.
//

#import "AliveKeeper.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>


@interface AliveKeeper ()


@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation AliveKeeper


+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static AliveKeeper *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[AliveKeeper alloc] init];
    });
    
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initAudioPlayer];
    }
    return self;
}

- (void)startBackgroundAlive {
    [self startPlaySilientMusic];
}

- (void)pauseBackgroudAlive {
    [self.player pause];
}

- (void)stopBackgroundAlive {
    [self.player stop];
}

#pragma mark -- keep alive

- (void)startPlaySilientMusic {
    BOOL result = [self.player play];
    NSLog(@"start play result is %@",@(result));
    
}

#pragma mark -- init messages

- (void) initAudioPlayer {
    
    //设置后台模式和锁屏模式下依然能够播放
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    
    //初始化音频播放器
    NSError *playerError;
    NSURL *urlSound = [[NSURL alloc]initWithString:[[NSBundle mainBundle]pathForResource:@"pomodoSound" ofType:@"m4a"]];
    AVAudioPlayer *playerSound = [[AVAudioPlayer alloc] initWithContentsOfURL:urlSound error:&playerError];
    playerSound.numberOfLoops = -1;//无限播放
    _player = playerSound;    //设置后台模式和锁屏模式下依然能够播放

}





@end
