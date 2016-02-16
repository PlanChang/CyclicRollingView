//
//  ViewController.m
//  PLCyclicView
//
//  Created by Plan on 16/1/21.
//  Copyright © 2016年 PLAN. All rights reserved.
//

#import "ViewController.h"
#import "PLCyclicRollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    PLCyclicRollView *cView = [[PLCyclicRollView alloc] init];
    cView.backgroundColor = [UIColor redColor];
    cView.bounds = CGRectMake(0, 0, self.view.bounds.size.width, 200);
    cView.center = self.view.center;
    cView.delegate = self;
    [self.view addSubview:cView];
    cView.timeInterval = 2;
    cView.imageURLs = @[@"1",@"2",@"3",@"4",@"5"];
}

- (CGSize)cyclicView:(PLCyclicRollView *)cyclicView sizeForContentViewWithIndex:(NSInteger)index
{
    return CGSizeMake(100, 50);
}

- (void)rollView:(PLCyclicRollView *)rollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"%d",index);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
