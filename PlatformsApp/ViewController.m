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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
