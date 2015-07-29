//
//  ViewController.m
//  hitTest_test
//
//  Created by 杨小兵 on 15/7/29.
//  Copyright (c) 2015年 杨小兵. All rights reserved.
//

#import "ViewController.h"
#import "XXBHitTestView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self p_loadView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)p_loadView
{
    
    XXBHitTestView *hitTestView = [[XXBHitTestView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 60,CGRectGetWidth(self.view.frame), 60)];
    hitTestView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:0.8];
    hitTestView.userInteractionEnabled = YES;
    [self.view addSubview:hitTestView];
    hitTestView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin| UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"...点击了...");
    return self.view;
}
@end
