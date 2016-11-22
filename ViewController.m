//
//  ViewController.m
//  HJBufferSlider
//
//  Created by WHJ on 2016/11/21.
//  Copyright © 2016年 WHJ. All rights reserved.
//

#import "ViewController.h"
#import "HJBufferSlider.h"

@interface ViewController ()

@property (nonatomic ,strong) HJBufferSlider *bufferSlider;

@property (nonatomic ,assign) CGFloat duration;

@property (nonatomic ,assign) CGFloat bufferDuration;

@end

static CGFloat const maxValue = 50.f;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HJBufferSlider *bufferSlider = [[HJBufferSlider alloc]initWithFrame:CGRectMake(50, 50, 200, 4)];
    [bufferSlider setMinimumValue:0.f];
    [bufferSlider setMaximumValue:maxValue];
    [bufferSlider setMaxBufferTrackColor:[UIColor grayColor]];
    [bufferSlider setBufferTrackColor:[UIColor yellowColor]];
    [bufferSlider setProgressTrackColor:[UIColor greenColor]];
    [self setBufferSlider:bufferSlider];
    [self.view addSubview:bufferSlider];
    
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startBtn setFrame:CGRectMake(100, 100, 44, 44)];
    [startBtn setBackgroundColor:[UIColor greenColor]];
    [startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [startBtn setTitle:@"暂停" forState:UIControlStateSelected];
    [startBtn addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
}


- (void)startAction:(UIButton *)sender{

    sender.selected = !sender.selected;
    if (sender.selected) {
        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(progressAction:) userInfo:nil repeats:YES];
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(bufferAction:) userInfo:nil repeats:YES];
    }
}

- (void)progressAction:(NSTimer *)timer{
    
    if (self.duration<maxValue) {
        ++self.duration;
        [self.bufferSlider setProgressValue:self.duration];
    }else if(self.duration == maxValue){
        self.duration = 0;
        [timer invalidate];
        timer = nil;
    }
    
}

- (void)bufferAction:(NSTimer *)timer{

    if (self.bufferDuration < maxValue){
        ++self.bufferDuration;
        [self.bufferSlider setBufferValue:self.bufferDuration];
    }else if (self.bufferDuration == maxValue){
        self.bufferDuration = 0;
        [timer invalidate];
        timer = nil;
    }
}


@end
