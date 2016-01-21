//
//  GDNavigationBar.m
//  GDAutoScroll
//
//  Created by xiaoyu on 16/1/21.
//  Copyright © 2016年 guoda. All rights reserved.
//

#import "GDNavigationBar.h"

#define GDWidth ([UIScreen mainScreen].bounds.size.width)


@implementation GDNavigationBar

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializeUI];//初始化UI
    }
    
    return self;
}
-(instancetype)init
{
    return [self initWithFrame:CGRectZero];
}
- (void)initializeUI {
    self.frame = CGRectMake(0, 0, GDWidth, 64);
    self.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1.00];
    
    self.barLine = [UIView new];
    self.barLine.frame = CGRectMake(0, 63, GDWidth, 1);
    self.barLine.backgroundColor = [UIColor colorWithWhite:0.639 alpha:1];
    [self addSubview:self.barLine];
    //返回按钮
//    self.backItem =[UIButton buttonWithType:UIButtonTypeCustom];
//    self.backItem.frame = CGRectMake(10, 20, 30, 44);
//    [self.backItem setImage:[UIImage imageNamed:@"button_back"] forState:UIControlStateNormal];
//    [self.backItem addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:self.backItem];
    
    //title
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(GDWidth /2 -50, 20, 100, 43)];
    self.titleLabel.text = self.title;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self addSubview:self.titleLabel];
    
    
    
    
}
//返回按钮
- (void)popViewController {
    if (self.clickBackItemBlock) {
        self.clickBackItemBlock();
    }
}
- (void)didClickBackItem:(ClickBackItemBlock)clickBlock {

    self.clickBackItemBlock = clickBlock;
}
- (void)setTitle:(NSString *)title {
    _title = title;
    if (!title) {
        _titleLabel.text = @"";
        return;
    }
    if ([title isEqualToString:_titleLabel.text]) {
        return;
    }
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    _titleLabel.text = title;
    [self setNeedsDisplay];
}
@end
