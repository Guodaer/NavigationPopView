//
//  GDNavigationController.m
//  GDAutoScroll
//
//  Created by xiaoyu on 16/1/21.
//  Copyright © 2016年 guoda. All rights reserved.
//

#import "GDNavigationController.h"

@interface GDNavigationController ()<UIGestureRecognizerDelegate>


@end

@implementation GDNavigationController

- (instancetype) initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        self.maxAllowedInitialDistance = [UIScreen mainScreen].bounds.size.width;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavigationAlpha_0"] forBarMetrics:0];
//    self.navigationBarHidden = YES;
//    UIButton *view = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 50, 20)];
//    [view setBackgroundImage:[UIImage imageNamed:@"button_back"] forState:UIControlStateNormal];
//    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:view];
//    self.navigationItem.backBarButtonItem = left;
    

    
    self.fullScreenPopGesture = YES;
    if (self.fullScreenPopGesture) {
        id target = self.interactivePopGestureRecognizer.delegate;
        SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:internalAction];
        panGesture.delegate = self;
        [self.view addGestureRecognizer:panGesture];
        panGesture.maximumNumberOfTouches = 1;
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];

}
- (UIViewController *) popViewControllerAnimated:(BOOL)animated {
    return [super popViewControllerAnimated:animated];
}
- (void)didClickBackitem {
    [self popViewControllerAnimated:YES];
}
#pragma mark - Delegate 
- (BOOL) gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    CGPoint beginningLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
    CGFloat maxAllowedInitialDistance = self.maxAllowedInitialDistance;
    if (maxAllowedInitialDistance > 0 && beginningLocation.x > maxAllowedInitialDistance) {
        return NO;
    }
    if (self.childViewControllers.count == 1) {
        return NO;
    }
    if ([[self valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    
    return YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
