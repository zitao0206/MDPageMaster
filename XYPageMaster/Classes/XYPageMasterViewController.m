//
//  XYPageMasterViewController.m
//  XYPageMaster
//
//  Created by lizitao on 2018/6/1.
//

#import "XYPageMasterViewController.h"
#import "XYPageMaster.h"

@interface XYPageMasterViewController ()<UIGestureRecognizerDelegate>
@end

@implementation XYPageMasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    __weak typeof(self) weakSelf = self;
    [XYPageMaster master].navigationContorller.interactivePopGestureRecognizer.delegate = weakSelf;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //页面消失后，把delegate还原
    [XYPageMaster master].navigationContorller.interactivePopGestureRecognizer.delegate = [XYPageMaster master].navigationContorller;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //默认支持侧滑退出，业务继承自定义。
    return YES;
}

- (void)dealloc
{
#if DEBUG
    NSLog(@"XYPageMaster---->%@ dealloc!",NSStringFromClass([self class]));
#endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
