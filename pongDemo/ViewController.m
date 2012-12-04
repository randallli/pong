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

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    
    CADisplayLink * displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update:)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) update:(CADisplayLink*)displayLink {
    CFTimeInterval delta = displayLink.timestamp - self.timestamp;
    self.timestamp = displayLink.timestamp;
    NSLog(@"loggin update with delta: %f",delta);
}


@end
