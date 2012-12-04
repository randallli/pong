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

@property (nonatomic, strong) UIImageView * player1Paddle;
@property (nonatomic, strong) UIImageView * player2Paddle;

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
    
    self.player1Paddle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paddle"]];
    self.player1Paddle.center = CGPointMake(CGRectGetMidX(self.view.bounds),CGRectGetMidY(self.player1Paddle.frame));
    
    self.player2Paddle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paddle"]];
    self.player2Paddle.center = CGPointMake(CGRectGetMidX(self.view.bounds),CGRectGetMaxY(self.view.bounds) - CGRectGetMidY(self.player2Paddle.frame));
    
    [self.view addSubview:self.player1Paddle];
    [self.view addSubview:self.player2Paddle];


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
    //NSLog(@"loggin update with delta: %f",delta);

    if(self.ball.center.y < CGRectGetMidY(self.view.bounds))
    {
        //upper half
        if(CGRectGetMinY(self.ball.frame) < CGRectGetMinY(self.view.bounds))
        {
            //you lose
            [self resetRoundWithPlayer1ToServe:YES];
        }
    }
    else
    {
        //lower half
        if(CGRectGetMaxY(self.ball.frame) > CGRectGetMaxY(self.view.bounds))
        {
            //you lose
            [self resetRoundWithPlayer1ToServe:NO];
        }
    }

    
    CGPoint newPosition = self.ball.center;
    newPosition.x = self.ball.center.x + delta * self.velocity.x;
    newPosition.y = self.ball.center.y + delta * self.velocity.y;
    
    self.ball.center = newPosition;//CGPointMake(self.ball.center.x , y);

}

- (void) resetRoundWithPlayer1ToServe:(BOOL) player1Serves
{
    if(player1Serves)
    {
        self.velocity = CGPointMake(0, 30);
    }
    else
    {
        self.velocity = CGPointMake(0, -30);
    }
    self.ball.center = CGPointMake(CGRectGetMidX(self.view.bounds),CGRectGetMidY(self.view.bounds));
    
}


@end
