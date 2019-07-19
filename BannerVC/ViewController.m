//
//  ViewController.m
//  BannerVC
//
//  Created by csj on 2019/7/19.
//  Copyright © 2019 csj. All rights reserved.
//

#import "ViewController.h"
#import "BannerVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)goPage:(id)sender {
    BannerVC *banVC = [[BannerVC alloc] init];
    [self presentViewController:banVC animated:YES completion:nil];
}

@end
