//
//  ViewController.m
//  ViewControllerScorller
//
//  Created by Aaron on 2016/11/11.
//  Copyright © 2016年 Aaron. All rights reserved.
//

#import "ViewController.h"

#import "DYViewContollersScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DYViewContollersScrollView *vcScrollView = [[DYViewContollersScrollView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    vcScrollView.backgroundColor = [UIColor whiteColor];
    vcScrollView.titles = (NSMutableArray *)@[@"运动计步",@"血糖检测",@"血压检测",@"体重体脂",@"abc",@"123",@"!@#"];
    
    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 0; i < vcScrollView.titles.count; i ++) {
        
        UIViewController *vc = [UIViewController new];
        
        vc.view.backgroundColor = i % 2 ? [UIColor grayColor] :[UIColor yellowColor];
        [arr addObject:vc];
    }
    
    vcScrollView.viewControllers = arr;
    [self.view addSubview:vcScrollView];
    
}


- (UIColor *) getColor: (NSString *)hexColro {
    unsigned int red, green, blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[hexColro substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[hexColro substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[hexColro substringWithRange:range]] scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:1.0f];
}



@end
