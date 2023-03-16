#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "MDPageMaster.h"
#import "MDPageMasterNavigationController.h"
#import "MDPageMasterViewController.h"
#import "MDUrlAction.h"
#import "NSURL+MDPageMaster.h"
#import "UIViewController+MDPageMaster.h"

FOUNDATION_EXPORT double MDPageMasterVersionNumber;
FOUNDATION_EXPORT const unsigned char MDPageMasterVersionString[];

