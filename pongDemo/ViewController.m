//
//  ViewController.m
//  pongDemo
//
//  Created by RANDALL LI on 12/4/12.
//  Copyright (c) 2012 RANDALL LI. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "BPGeometry.h"

#define kVelocity 70
#define kAcceleration 30

@interface ViewController ()
@property (nonatomic) CFTimeInterval timestamp;

@property (nonatomic, strong) UIImageView * ball;
@property (nonatomic) CGPoint velocity;

@property (nonatomic, strong) UIImageView * player1Paddle;
@property (nonatomic, strong) UIImageView * player2Paddle;

@property (nonatomic, strong) UITouch * player1Touch;
@property (nonatomic, strong) UITouch * player2Touch;

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

    self.velocity = CGPointMake(0, 100);
    
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
        [self bounceOffPaddle:self.player1Paddle];
    }
    else
    {
        //lower half
        if(CGRectGetMaxY(self.ball.frame) > CGRectGetMaxY(self.view.bounds))
        {
            //you lose
            [self resetRoundWithPlayer1ToServe:NO];
        }
        [self bounceOffPaddle:self.player2Paddle];
    }

    //right left sides
    if(CGRectGetMinX(self.ball.frame) < CGRectGetMinX(self.view.bounds))
    {
        self.velocity = CGPointMake(abs(self.velocity.x), self.velocity.y);
    }
    if(CGRectGetMaxX(self.ball.frame) > CGRectGetMaxX(self.view.bounds))
    {
        self.velocity = CGPointMake(-abs(self.velocity.x), self.velocity.y);
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
        self.velocity = CGPointMake(0, kVelocity);
    }
    else
    {
        self.velocity = CGPointMake(0, -kVelocity);
    }
    self.ball.center = CGPointMake(CGRectGetMidX(self.view.bounds),CGRectGetMidY(self.view.bounds));
    
}

- (void) bounceOffPaddle:(UIImageView *) paddle
{
    if(CGRectIntersectsRect(self.ball.frame, paddle.frame))
    {
        //player hit ball
        CGFloat speed = CGPointMagnitude(self.velocity);
        speed += kAcceleration;
        CGPoint direction = CGPointSubtract(self.ball.center, paddle.center);
        direction = CGPointNormalize(direction);
        self.velocity = CGPointScale(direction, speed);
    }
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * touch in touches) {
        CGPoint location = [touch locationInView:self.view];
        if(location.y < CGRectGetMidY(self.view.bounds))
        {
            self.player1Touch = touch;
            self.player1Paddle.center = CGPointMake(location.x, self.player1Paddle.center.y);
        }
        else
        {
            self.player2Touch = touch;
            self.player2Paddle.center = CGPointMake(location.x, self.player2Paddle.center.y);
        }
    }
    
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch * touch in touches) {
        CGPoint location = [touch locationInView:self.view];
        if(location.y < CGRectGetMidY(self.view.bounds))
        {
            if([self.player1Touch isEqual:touch])
            {
                self.player1Paddle.center = CGPointMake(location.x, self.player1Paddle.center.y);
            }
        }
        else
        {
            if([self.player2Touch isEqual:touch])
            {
                self.player2Paddle.center = CGPointMake(location.x, self.player2Paddle.center.y);
            }
        }
    }
    
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}


@end
