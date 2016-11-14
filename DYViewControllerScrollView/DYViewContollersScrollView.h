//
//  DYViewContollersScrollView.h
//  ViewControllerScorller
//
//  Created by JiangYelin on 2016/11/11.
//  Copyright © 2016年 Rocedar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYViewContollersScrollView : UIView

/**
 所有参与滚动的ViewController
 */
@property(nonatomic,strong)NSArray *viewControllers;

/**
 标题名称
 */
@property(nonatomic,strong)NSArray *titles;

/**
 选中时，按钮文字颜色
 */
@property(nonatomic,strong)UIColor *selectedColor;

/**
 未选中时，按钮文字颜色
 */
@property(nonatomic,strong)UIColor *unSelectedColor;





@end
