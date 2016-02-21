//
//  ViewController.m
//  DCCardAnimationDemo
//
//  Created by dawnnnnn on 16/2/20.
//  Copyright © 2016年 dawnnnnn. All rights reserved.
//

#import "ViewController.h"
#import "DCAnimationCards.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    NSArray *cardArr = @[[UIColor redColor], [UIColor blueColor], [UIColor yellowColor], [UIColor greenColor], [UIColor grayColor]];
    DCAnimationCards *cards = [[DCAnimationCards alloc]initWithCards:cardArr];
//    [cards show];
    [self.view addSubview:cards];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
