//
//  ViewController.m
//  DNCardViewDemo
//
//  Created by dawnnnnn on 16/2/20.
//  Copyright © 2016年 dawnnnnn. All rights reserved.
//

#import "ViewController.h"
#import "DNCardView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *cardArr = [[NSMutableArray alloc]init];
    for (int i = 0; i < 5; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"eg_%d.png",i+1]];
        [cardArr addObject:img];
    }
//    NSArray *cardArr = @[[UIColor redColor], [UIColor blueColor], [UIColor yellowColor], [UIColor greenColor], [UIColor grayColor]];
    DNCardView *cards = [[DNCardView alloc]initWithCards:[cardArr copy]];
    [self.view addSubview:cards];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
