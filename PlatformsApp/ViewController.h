//
//  ViewController.h
//  PlatformsApp
//
//  Created by David Mazza on 3/31/13.
//  Copyright (c) 2013 David Mazza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIButton *eighthAv;
@property (strong, nonatomic) IBOutlet UIButton *sixthAv;
@property (strong, nonatomic) IBOutlet UIButton *unionSq;
@property (strong, nonatomic) IBOutlet UIButton *thirdAv;
@property (strong, nonatomic) UIProgressView *gravity;
@property (strong, nonatomic) CMMotionManager *motionManager;

@property (strong, nonatomic) NSDate *startFall;

@property double accelSum;
@property double accelMax;
@property double fallMax;
@property double startRate;
@property double lastTotal;
@property double stoppedTime;
@property int accelCount;
@end
