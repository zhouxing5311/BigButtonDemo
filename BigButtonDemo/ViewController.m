//
//  ViewController.m
//  BigButtonDemo
//
//  Created by 周兴 on 16/3/7.
//  Copyright © 2016年 周兴. All rights reserved.
//

#import "ViewController.h"
#import "BigButton.h"

@interface ViewController ()

@end

@implementation ViewController
{

    NSMutableArray *buttons;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:244 / 255.0 green:180 / 255.0 blue:230 / 255.0 alpha:1];
    [self createButton];
    
}

- (void)createButton {
    
    buttons = [NSMutableArray array];
    for (NSInteger i = 0; i < 6; i++) {
        BigButton *button = [[BigButton alloc] init];
        button.image = [UIImage imageNamed:@"normal"];
        button.tag = i;
        [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        if (i == 0) {
            button.buttontype = BigButtonTypeNormal; //正常状态
            button.title = @"默认状态";
        } else if (i == 1) {
            button.buttontype = BigButtonTypeNormalWithoutTouch; //无点击视图
            button.backgroundColor = [UIColor orangeColor];
            button.title = @"正常无点击";
            button.titleLabel.textColor = [UIColor whiteColor];
            button.heightPercent = 0.5; //图标和label占高度百分百
        } else if (i == 2) {
            button.buttontype = BigButtonTypeRound; //圆角
            button.backgroundColor = [UIColor yellowColor];
            button.titleLabel.textColor = [UIColor redColor];
            button.title = @"圆角状态";
            button.touchColor = [UIColor lightGrayColor]; //点击颜色可自定义
        } else if (i == 3) {
            button.buttontype = BigButtonTypeRoundWithoutTouch; //圆角无点击视图
            button.backgroundColor = [UIColor greenColor];
            button.titleLabel.font = [UIFont systemFontOfSize:16];
            button.titleLabel.textColor = [UIColor purpleColor];
            button.title = @"圆角无点击";
        } else if (i == 4) {
            button.buttontype = BigButtonTypeNormal;
            button.backgroundColor = [UIColor brownColor];
            button.touchImage = [UIImage imageNamed:@"touch"];
            button.titleLabel.textColor = [UIColor greenColor];
            button.title = @"点击视图自定";
        } else {
            button.buttontype = BigButtonTypeNormal;
            button.backgroundColor = [UIColor purpleColor];
            button.titleLabel.textColor = [UIColor whiteColor];
            button.title = @"圆角自定";
            button.imageBorderColor = [UIColor greenColor];
            button.imageBorderWidth = 1;
            button.imageCornerRadius = 10;
        }
        
        
        [buttons addObject:button];
    }
    
    [self initUI];
}

- (void)initUI {
    for (NSInteger i = 0; i < buttons.count; i++) {
        BigButton *temp = buttons[i];
        CGFloat xcrack = 15;
        CGFloat viewWidth = self.view.frame.size.width;
        if (i < 3) {
            temp.frame = CGRectMake(i * xcrack + ((viewWidth - xcrack * 2) / 3.0) * i,60,((viewWidth - xcrack * 2) / 3.0),150);
        }
        if (i>=3 && i<6) {
            temp.frame = CGRectMake((i - 3) * xcrack + ((viewWidth - xcrack * 2) / 3.0) * (i - 3),240,((viewWidth - xcrack * 2) / 3.0),150);
        }
    }
}

- (void)action:(UIButton *)button {
    NSLog(@"第%li个按钮被点击了",button.tag);
}


@end
