//
//  GDNavigationController.m
//  GDAutoScroll
//
//  Created by xiaoyu on 16/1/21.
//  Copyright © 2016年 guoda. All rights reserved.
//

#import "GDNavigationController.h"
#import "GDNavigationBar.h"
#import <objc/runtime.h>


@interface UIViewController (GDNavigation)

@property (nonatomic, strong) GDNavigationBar *navigatonBar;

@property (nonatomic, getter=isNavigationBar) BOOL navigationBarHidden;

@property (nonatomic, copy) NSString *title;

@end

@implementation UIViewController (GDNavigation)

@dynamic navigatonBar;
@dynamic navigationBarHidden;
@dynamic title;

- (GDNavigationBar *)navigatonBar {

    return objc_getAssociatedObject(self, _cmd);
}
- (void)setnavigationBar:(GDNavigationBar *)navigationBar {

    objc_setAssociatedObject(self, @selector(navigatonBar), navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isNavigationBar {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setNavigationBarHidden:(BOOL)navigationBarHidden {
    objc_setAssociatedObject(self, @selector(isNavigationBar), @(navigationBarHidden), OBJC_ASSOCIATION_ASSIGN);
}
- (NSString *)title {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setTitle:(NSString *)title {

    objc_setAssociatedObject(self, @selector(title), title, OBJC_ASSOCIATION_COPY);
}
@end



@interface GDNavigationController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) GDNavigationBar *rootNavigationBar;

@end

@implementation GDNavigationController

- (instancetype) initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithRootViewController:rootViewController]) {
        self.maxAllowedInitialDistance = [UIScreen mainScreen].bounds.size.width;
//        NSLog(@"66");
    }
    return self;
}
-(instancetype)init
{
    if (self = [super init]) {
        //默认触屏最大范围  全屏
        self.maxAllowedInitialDistance = [UIScreen mainScreen].bounds.size.width;
//        NSLog(@"75");
    }
    return self;
}
- (void)loadView {
    [super loadView];
    
    self.navigationBarHidden = YES;
    
    self.rootNavigationBar = [[GDNavigationBar alloc] init];
    
//    [self.rootNavigationBar didClickBackItem:^{
//        [self didClickBackitem];
//
//    }];
    self.rootNavigationBar.title = self.topViewController.title;
    [self.topViewController.view addSubview:self.rootNavigationBar];
    
    NSLog(@"%ld",self.childViewControllers.count);
    
    if (self.childViewControllers.count == 1) {
        self.rootNavigationBar.backItem.hidden = YES;
    }
    
    self.fullScreenPopGesture = YES;
    if (self.fullScreenPopGesture) {
        NSLog(@"22222");
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
    GDNavigationBar *naviBar = [[GDNavigationBar alloc] init];
    
//    [naviBar didClickBackItem:^{
//        [self didClickBackitem];
//    }];
    [viewController.view addSubview:naviBar];
    
    if (viewController.navigationBarHidden) {
        naviBar.hidden = YES;
    }
    naviBar.title = viewController.title;
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
