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
    
    
    //[self.motionManager startDeviceMotionUpdates];
    self.motionManager.deviceMotionUpdateInterval = 0.01;
    [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
        CMAcceleration vector = motion.userAcceleration;
        
        double currentTotal = vector.x + vector.y + vector.z;
        self.accelSum += currentTotal;
        
        [self.gravity setProgress:(fabs(currentTotal))];
        [self.eighthAv setTitle:[NSString stringWithFormat:@"%f", currentTotal] forState:UIControlStateNormal];
    }];
    
    
    NSTimer *timer, *timer2;
    //timer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(updateGravity) userInfo:nil repeats:YES];
    timer2 = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(resetAccel) userInfo:nil repeats:YES];
    self.accelCount = 0;
    self.accelMax = 0;
    self.startFall = nil;
    self.startRate = 0;
    self.fallMax = 0;
    self.lastTotal = 0;
    self.stoppedTime = 0;
    self.movingTime = 0;
    self.movementThreshold = 0.070;
    self.errorThreshold = 2.238;
    
    
    
    
    self.sixthAv = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sixthAv.backgroundColor = [UIColor colorWithHue:0.09167 saturation:0.86 brightness:0.78 alpha:1.0];
    self.sixthAv.titleLabel.font = [UIFont boldSystemFontOfSize:36.0];
    [self.sixthAv setFrame:CGRectMake(0, 166, 320, 166)];
    [self.sixthAv setTitle:@"6" forState:UIControlStateNormal];
    [self.sixthAv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.lastDiff = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    [self.lastDiff setFrame:CGRectMake(10, 10, 300, 20)];
    self.movementThresholdSlider = [[UISlider alloc] initWithFrame:CGRectMake(10, 30, 300, 20)];
    [self.movementThresholdSlider setMinimumValue:0];
    [self.movementThresholdSlider setMaximumValue:1];
    [self.movementThresholdSlider setValue:self.movementThreshold];
    [self.movementThresholdSlider addTarget:self action:@selector(movementThresholdSliderChanged:) forControlEvents:UIControlEventValueChanged];
    [self.sixthAv addSubview:self.lastDiff];
    [self.sixthAv addSubview:self.movementThresholdSlider];
    
    self.unionSq = [UIButton buttonWithType:UIButtonTypeCustom];
    self.unionSq.backgroundColor = [UIColor colorWithHue:0.125 saturation:0.86 brightness:0.78 alpha:1.0];
    self.unionSq.titleLabel.font = [UIFont boldSystemFontOfSize:36.0];
    [self.unionSq setFrame:CGRectMake(0, 332, 320, 166)];
    [self.unionSq setTitle:@"U" forState:UIControlStateNormal];
    [self.unionSq setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    self.error = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    [self.error setFrame:CGRectMake(10, 10, 300, 20)];
    self.errorThresholdSlider = [[UISlider alloc] initWithFrame:CGRectMake(10, 30, 300, 20)];
    
    [self.errorThresholdSlider setMinimumValue:0];
    [self.errorThresholdSlider setMaximumValue:10];
    [self.errorThresholdSlider setValue:self.errorThreshold];
    [self.errorThresholdSlider addTarget:self action:@selector(errorThresholdSliderChanged:) forControlEvents:UIControlEventValueChanged];
    [self.unionSq addSubview:self.error];
    [self.unionSq addSubview:self.errorThresholdSlider];
    
    self.thirdAv = [UIButton buttonWithType:UIButtonTypeCustom];
    self.thirdAv.backgroundColor = [UIColor colorWithHue:0.1694 saturation:0.86 brightness:0.78 alpha:1.0];
    self.thirdAv.titleLabel.font = [UIFont boldSystemFontOfSize:36.0];
    [self.thirdAv setFrame:CGRectMake(0, 498, 320, 166)];
    [self.thirdAv setTitle:@"3" forState:UIControlStateNormal];
    [self.thirdAv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.thirdAv addTarget:self action:@selector(copyStats:) forControlEvents:UIControlEventTouchDown];
    
    
    
    [self.scrollView addSubview:self.eighthAv];
    [self.scrollView addSubview:self.sixthAv];
    [self.scrollView addSubview:self.unionSq];
    [self.scrollView addSubview:self.thirdAv];
}

- (void)updateGravity
{
    CMAcceleration vector = self.motionManager.deviceMotion.userAcceleration;
    
    //self.accelSum += (vector.x + vector.y)/4;
    
    double currentTotal = vector.x + vector.y + vector.z;
    double currentDiff = fabs(self.lastTotal - currentTotal);
    //self.lastTotal = currentTotal;
    
    self.accelSum += currentTotal;
    
//    if(self.accelMax < x){
//        self.accelMax = vector.x;
//        [self.unionSq setTitle:@"X" forState:UIControlStateNormal];
//    }
//    if(self.accelMax < vector.y){
//        self.accelMax = vector.y;
//        [self.unionSq setTitle:@"Y" forState:UIControlStateNormal];
//    }
//    if(self.accelMax < vector.z){
//        self.accelMax = vector.z;
//        //[self.unionSq setTitle:@"Z" forState:UIControlStateNormal];
//    }
    
    if(vector.z > 0.5 && self.startFall == nil) {
        self.startFall = [NSDate date];
        self.startRate = vector.z;
    } else if(self.startFall != nil && vector.z < 0.5) {
            double fallTime = self.startFall.timeIntervalSinceNow;
            if (self.fallMax > fallTime) {
                self.fallMax = fallTime;
                //[self.unionSq setTitle:[NSString stringWithFormat:@"fallMax: %f", self.fallMax] forState:UIControlStateNormal];
                self.accelMax = self.startRate;
            }
            self.startRate = 0;
            self.startFall = nil;
    }
    
    
    
    [self.gravity setProgress:(fabs(currentTotal))];
    [self.eighthAv setTitle:[NSString stringWithFormat:@"%f", currentTotal] forState:UIControlStateNormal];
}

- (void)resetAccel
{
    if(self.accelSum > 1.0) {
        self.accelCount++;
        //[self.sixthAv setTitle:[NSString stringWithFormat:@"%d", self.accelCount] forState:UIControlStateNormal];
    }
    
    double currentDiff = fabs(self.accelSum - self.lastTotal);
    
    [self.lastDiff setProgress:currentDiff];
    
    if(currentDiff < self.movementThreshold) {
        self.stoppedTime += 0.5;
        if(self.movingTime <= self.errorThreshold)
            self.stoppedTime += self.movingTime;
        self.movingTime = 0;
        [self.error setProgress:0];
        [self.sixthAv setTitle:@"STOPPED" forState:UIControlStateNormal];
        self.sixthAv.backgroundColor = [UIColor colorWithHue:0.09167 saturation:0.86 brightness:0.78 alpha:1.0];
    }
    else {
        self.movingTime += 0.5;
        if(self.movingTime > self.errorThreshold) {
            if (self.stoppedTime > 8.0) {
                [self.thirdAv setTitle:[NSString stringWithFormat:@"lastStop: %d", (int)self.stoppedTime] forState:UIControlStateNormal];
                UIPasteboard *pb = [UIPasteboard generalPasteboard];
                [pb setString:[NSString stringWithFormat:@"%f", self.stoppedTime]];
            }
            self.stoppedTime = 0;
            [self.error setProgress:0];
        } else {
            [self.error setProgress:(self.movingTime / 10.0)];
        }
        [self.sixthAv setTitle:@"moving" forState:UIControlStateNormal];
        self.sixthAv.backgroundColor = [UIColor colorWithHue:0.02167 saturation:0.86 brightness:0.78 alpha:1.0];
    }
    
    self.lastTotal = self.accelSum;
    self.accelSum = 0;
    
    [self.unionSq setTitle:[NSString stringWithFormat:@"|| %d : %d ->", (int)self.stoppedTime, (int)self.movingTime] forState:UIControlStateNormal];
}

- (void)movementThresholdSliderChanged:(UISlider *)sender {
    self.movementThreshold = sender.value;
    [self.thirdAv setTitle:[NSString stringWithFormat:@"mv: %f", self.movementThreshold] forState:UIControlStateNormal];
}

- (void)errorThresholdSliderChanged:(UISlider *)sender {
    self.errorThreshold = sender.value;
    [self.thirdAv setTitle:[NSString stringWithFormat:@"er: %f", self.errorThreshold] forState:UIControlStateNormal];
}

- (void)copyStats:(UIButton *) sender {
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    [pb setString:self.thirdAv.titleLabel.text];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
