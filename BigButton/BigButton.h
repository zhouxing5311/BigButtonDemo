//
//  BigButton.h
//  一两理财
//
//  Created by 周兴 on 16/03/07.
//  Copyright © 2015年 renrunkeji. All rights reserved.


#import <UIKit/UIKit.h>

#define SELFWIDTH self.frame.size.width
#define SELFHEIGHT self.frame.size.height

typedef NS_ENUM(NSInteger, BigButtonType) {
    
    BigButtonTypeNormal = 0,                         //正常状态
    BigButtonTypeNormalWithoutTouch,                 //正常状态不显示点击出现的view
    BigButtonTypeRound,                              //内置图标圆角
    BigButtonTypeRoundWithoutTouch                   //内置图标圆角不显示点击出现的view
    
};

@interface BigButton : UIControl

//按钮样式
@property (nonatomic, assign)BigButtonType buttontype; /**<图标方形normal和图标圆形round及不显示touchView*/

@property (nonatomic, strong)UIView *buttonView; //将标题Label和图标图片整合到一起便于布局

//图标相关
@property (nonatomic, strong)UIImageView *buttonImage; //图标
@property (nonatomic, strong)UIImage *image; /**<图标图片*/
@property (nonatomic, assign)CGFloat imageCornerRadius; /**<默认为0，round时为图片半径*/
@property (nonatomic, assign)CGFloat imageBorderWidth; /**<border宽度*/
@property (nonatomic, strong)UIColor *imageBorderColor; /**<内置图片border颜色*/

//标题相关
@property (nonatomic, strong)UILabel *titleLabel; //标题
@property (nonatomic, copy)NSString *title; /**<文字标题*/

//点击视图相关
@property (nonatomic, strong)UIImageView *touchView; //点击显示的view
@property (nonatomic, strong)UIImage *touchImage; /**<选中时显示的图片*/
@property (nonatomic, strong)UIColor *touchColor; /**<按钮被点击时显示的提示颜色，默认为黑色半透明*/

//buttonView占自身高度百分比
@property (nonatomic, assign)CGFloat heightPercent; /**<buttonView占bigButton高度的百分比(默认0.75)*/

/**直接初始化按钮样式和点击显示图片，如果点击图片或背景不显示，可能由于将按钮加在UIScrollView上，默认点击事件被UIScrollView接受，将UIScrollView的delaysContentTouches属性设为NO即可。
 **/
- (instancetype)initWithFrame:(CGRect)frame buttonImage:(UIImage *)buttonImage touchImage:(UIImage *)touchImage buttonTitle:(NSString *)buttonTitle;



@end
