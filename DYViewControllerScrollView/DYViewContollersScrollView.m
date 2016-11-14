//
//  DYViewContollersScrollView.m
//  ViewControllerScorller
//
//  Created by JiangYelin on 2016/11/11.
//  Copyright © 2016年 Rocedar. All rights reserved.
//

#import "DYViewContollersScrollView.h"

//当前View的宽
#define SELF_W CGRectGetWidth(self.frame)
//当前View的高
#define SELF_H CGRectGetHeight(self.frame)

//顶部标题的高
#define TITLE_BTN_SCROLLVIEW_H 50
//顶部标题的宽
#define TITLE_BTN_SCROLLVIEW_W SELF_W

//滚动标示线的宽
#define SCROll_LINE_W TITLE_BTN_W
//滚动标示线的高
#define SCROll_LINE_H 2

//顶部每个Btn的宽
#define TITLE_BTN_W BOTTOM_SCROLLVIEW_W / (self.titles.count > 4 ? 4 : self.titles.count)
//顶部每个Btn的高
#define TITLE_BTN_H TITLE_BTN_SCROLLVIEW_H - SCROll_LINE_H

//底部ScrollView的宽
#define BOTTOM_SCROLLVIEW_W SELF_W
//底部ScrollView的高
#define BOTTOM_SCROLLVIEW_H SELF_H - TITLE_BTN_SCROLLVIEW_H

@interface DYViewContollersScrollView ()<UIScrollViewDelegate>
{
    
}

/**
 存放顶部按钮的ScrollView
 */
@property(nonatomic,strong)UIScrollView *titleBtnScrollView;

/**
 存放底部VC的ScrollView
 */
@property(nonatomic,strong)UIScrollView *vcScrollView;

/**
 按钮底部滚动线
 */
@property(nonatomic,strong)UIView *scrollLineView;

/**
 存放所有Btn的数组
 */
@property(nonatomic,strong)NSMutableArray *allBtns;

@end

@implementation DYViewContollersScrollView

#pragma mark - Init
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.titles &&
        self.viewControllers &&
        self.titles.count == self.viewControllers.count) {
        
        [self addSubview:self.titleBtnScrollView];
        [self addSubview:self.vcScrollView];
        [self.titleBtnScrollView addSubview:self.scrollLineView];
        
        //设置 contentSize
        self.titleBtnScrollView.contentSize = CGSizeMake(TITLE_BTN_W * self.titles.count,
                                                         TITLE_BTN_SCROLLVIEW_H);
        self.vcScrollView.contentSize = CGSizeMake(BOTTOM_SCROLLVIEW_W * self.viewControllers.count,
                                                   BOTTOM_SCROLLVIEW_H);
        
        self.allBtns = [NSMutableArray new];
        
        for (int i = 0; i < self.titles.count; i++) {
            
            //添加Title Btn
            UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [titleBtn setTitle:self.titles[i] forState:UIControlStateNormal];
            titleBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
            titleBtn.backgroundColor = [self getColor:@"ffffff"];
            titleBtn.tag = i;
            [titleBtn addTarget:self action:@selector(titleBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
            titleBtn.frame = CGRectMake(TITLE_BTN_W * i, 0, TITLE_BTN_W, TITLE_BTN_H);
            [self.titleBtnScrollView addSubview:titleBtn];
            [self.allBtns addObject:titleBtn];
            
            //添加VC.View
            UIViewController *vc = self.viewControllers[i];
            vc.view.frame = CGRectMake(BOTTOM_SCROLLVIEW_W * i, 0, BOTTOM_SCROLLVIEW_W, BOTTOM_SCROLLVIEW_H);
            [self.vcScrollView addSubview:vc.view];
            
        }
        
        [self changeTitleColorForBtn:self.allBtns[0]];
    
    } else {
        NSLog(@"----检查属性 titles 或者 viewControllers 传入是否正确----");
    }
    
}

#pragma mark - TitleBtnTapped
- (void)titleBtnTapped:(UIButton *)btn {
    [self changeTitleColorForBtn:btn];
    float btnX = CGRectGetMinX(btn.frame);
    
    [UIView animateWithDuration:0.7 animations:^{
        self.scrollLineView.transform = CGAffineTransformMakeTranslation(btnX, 0);
    }];
    NSInteger tag = btn.tag;
    [self.vcScrollView scrollRectToVisible:CGRectMake(BOTTOM_SCROLLVIEW_W * tag, 0, BOTTOM_SCROLLVIEW_W, BOTTOM_SCROLLVIEW_H) animated:NO];
}

#pragma mark - ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([scrollView isEqual:self.vcScrollView]) {
        //获取X方向上总的偏移量
        float contentOffsetX = scrollView.contentOffset.x;
        //变换 scrollLineView的位置
        self.scrollLineView.transform = CGAffineTransformMakeTranslation(contentOffsetX * (TITLE_BTN_W * 1.0 / BOTTOM_SCROLLVIEW_W), 0);
        //获取 scrollLineView在本View上的位置
        CGRect scrollLineViewInScreen = [self.scrollLineView.superview convertRect:self.scrollLineView.frame toView:self];
        //查看是否越界
        BOOL contains = CGRectContainsRect(self.frame, scrollLineViewInScreen);
        //如果越界，滚动
        if (!contains) {
            [self.titleBtnScrollView scrollRectToVisible:self.scrollLineView.frame animated:YES];
        }
        //获取第几页
        NSInteger index = contentOffsetX / BOTTOM_SCROLLVIEW_W;
        //改变Btn title颜色
        [self changeTitleColorForBtn:self.allBtns[index]];
        
    } else if ([scrollView isEqual:self.titleBtnScrollView]) {

    }
}


