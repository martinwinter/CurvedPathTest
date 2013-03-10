//
//  MWDotView.h
//  CurvedPathTest
//
//  Created by Martin Winter on 06.03.13.
//  Copyright (c) 2013 Martin Winter. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MWDotView : UIView

- (id)initWithCenter:(CGPoint)center 
              radius:(CGFloat)radius 
               color:(UIColor *)color;

+ (void)drawDotAtCenter:(CGPoint)center 
                 radius:(CGFloat)radius 
                  color:(UIColor *)color
                stroked:(BOOL)stroked;

@end
