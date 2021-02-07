//
//  AppDelegate.m
//  demobile
//
//  Created by GuJitao on 2021/1/29.
//  Copyright © 2021 GuJitao. All rights reserved.
//

#import "AppDelegate.h"
#import "AliveKeeper.h"
#import "HomeViewController.h"
#import "DisplayViewController.h"


#import <notify.h>
#define NotificationLock CFSTR("com.apple.springboard.lockcomplete")
#define NotificationChange CFSTR("com.apple.springboard.lockstate")
#define NotificationPwdUI CFSTR("com.apple.springboard.hasBlankedScreen")



static void screenLockStateChanged(CFNotificationCenterRef center,void* observer,CFStringRef name,const void*object,CFDictionaryRef userInfo)
{
  NSString* lockstate = (__bridge NSString*)name;
  if ([lockstate isEqualToString:(__bridge NSString*)NotificationLock]) {
    NSLog(@"locked.");
  } else {
    NSLog(@"lock state changed.");
  }
}

@interface AppDelegate ()

@property (nonatomic, assign) UIBackgroundTaskIdentifier bgTask;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSUInteger counter;

@end

@implementation AppDelegate

// 后台运行方法：https://www.jianshu.com/p/d3d3a5086567
// 监听锁屏：https://www.jianshu.com/p/51f0fefd472f
// 后台任务： https://www.jianshu.com/p/5547e72f5736
//https://juejin.cn/post/6844904041680470023
//  https://www.cnblogs.com/linusflow/p/8674718.html  方法最直接

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    UIViewController *rootVC = [self rootViewController];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    // 启动关注锁屏信息的方法
    //[self registerMonitor];
    // 启动后台任务
    //[self startBackgroundTask];
    //[[AliveKeeper sharedInstance] startBackgroundAlive];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillResignActive:(UIApplication *)application{
    
}



- (void)applicationDidEnterBackground:(UIApplication *)application {

    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark -- private init messages

- (UIViewController *)rootViewController {
    HomeViewController *hvc = [[HomeViewController alloc] init];
    hvc.title = @"Home";
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:hvc];
    navi.navigationBar.translucent = NO;
    
    DisplayViewController *dvc = [[DisplayViewController alloc] init];
    dvc.title = @"展示";
    UINavigationController *dnavi = [[UINavigationController alloc] initWithRootViewController:dvc];
    dnavi.navigationBar.translucent = NO;
    
    UITabBarController *tbvc = [[UITabBarController alloc] init];
    tbvc.viewControllers = @[navi,dnavi];
    return  tbvc;
}

#pragma mark -- 用于判断手机是否处于lock状态

- (void)applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application
{
    
    [[AliveKeeper sharedInstance] pauseBackgroudAlive];
    
}
- (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application
{
    
}

#pragma mark -- private  task messages

- (void)startBackgroundTask {
   
    [self comeToBackgroundMode];
}


-(void)comeToBackgroundMode{
    //初始化一个后台任务BackgroundTask，这个后台任务的作用就是告诉系统当前app在后台有任务处理，需要时间
    UIApplication*  app = [UIApplication sharedApplication];
    self.bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        NSLog(@"background expired at comeToBackgroundMode ");
        [app endBackgroundTask:self.bgTask];
        self.bgTask = UIBackgroundTaskInvalid;
    }];
    NSLog(@"Start backgournd Task %@",@(self.bgTask));
    //开启定时器 不断向系统请求后台任务执行的时间

    self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(applyForMoreTime) userInfo:nil repeats:YES];
    [self.timer fire];
}

-(void)applyForMoreTime {
   //如果系统给的剩余时间小于60秒 就终止当前的后台任务，再重新初始化一个后台任务，重新让系统分配时间，这样一直循环下去，保持APP在后台一直处于active状态。
    if ([UIApplication sharedApplication].backgroundTimeRemaining < 60) {
        NSLog(@"restart background task %@",@(self.bgTask));
        [[UIApplication sharedApplication] endBackgroundTask:self.bgTask];
        //[self comeToBackgroundMode];
        self.bgTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
            [[UIApplication sharedApplication] endBackgroundTask:self.bgTask];
            self.bgTask = UIBackgroundTaskInvalid;
        }];
        NSLog(@"Restarted background task %@",@(self.bgTask));
        self.timer = nil;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(applyForMoreTime) userInfo:nil repeats:YES];
        [self.timer fire];
        //return;
    }
    
    [self insertLogData];

}

- (void)insertLogData {
    NSLog(@"Current Counter is  %li",(long)self.counter ++);
}


- (void) registerMonitor {
    // Override point for customization after application launch.
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, screenLockStateChanged, NotificationLock, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, screenLockStateChanged, NotificationChange, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
    
}




#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