#pragma mark - Method
- (void)changeTitleColorForBtn:(UIButton *)btn {
    for (UIButton *tmpBtn in self.allBtns) {
        if ([tmpBtn isEqual:btn]) {
            [tmpBtn setTitleColor:self.selectedColor forState:UIControlStateNormal];
        } else {
            [tmpBtn setTitleColor:self.unSelectedColor forState:UIControlStateNormal];
        }
    }
}


#pragma mark - Property
- (UIColor *)selectedColor {
    if (!_selectedColor) {
        _selectedColor = [self getColor:@"7c59c4"];
    }
    
    return _selectedColor;
}

- (UIColor *)unSelectedColor {
    if (!_unSelectedColor) {
        _unSelectedColor = [self getColor:@"333333"];
        
    }
    return _unSelectedColor;
}


#pragma mark - LazyLoad

- (UIScrollView *)titleBtnScrollView {
    if (!_titleBtnScrollView) {
        _titleBtnScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                             0,
                                                                             TITLE_BTN_SCROLLVIEW_W,
                                                                             TITLE_BTN_SCROLLVIEW_H)];
        _titleBtnScrollView.delegate = self;
//        _titleBtnScrollView.pagingEnabled = YES;
        _titleBtnScrollView.showsVerticalScrollIndicator = NO;
        _titleBtnScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _titleBtnScrollView;
}

- (UIScrollView *)vcScrollView {
    if (!_vcScrollView) {
        _vcScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                       TITLE_BTN_SCROLLVIEW_H,
                                                                       BOTTOM_SCROLLVIEW_W,
                                                                       BOTTOM_SCROLLVIEW_H)];
        _vcScrollView.delegate = self;
        _vcScrollView.pagingEnabled = YES;
        _vcScrollView.showsVerticalScrollIndicator = NO;
        _vcScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _vcScrollView;
  
}

- (UIView *)scrollLineView {
    if (!_scrollLineView) {
        _scrollLineView = [[UIView alloc] initWithFrame:CGRectMake(0, TITLE_BTN_H, SCROll_LINE_W, SCROll_LINE_H)];
        _scrollLineView.backgroundColor = self.selectedColor;
    }
    return _scrollLineView;
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
