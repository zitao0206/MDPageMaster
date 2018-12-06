//
//  XYHomeTabViewController.m
//  XYPageMaster_Example
//
//  Created by lizitao on 2018/8/30.
//  Copyright © 2018年 leon0206. All rights reserved.
//

#import "XYHomeTabViewController.h"
#import "XYPageMaster.h"

#define  MyStringKey  @"MyStringKey"

@interface XYHomeTabViewController ()

@end

@implementation XYHomeTabViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIViewController * vc1 = [[UIViewController alloc]init];
    vc1.tabBarItem.title = @"推荐";
    vc1.tabBarItem.image = [UIImage imageNamed:@"cat"];
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"dog"];
    vc1.view.backgroundColor = [UIColor greenColor];
     [self addChildViewController:vc1];
    
    UIViewController * vc2 = [[UIViewController alloc]init];
    vc2.tabBarItem.title = @"关注";
    vc2.tabBarItem.image = [UIImage imageNamed:@"chicken"];
    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"butterfly"];
    vc2.view.backgroundColor = [UIColor blueColor];
    [self addChildViewController:vc2];
    
    UIViewController * vc3 = [[UIViewController alloc]init];
    vc3.tabBarItem.title = @"我";
    vc3.tabBarItem.image = [UIImage imageNamed:@"dog"];
    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"cat"];
    vc3.view.backgroundColor = [UIColor greenColor];
    [self addChildViewController:vc3];
    
    
    UIButton *helloBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 50)];
    helloBtn1.backgroundColor = [UIColor redColor];
    [helloBtn1 setTitle:@"跳转入口1" forState:UIControlStateNormal];
    [helloBtn1 addTarget:self action:@selector(jumpTo1) forControlEvents:UIControlEventTouchUpInside];
    [vc1.view addSubview:helloBtn1];
   
    
    UIButton *helloBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 200, 50)];
    helloBtn2.backgroundColor = [UIColor redColor];
    [helloBtn2 setTitle:@"跳转入口2" forState:UIControlStateNormal];
    [helloBtn2 addTarget:self action:@selector(jumpTo2) forControlEvents:UIControlEventTouchUpInside];
    [vc1.view addSubview:helloBtn2];
}

- (void)jumpTo1
{
    [[XYPageMaster master] openUrl:@"xiaoying://testVC" action:^(XYUrlAction *action) {
      
        [action setString:@"hello world" forKey:MyStringKey];
        action.callBack = ^(id result) {
            NSLog(@"result: %@",result);
        };
    }];
}

- (void)jumpTo2
{
    [[XYPageMaster master] openUrl:@"xiaoying://testVC" action:^(XYUrlAction *action) {
        
        XYNaviTransition *naviTransiton = [XYNaviTransition new];
        naviTransiton.animation = XYNaviAnimationTransition;
        naviTransiton.transition.timingFunction =  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        naviTransiton.transition.type = kCATransitionFade;
        naviTransiton.transition.duration = 0.3;
        naviTransiton.transition.fillMode = kCAFillModeForwards;
        action.naviTransition = naviTransiton;
        [action setString:@"hello world" forKey:MyStringKey];
        action.callBack = ^(id result) {
            NSLog(@"result: %@",result);
        };
    }];
}


@end
