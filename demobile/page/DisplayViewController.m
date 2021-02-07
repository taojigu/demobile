//
//  DisplayViewController.m
//  demobile
//
//  Created by GuJitao on 2021/2/1.
//  Copyright © 2021 GuJitao. All rights reserved.
//

#import "DisplayViewController.h"
#import "LogAdaptor.h"

// 展示数据的接口
@interface DisplayViewController ()

@end

@implementation DisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"展示";
    self.view.backgroundColor = [UIColor whiteColor];
    [self addFetchTodayLoggerButton];
    // Do any additional setup after loading the view.
    // 获取当天的数据
    // 获取本周的数据
    // 获取本月的数据
    // 获取指定dateTime的数据
}

- (void)addFetchTodayLoggerButton {
    
    UIButton *todyButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 80)];
    [todyButton setTitle:@"FetchToday" forState:UIControlStateNormal];
    [todyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [todyButton addTarget:self action:@selector(fetchTodayLoggerClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:todyButton];
}

- (void)addFetchWeekCompareButton {
    UIButton *todyButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 80)];
    [todyButton setTitle:@"WeekCompare" forState:UIControlStateNormal];
    [todyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [todyButton addTarget:self action:@selector(fetchWeekCompareClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:todyButton];
}


- (void)fetchWeekCompareClicked {

}


- (void) fetchTodayLoggerClicked {
    int minutes = [LogAdaptor sharedInstance] fetchTodayHeartBeatCount
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
