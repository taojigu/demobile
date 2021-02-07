//
//  HomeViewController.m
//  demobile
//
//  Created by GuJitao on 2021/1/29.
//  Copyright © 2021 GuJitao. All rights reserved.
//

#import "HomeViewController.h"
#import "AliveKeeper.h"
#import "AliveLogger.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.redColor;
    [self addStartLoggerButton];
}

- (void)addStartLoggerButton {
    UIButton *startLogButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 80)];
    [startLogButton setTitle:@"StartLogger" forState:UIControlStateNormal];
    [startLogButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [startLogButton addTarget:self action:@selector(startLoggerClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startLogButton];
}

- (void)pauseStartLoggerButton {
    
    
}

#pragma mark -- private message

- (void)startLoggerClicked {
    //弹出文本框：询问是否愿意启动
    [[AliveKeeper sharedInstance] startBackgroundAlive];
    [[AliveLogger sharedInstance] startLogger];

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
