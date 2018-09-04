//
//  XYViewController.m
//  XYPageMaster
//
//  Created by leon0206 on 08/30/2018.
//  Copyright (c) 2018 leon0206. All rights reserved.
//

#import "XYViewController.h"

@interface XYViewController ()

@end

@implementation XYViewController

- (void)handleWithURLAction:(XYUrlAction *)urlAction
{
    NSString *stringValue = [urlAction stringForKey:@"MyStringKey"];
    NSLog(@"-------->%@",stringValue);
    if (urlAction.callBack) {
        urlAction.callBack(@"回调啦～");
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
