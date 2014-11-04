//
//  LeaderBoardTableViewCell.m
//  Selfie
//
//  Created by Shubham Sorte on 04/11/14.
//  Copyright (c) 2014 Apps2eaze. All rights reserved.
//

#import "LeaderBoardTableViewCell.h"

@implementation LeaderBoardTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//-(void)drawRect:(CGRect)rect
//{
//    //// General Declarations
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    //// Color Declarations
//    UIColor* fillColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
//    UIColor* strokeColor = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1];
//    
//    //// Shadow Declarations
//    UIColor* shadow = strokeColor;
//    CGSize shadowOffset = CGSizeMake(0.1, 1.1);
//    CGFloat shadowBlurRadius = 2;
//    
//    //// Rectangle Drawing
//    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, 320, 70)];
//    CGContextSaveGState(context);
//    CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor);
//    [fillColor setFill];
//    [rectanglePath fill];
//    CGContextRestoreGState(context);
//    
//    [strokeColor setStroke];
//    rectanglePath.lineWidth = 1;
//    [rectanglePath stroke];
//
//}

@end
