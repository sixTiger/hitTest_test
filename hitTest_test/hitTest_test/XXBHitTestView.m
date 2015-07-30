//
//  XXBHitTestView.m
//  hitTest_test
//
//  Created by 杨小兵 on 15/7/29.
//  Copyright (c) 2015年 杨小兵. All rights reserved.
//

#import "XXBHitTestView.h"

@implementation XXBHitTestView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self p_loadView];
    }
    return self;
}

- (void)p_loadView
{
    //检测再view外边的视图是否有事件
    self.clipsToBounds = YES;
    UIButton *(^makeBtn)(UIImage *,UIImage *,CGRect,NSString*) = ^UIButton *(UIImage *nomalImage,UIImage *highlightedImage,CGRect frame,NSString *string){
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = frame;
        [button  setImage:nomalImage forState:UIControlStateNormal];
        [button  setImage:highlightedImage forState:UIControlStateHighlighted];
        [button setTitle:string forState:UIControlStateNormal];
        button.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:0.8];
        return button;
    };
    UIButton *roundBtn = makeBtn(nil, nil, CGRectMake(self.frame.size.width / 2 - 30, -30, 60, 60), nil);
    roundBtn.backgroundColor = [UIColor yellowColor];
    roundBtn.layer.cornerRadius = 30;
    roundBtn.tag = 10000;
    [roundBtn addTarget:self action:@selector(onBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *leftBtn = makeBtn(nil, nil, CGRectMake(15, 15, 40, 40), nil);
    leftBtn.backgroundColor = [UIColor blueColor];
    leftBtn.tag = 10001;
    [leftBtn addTarget:self action:@selector(onBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightBtn = makeBtn(nil, nil, CGRectMake(self.frame.size.width - 55, 15, 40, 40), nil);
    rightBtn.frame = CGRectMake(self.frame.size.width - 55, 15, 40, 40);
    rightBtn.backgroundColor = [UIColor blueColor];
    rightBtn.tag = 10002;
    [rightBtn addTarget:self action:@selector(onBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:roundBtn];
    [self addSubview:leftBtn];
    [self addSubview:rightBtn];
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    UIButton *roundBtn = (UIButton *)[self viewWithTag:10000];
    UIButton *leftBtn = (UIButton *)[self viewWithTag:10001];
    UIButton *rightBtn = (UIButton *)[self viewWithTag:10002];
    BOOL pointInRound = [self touchPointInsideCircle:roundBtn.center radius:30 targetPoint:point];
    if (pointInRound)
    {
        hitView = roundBtn;
    }
    else
    {
        if(CGRectContainsPoint(leftBtn.frame, point))
        {
            hitView  = leftBtn;
        }
        else
        {
            if(CGRectContainsPoint(rightBtn.frame, point))
            {
                hitView = rightBtn;
            }
//            else
//            {
//                if(CGRectContainsPoint(self.bounds, point))
//                {
//                    hitView = self;
//                }
//            }
        }
    }
    return hitView;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"点击了view");
}
- (BOOL)touchPointInsideCircle:(CGPoint)center radius:(CGFloat)radius targetPoint:(CGPoint)point
{
    CGFloat dist = sqrtf((point.x - center.x) * (point.x - center.x) +
                         (point.y - center.y) * (point.y - center.y));
    return (dist <= radius);
}
- (void)onBtnPressed:(UIButton *)button
{
    NSLog(@"btn tag:%@", @(button.tag));
}
@end
