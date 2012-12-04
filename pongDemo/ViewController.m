//
//  ViewController.m
//  pongDemo
//
//  Created by RANDALL LI on 12/4/12.
//  Copyright (c) 2012 RANDALL LI. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()
@property (nonatomic) CFTimeInterval timestamp;

@property (nonatomic, strong) UIImageView * ball;
@property (nonatomic) CGPoint velocity;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    CADisplayLink * displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update:)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];

    self.ball = [[UIImageView alloc] initWithImage:[UIImage imageNamed: @"ball"]];
    self.ball.center = CGPointMake(CGRectGetMidX(self.view.bounds),CGRectGetMidY(self.view.bounds));

    [self.view addSubview:self.ball];

    self.velocity = CGPointMake(0, 30);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) update:(CADisplayLink*)displayLink {
    CFTimeInterval delta = displayLink.timestamp - self.timestamp;
    if(self.timestamp <=0)
    {
        delta = 0;
    }
    self.timestamp = displayLink.timestamp;
    NSLog(@"loggin update with delta: %f",delta);

    CGPoint newPosition = self.ball.center;
    newPosition.x = self.ball.center.x + delta * self.velocity.x;
    newPosition.y = self.ball.center.y + delta * self.velocity.y;
    
    self.ball.center = newPosition;//CGPointMake(self.ball.center.x , y);

}


@end
