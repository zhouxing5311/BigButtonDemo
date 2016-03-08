//
//  BigButton.m
//  一两理财
//
//  Created by 周兴 on 16/03/07.
//  Copyright © 2015年 renrunkeji. All rights reserved.


#import "BigButton.h"

@implementation BigButton

- (instancetype)init {
    if (self = [super init]) {
        [self initBigbutton];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initBigbutton];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame buttonImage:(UIImage *)buttonImage touchImage:(UIImage *)touchImage buttonTitle:(NSString *)buttonTitle {
    if (self = [super initWithFrame:frame]) {
        _title = buttonTitle;
        _image = buttonImage;
        _touchImage = touchImage;
        self.buttonImage.image = self.image; //图片信息
        self.titleLabel.text = self.title; //文本信息
        self.touchView.image = touchImage; //点击显示的图片
        [self initBigbutton];
    }
    return self;
}

- (void)initBigbutton {
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    [self addSubview:self.buttonView];
    [self.buttonView addSubview:self.buttonImage];
    [self.buttonView addSubview:self.titleLabel];
    [self addSubview:self.touchView];
    _touchView.hidden = YES; //默认隐藏
}

#pragma mark -Set
- (void)setHeightPercent:(CGFloat)heightPercent {
    if (_heightPercent != heightPercent) {
        _heightPercent = heightPercent;
        [self setNeedsDisplay];
    }
}

- (void)setImage:(UIImage *)image {
    if (_image != image) {
        _image = image;
        self.buttonImage.image = image;
        [self setNeedsDisplay];
    }
}

- (void)setTitle:(NSString *)title {
    if (_title != title) {
        _title = title;
        self.titleLabel.text = title;
        [self setNeedsDisplay];
    }
}

- (void)setImageCornerRadius:(CGFloat)imageCornerRadius {
    if (_imageCornerRadius != imageCornerRadius) {
        _imageCornerRadius = imageCornerRadius;
        self.buttonImage.layer.cornerRadius = imageCornerRadius;
        self.buttonImage.layer.masksToBounds = YES;
    }
}

- (void)setImageBorderWidth:(CGFloat)imageBorderWidth {
    if (_imageBorderWidth != imageBorderWidth) {
        _imageBorderWidth = imageBorderWidth;
        self.buttonImage.layer.borderWidth = imageBorderWidth;
        self.buttonImage.layer.masksToBounds = YES;
    }
}

- (void)setImageBorderColor:(UIColor *)imageBorderColor {
    if (_imageBorderColor != imageBorderColor) {
        _imageBorderColor = imageBorderColor;
        self.buttonImage.layer.borderColor = imageBorderColor.CGColor;
        self.buttonImage.layer.masksToBounds = YES;
    }
}

- (void)setButtontype:(BigButtonType)buttontype {
    if (_buttontype != buttontype) {
        _buttontype = buttontype;
        [self setNeedsDisplay];
    }
}

- (void)setTouchColor:(UIColor *)touchColor {
    if (_touchColor != touchColor) {
        _touchColor = touchColor;
        self.touchView.backgroundColor = touchColor;
        [self setNeedsDisplay];
    }
}

- (void)setTouchImage:(UIImage *)touchImage {
    if (_touchImage != touchImage) {
        _touchImage = touchImage;
        self.touchView.image = touchImage;
        [self setNeedsDisplay];
    }
}

#pragma mark -Get
- (UIView *)buttonView {
        if (!_buttonView) {
        _buttonView = [[UIView alloc] init];
        _buttonView.backgroundColor = [UIColor clearColor];        
        _buttonView.userInteractionEnabled = NO;
    }
    return _buttonView;
}

- (UIImageView *)buttonImage {
    if (!_buttonImage) {
        _buttonImage = [[UIImageView alloc] init];
        _buttonImage.contentMode = UIViewContentModeScaleAspectFill; //原比例，多余部分被裁减
    }
    return _buttonImage;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UIImageView *)touchView {
    if (!_touchView) {
        _touchView = [[UIImageView alloc] init];
        _touchView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3];
        _touchView.contentMode = UIViewContentModeScaleAspectFill; //原比例，多余部分被裁减
    }
    return _touchView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (_buttontype != BigButtonTypeNormalWithoutTouch && _buttontype != BigButtonTypeRoundWithoutTouch) {
        _touchView.hidden = NO;
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    if (_touchView.hidden == NO) {
        _touchView.hidden = YES;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    if (_touchView.hidden == NO) {
        _touchView.hidden = YES;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self initUI];
}

- (void)initUI {
    
    //设置点击效果的黑色半透明view
    _touchView.frame = CGRectMake(0, 0, SELFWIDTH, SELFHEIGHT);
    
    //默认图片和label视图占BigButton高度的3/4
    CGFloat buttonViewHeight = 0;
    
    if (_heightPercent > 0 && _heightPercent <= 1.0) {
        buttonViewHeight = SELFHEIGHT * _heightPercent;
    } else {
        buttonViewHeight = SELFHEIGHT * 0.75;
    }
    
    //设置buttonView frame
    _buttonView.frame = CGRectMake(0, (SELFHEIGHT - buttonViewHeight) / 2, SELFWIDTH, buttonViewHeight);
    
    CGFloat imageYLabel = buttonViewHeight * (1 / 12.0); //图片和label的距离
    CGFloat buttonImageHeight = buttonViewHeight * (9 / 12.0); //图片高度（宽度一样）
    CGFloat buttonLabelHeight = buttonViewHeight * (2 / 12.0); //文字高度（宽度和按钮一样）
    
    if (buttonLabelHeight < 15.0) {
        buttonLabelHeight = 15.0; //最小为10，否则可能文字显示不全
    }
    
    //图片坐标
    CGFloat buttonImageWidth = buttonImageHeight * (_image.size.width / _image.size.height);
    if (buttonImageWidth > _buttonView.frame.size.width) {
        _buttonImage.frame = CGRectMake(0, 0, _buttonView.frame.size.width, _buttonView.frame.size.width * (_image.size.height / _image.size.width));
    } else {
        _buttonImage.frame = CGRectMake(0, 0, buttonImageWidth, buttonImageHeight);
    }
    _buttonImage.center = CGPointMake(_buttonView.frame.size.width / 2.0, buttonImageHeight / 2.0);
    if (_buttontype == BigButtonTypeRound || _buttontype == BigButtonTypeRoundWithoutTouch) {
        CGFloat squareWidth = _buttonImage.frame.size.width < _buttonImage.frame.size.height?_buttonImage.frame.size.width:_buttonImage.frame.size.height;
        _buttonImage.frame = CGRectMake(0, 0, squareWidth, squareWidth);
        _buttonImage.center = CGPointMake(_buttonView.frame.size.width / 2.0, buttonImageHeight / 2.0);
        _buttonImage.layer.cornerRadius = squareWidth / 2.0;
        _buttonImage.layer.masksToBounds = YES;
    }
    
    //文字坐标
    _titleLabel.frame = CGRectMake(0, buttonImageHeight + imageYLabel, SELFWIDTH, buttonLabelHeight);

}

@end
