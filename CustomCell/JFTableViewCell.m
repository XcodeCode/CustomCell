//
//  JFTableViewCell.m
//  CustomCell
//
//  Created by 靳峰 on 16/2/19.
//  Copyright © 2016年 靳峰. All rights reserved.
//

#import "JFTableViewCell.h"

@interface JFTableViewCell ()<UIScrollViewDelegate>
@property(nonatomic,strong) UIScrollView *scoll;
@property(nonatomic,assign) CGFloat width;
@property(nonatomic,assign) BOOL isOpen;
//@property(nonatomic,assign) BOOL isScrollEnd;
@end

@implementation JFTableViewCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    //不要添加在contentView上
    [self addSubview:self.scoll];
    return self;
}
//设置按钮个数以及title
-(void)setButtonCount:(int)count btnTitle:(NSArray *)titleArr;
{
    for (int i = 0; i<count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.backgroundColor =  [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
        btn.tag =1;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn sizeToFit];
        
        CGFloat btnX;
        btnX += btn.bounds.size.width+40;
        btn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - btnX, 0, btn.bounds.size.width+40, self.bounds.size.height);
        [self addSubview:btn];
        self.width += btn.bounds.size.width;
        
    }

    self.scoll.contentSize = CGSizeMake(self.width+[UIScreen mainScreen].bounds.size.width, 44);
    [self bringSubviewToFront:self.scoll];
}

-(void)btnClick:(UIButton *)btn
{

}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

    //超过一定距离自动打开
    if (scrollView.contentOffset.x>=100 && self.isOpen == NO) {
//            self.isScrollEnd = NO;
        CGPoint point = CGPointMake(self.width, 0);
        self.scoll.contentOffset = point;
        self.isOpen = YES;
//        NSLog(@"11111111111111");
    //打开后,任意右滑关闭
    }else if (scrollView.contentOffset.x <= self.width && self.isOpen == YES){
//            self.isScrollEnd = NO;
        self.scoll.contentOffset = CGPointMake(0, 0);
//        self.isOpen = NO;
//        NSLog(@"2222222222222222");
    //未打开未到达执行区域,自动关闭
    }else if (scrollView.contentOffset.x<100 && self.isOpen == NO ){
//            self.isScrollEnd = NO;
        self.scoll.contentOffset = CGPointMake(0, 0);
//        NSLog(@"333333333333333333---%@",NSStringFromCGPoint(self.scoll.contentOffset));
    }
//     NSLog(@"%s",__func__);
//    self.isScrollEnd = YES;
}

#pragma mark - 懒加载
-(UIScrollView *)scoll
{
    if (_scoll == nil) {
        _scoll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.bounds.size.height)];
        _scoll.bounces = NO;

        UIView *v = [[UIView alloc] initWithFrame:_scoll.bounds];
        v.backgroundColor = [UIColor orangeColor];
        _scoll.contentSize = CGSizeMake(800, 0);
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44) ];
        label.text = [NSString stringWithFormat:@"%d",arc4random_uniform(100)];
        [v addSubview:label];
        
        _scoll.showsHorizontalScrollIndicator = NO;
        _scoll.delegate = self;
        [_scoll addSubview:v];
    }
    return _scoll;
}

@end
