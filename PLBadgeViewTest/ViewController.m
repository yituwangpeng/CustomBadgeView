//
//  ViewController.m
//  PLBadgeViewTest
//
//  Created by 王鹏 on 15/8/28.
//  Copyright (c) 2015年 王鹏. All rights reserved.
//

#import "ViewController.h"
#import "PLBadgeView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    PLBadgeView *badgeView1 = [[PLBadgeView alloc] initWithFrame:CGRectMake(50,50,6.0,6.0)];
    [self.view addSubview:badgeView1];
    
    PLBadgeView *badgeView2 = [[PLBadgeView alloc] initWithFrame:CGRectMake(100,100,20.0,20.0)];
    badgeView2.text = @"123";
    [self.view addSubview:badgeView2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
