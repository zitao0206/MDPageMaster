//
//  MDPageMasterViewController.m
//  MDPageMaster
//
//  Created by zitao0206 on 2018/6/1.
//

#import "MDPageMasterViewController.h"
#import "MDPageMaster.h"

@interface MDPageMasterViewController ()<UIGestureRecognizerDelegate>
@end

@implementation MDPageMasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    __weak typeof(self) weakSelf = self;
    [MDPageMaster master].navigationContorller.interactivePopGestureRecognizer.delegate = weakSelf;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //页面消失后，把delegate还原
    [MDPageMaster master].navigationContorller.interactivePopGestureRecognizer.delegate = [MDPageMaster master].navigationContorller;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // Default support for side-swipe exit, business inheritance customization.
    return YES;
}

- (void)dealloc
{
#if DEBUG
    NSLog(@"MDPageMaster---->%@ dealloc!",NSStringFromClass([self class]));
#endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
