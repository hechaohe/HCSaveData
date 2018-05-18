//
//  CustomBackground.m
//  HCSaveData
//
//  Created by hc on 2018/4/27.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "CustomBackground.h"

@implementation CustomBackground


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
   
    CGContextRef aRef = UIGraphicsGetCurrentContext();
    CGContextSaveGState(aRef);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5.0f];
    bezierPath.lineWidth = 5.0f;
    [[UIColor blackColor] setStroke];
    
    UIColor *fillcolor = [UIColor colorWithRed:0.529 green:0.808 blue:0.922 alpha:1];
    [fillcolor setFill];
    
    [bezierPath stroke];
    [bezierPath fill];
    CGContextRestoreGState(aRef);
    
}


@end
