//
//  JFTableViewCell.h
//  CustomCell
//
//  Created by 靳峰 on 16/2/19.
//  Copyright © 2016年 靳峰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFTableViewCell : UITableViewCell
/**
 *  设置按钮个数及按钮名称
 *
 *  @param count    按钮个数
 *  @param titleArr 按钮名称
 */
-(void)setButtonCount:(int)count btnTitle:(NSArray *)titleArr;
@end
