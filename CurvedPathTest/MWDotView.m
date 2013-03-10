//
//  MWDotView.m
//  CurvedPathTest
//
//  Created by Martin Winter on 06.03.13.
//  Copyright (c) 2013 Martin Winter. All rights reserved.
//

#import "MWDotView.h"


const CGFloat _lineWidth = 3.0;


@interface MWDotView ()

@property (assign) CGFloat radius;
@property (strong) UIColor *color;

@end


@implementation MWDotView


- (id)initWithCenter:(CGPoint)center 
              radius:(CGFloat)radius 
               color:(UIColor *)color
{
    CGRect dotFrame = [[self class] rectWithCenter:center 
                                            radius:radius];

    self = [super initWithFrame:dotFrame];
    if (self)
    {
        _radius = radius;
        _color = color;
        self.opaque = NO;
    }

    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    return [self initWithCenter:CGPointZero 
                         radius:3.0 
                          color:[UIColor blackColor]];
}


+ (CGRect)rectWithCenter:(CGPoint)center 
                  radius:(CGFloat)radius
{
    return CGRectMake(center.x - radius, 
                      center.y - radius, 
                      2 * radius, 
                      2 * radius);
}


+ (void)drawDotAtCenter:(CGPoint)center 
                 radius:(CGFloat)radius 
                  color:(UIColor *)color 
                stroked:(BOOL)stroked 
{
    CGRect dotFrame = [[self class] rectWithCenter:center 
                                            radius:radius];
    
    UIBezierPath *dotPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(dotFrame, 
                                                                               _lineWidth / 2.0, 
                                                                               _lineWidth / 2.0)];
    [color set];
    [dotPath fill];
    
    if (stroked)
    {
        [[UIColor blackColor] set];
        [dotPath setLineWidth:_lineWidth];
        [dotPath stroke];
    }
}


- (void)drawRect:(CGRect)rect
{
    // Use the center point in terms of the receiver’s local coordinate system!
    CGPoint localCenter = [self convertPoint:self.center 
                                    fromView:self.superview];
    
    [[self class] drawDotAtCenter:localCenter 
                           radius:self.radius 
                            color:self.color 
                          stroked:YES];
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
