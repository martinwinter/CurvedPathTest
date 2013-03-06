//
//  MWDotView.m
//  CurvedPathTest
//
//  Created by Martin Winter on 06.03.13.
//  Copyright (c) 2013 Martin Winter. All rights reserved.
//

#import "MWDotView.h"


const CGFloat _radius = 15.0;
const CGFloat _lineWidth = 3.0;


@implementation MWDotView


- (id)initWithCenter:(CGPoint)center color:(UIColor *)color
{
    CGRect dotFrame = CGRectMake(center.x - _radius, 
                                 center.y - _radius, 
                                 2 * _radius, 
                                 2 * _radius);

    self = [super initWithFrame:dotFrame];
    if (self)
    {
        _color = color;
        self.opaque = NO;
    }

    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    return [self initWithCenter:CGPointZero color:[UIColor blackColor]];
}


- (void)drawRect:(CGRect)rect
{
    UIBezierPath *dotPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, 
                                                                               _lineWidth / 2.0, 
                                                                               _lineWidth / 2.0)];
    [self.color set];
    [dotPath fill];

    [[UIColor blackColor] set];
    [dotPath setLineWidth:_lineWidth];
    [dotPath stroke];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.superview];
    CGPoint previousLocation = [touch previousLocationInView:self.superview];
    CGPoint delta = CGPointMake(location.x - previousLocation.x, 
                                location.y - previousLocation.y);
    
    self.center = CGPointMake(self.center.x + delta.x, 
                              self.center.y + delta.y);
    
    // Avoid a delegate protocol for this simple test project.
    [self.superview setNeedsDisplay];
}


@end
