//
//  ViewController.m
//  LogSystem
//
//  Created by Thomson on 16/1/27.
//  Copyright © 2016年 Thomson. All rights reserved.
//

#import "ViewController.h"
#import "Log.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    THLogDebug(@"viewDidLoad");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
