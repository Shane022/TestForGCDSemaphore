//
//  ViewController.m
//  TestForGCDSemaphore
//
//  Created by dvt04 on 16/11/10.
//  Copyright © 2016年 suma. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     dispatch_semaphore_t signal = dispatch_semaphore_create(0);
     
     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     NSLog(@"start");
     sleep(5);
     dispatch_semaphore_signal(signal);
     });
     
     NSLog(@"wait");
     dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
     NSLog(@"finish");*/
    
    dispatch_queue_t testQueue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    // 创建并设置信量
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    dispatch_async(testQueue, ^{
        NSLog(@"start");
    });
    
    dispatch_barrier_async(testQueue, ^{
        NSLog(@"dispatch_barrier_async");
    });
    
    // 线程A
    dispatch_async(testQueue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"A");
        [NSThread sleepForTimeInterval:5];
        dispatch_semaphore_signal(semaphore);
    });
    
    // 线程B
    dispatch_async(testQueue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"B");
        dispatch_semaphore_signal(semaphore);
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
