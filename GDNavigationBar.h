//
//  GDNavigationBar.h
//  GDAutoScroll
//
//  Created by xiaoyu on 16/1/21.
//  Copyright © 2016年 guoda. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBackItemBlock)();



@interface GDNavigationBar : UIView

@property(nonatomic,copy)ClickBackItemBlock clickBackItemBlock;

@property (nonatomic, strong) UIView *barLine;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *backItem;

- (void)didClickBackItem:(ClickBackItemBlock)clickBlock;



@end
