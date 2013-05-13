//
//  ViewController.m
//  PlatformsApp
//
//  Created by David Mazza on 3/31/13.
//  Copyright (c) 2013 David Mazza. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.scrollView.contentSize = CGSizeMake(320, 664);
    self.scrollView.bounces = FALSE;
    [self.view addSubview:self.scrollView];
    
    self.eighthAv = [UIButton buttonWithType:UIButtonTypeCustom];
    self.eighthAv.backgroundColor = [UIColor colorWithHue:0.0694 saturation:0.86 brightness:0.78 alpha:1.0];
    self.eighthAv.titleLabel.font = [UIFont boldSystemFontOfSize:36.0];
    [self.eighthAv setFrame:CGRectMake(0, 0, 320, 166)];
    [self.eighthAv setTitle:@"8" forState:UIControlStateNormal];
    [self.eighthAv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    self.gravity = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    [self.gravity setFrame:CGRectMake(10, 10, 300, 20)];
    [self.eighthAv addSubview:self.gravity];
    self.motionManager = [[CMMotionManager alloc] init];
    
    
    [self.motionManager startDeviceMotionUpdates];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(updateGravity) userInfo:nil repeats:YES];
    NSTimer *timer2 = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(resetAccel) userInfo:nil repeats:YES];
    self.accelCount = 0;
    self.accelMax = 0;
    self.startFall = nil;
    self.startRate = 0;
    self.fallMax = 0;
    
    
    
    //if (!motionManager.isDeviceMotionAvailable) {
        //motionManager.deviceMotionUpdateInterval = 1.0/60.0;
//        [motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXArbitraryZVertical toQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
//            NSLog([NSString stringWithFormat:@"%f", motion.gravity.z]);
//            //[self.gravity setProgress:(motion.gravity.z)];
//            [self.eighthAv setTitle:[NSString stringWithFormat:@"%f", motion.gravity.z] forState:UIControlStateNormal];
//        }];
    //}
    
    
    
    
    self.sixthAv = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sixthAv.backgroundColor = [UIColor colorWithHue:0.09167 saturation:0.86 brightness:0.78 alpha:1.0];
    self.sixthAv.titleLabel.font = [UIFont boldSystemFontOfSize:36.0];
    [self.sixthAv setFrame:CGRectMake(0, 166, 320, 166)];
    [self.sixthAv setTitle:@"6" forState:UIControlStateNormal];
    [self.sixthAv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.unionSq = [UIButton buttonWithType:UIButtonTypeCustom];
    self.unionSq.backgroundColor = [UIColor colorWithHue:0.125 saturation:0.86 brightness:0.78 alpha:1.0];
    self.unionSq.titleLabel.font = [UIFont boldSystemFontOfSize:36.0];
    [self.unionSq setFrame:CGRectMake(0, 332, 320, 166)];
    [self.unionSq setTitle:@"U" forState:UIControlStateNormal];
    [self.unionSq setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.thirdAv = [UIButton buttonWithType:UIButtonTypeCustom];
    self.thirdAv.backgroundColor = [UIColor colorWithHue:0.1694 saturation:0.86 brightness:0.78 alpha:1.0];
    self.thirdAv.titleLabel.font = [UIFont boldSystemFontOfSize:36.0];
    [self.thirdAv setFrame:CGRectMake(0, 498, 320, 166)];
    [self.thirdAv setTitle:@"3" forState:UIControlStateNormal];
    [self.thirdAv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    
    [self.scrollView addSubview:self.eighthAv];
    [self.scrollView addSubview:self.sixthAv];
    [self.scrollView addSubview:self.unionSq];
    [self.scrollView addSubview:self.thirdAv];
}

- (void)updateGravity
{
    self.accelSum += (self.motionManager.deviceMotion.userAcceleration.x + self.motionManager.deviceMotion.userAcceleration.y)/4;
    CMAcceleration userAccel = self.motionManager.deviceMotion.userAcceleration;
//    if(self.accelMax < userAccel.x){
//        self.accelMax = userAccel.x;
//        [self.unionSq setTitle:@"X" forState:UIControlStateNormal];
//    }
//    if(self.accelMax < userAccel.y){
//        self.accelMax = userAccel.y;
//        [self.unionSq setTitle:@"Y" forState:UIControlStateNormal];
//    }
//    if(self.accelMax < userAccel.z){
//        self.accelMax = userAccel.z;
//        //[self.unionSq setTitle:@"Z" forState:UIControlStateNormal];
//    }
    
    if(userAccel.z > 0.5 && self.startFall == nil) {
        self.startFall = [NSDate date];
        self.startRate = userAccel.z;
    } else if(self.startFall != nil && userAccel.z < 0.5) {
            double fallTime = self.startFall.timeIntervalSinceNow;
            if (self.fallMax > fallTime) {
                self.fallMax = fallTime;
                [self.unionSq setTitle:[NSString stringWithFormat:@"fallMax: %f", self.fallMax] forState:UIControlStateNormal];
                self.accelMax = self.startRate;
            }
            self.startRate = 0;
            self.startFall = nil;
    }
    [self.gravity setProgress:(fabs(self.accelSum))];
    [self.eighthAv setTitle:[NSString stringWithFormat:@"%f", self.accelMax] forState:UIControlStateNormal];
}

- (void)resetAccel
{
    if(self.accelSum > 1.0) {
        self.accelCount++;
        [self.sixthAv setTitle:[NSString stringWithFormat:@"%d", self.accelCount] forState:UIControlStateNormal];
    }
    self.accelSum = 0;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
