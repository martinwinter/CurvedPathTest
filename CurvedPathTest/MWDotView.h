//
//  MWDotView.h
//  CurvedPathTest
//
//  Created by Martin Winter on 06.03.13.
//  Copyright (c) 2013 Martin Winter. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MWDotView : UIView


@property (strong) UIColor *color;

- (id)initWithCenter:(CGPoint)center color:(UIColor *)color;

@end
