//
//  ViewController.m
//  CALayerTestTwo
//
//  Created by xiaomanwang on 14-1-9.
//  Copyright (c) 2014年 xiaomanwang. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
{
	CALayer*movingLayer;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self setup];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

static int layerSize = 50;
- (void)setup
{
	movingLayer = [CALayer layer];
	[movingLayer setBounds: CGRectMake(0, 0, layerSize, layerSize)];
	[movingLayer setBackgroundColor:[UIColor orangeColor].CGColor];
	[movingLayer setPosition:CGPointMake(20	, 20)];
	[[[self view] layer] addSublayer:movingLayer];
	[self setMovingLayer:movingLayer];
	UITapGestureRecognizer*tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressedLayer:)];
	[self.view addGestureRecognizer:tap];
	[tap release];
}

- (void)setMovingLayer:(CALayer*)layer
{
	CAKeyframeAnimation * moveLayerAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	CGPoint p = CGPointMake(20, 20);
	NSValue*v = [NSValue valueWithCGPoint:p];
	CGPoint p1 = CGPointMake(60, 60);
	NSValue*v1 = [NSValue valueWithCGPoint:p1];
	CGPoint p2 = CGPointMake(150, 150);
	NSValue*v2 = [NSValue valueWithCGPoint:p2];
	CGPoint p3 = CGPointMake(270, 400);
	NSValue*v3 = [NSValue valueWithCGPoint:p3];
	[moveLayerAnimation setValues:[NSArray arrayWithObjects: v, v1,v2,v3, nil]];
	
	[moveLayerAnimation setDuration:5.0];
	[moveLayerAnimation setRepeatCount:HUGE_VALF];
	[moveLayerAnimation setTimingFunction: [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
	[movingLayer addAnimation:moveLayerAnimation forKey:@"move"];
}

- (IBAction)pressedLayer:(UIGestureRecognizer *)gestureRecognizer
{
	CGPoint touchPoint = [gestureRecognizer locationInView:[self view]];
    if ([[movingLayer presentationLayer] hitTest:touchPoint])
	{
        [self blinkLayerWithColor:[UIColor yellowColor]];
    }
	else if ([movingLayer hitTest:touchPoint])
	{
        [self blinkLayerWithColor:[UIColor redColor]];
    }
}

- (void)blinkLayerWithColor:(UIColor *)color
{
    CABasicAnimation * blinkAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    [blinkAnimation setDuration:0.2];
    [blinkAnimation setAutoreverses:YES];
    [blinkAnimation setFromValue:(id)[movingLayer backgroundColor]];
    [blinkAnimation setToValue:(id)color.CGColor];
    [movingLayer addAnimation:blinkAnimation forKey:@"blink"];
}
@end
