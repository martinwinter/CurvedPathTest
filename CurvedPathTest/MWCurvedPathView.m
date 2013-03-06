//
//  MWCurvedPathView.m
//  CurvedPathTest
//
//  Created by Martin Winter on 06.03.13.
//  Copyright (c) 2013 Martin Winter. All rights reserved.
//

#import "MWCurvedPathView.h"
#import "MWDotView.h"


@interface MWCurvedPathView ()

@property (strong) MWDotView *dot1;
@property (strong) MWDotView *dot2;

@property (assign) CGFloat m;
@property (assign) CGFloat n;

@property (weak, nonatomic) IBOutlet UILabel *mLabel;
@property (weak, nonatomic) IBOutlet UILabel *nLabel;

@end


@implementation MWCurvedPathView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    }
    
    return self;
}


- (void)awakeFromNib
{
    self.m = 0.24;
    self.n = 0.26;
    [self updateLabels];
    
    _dot1 = [[MWDotView alloc] initWithCenter:CGPointMake(100.0, 100.0) 
                                        color:[UIColor whiteColor]];
    [self addSubview:_dot1];
    
    _dot2 = [[MWDotView alloc] initWithCenter:CGPointMake(400.0, 500.0) 
                                        color:[UIColor blackColor]];
    [self addSubview:_dot2];
}


- (void)drawRect:(CGRect)rect
{
    CGPoint p1 = self.dot1.center;
    CGPoint p2 = self.dot2.center;

    CGFloat dx = p2.x - p1.x;
    CGFloat dy = p2.y - p1.y;
    
    CGPoint q1 = CGPointMake(p1.x + self.m * dx, 
                             p1.y + self.m * dy);
    
    CGPoint c1 = CGPointMake(q1.x + self.n * dx, 
                             q1.y - self.n * dy);
    
    CGPoint q2 = CGPointMake(p2.x - self.m * dx, 
                             p2.y - self.m * dy);
    
    CGPoint c2 = CGPointMake(q2.x + self.n * dx, 
                             q2.y - self.n * dy);
    
    UIBezierPath *curvedPath = [UIBezierPath bezierPath];
    [curvedPath moveToPoint:p1];
    [curvedPath addCurveToPoint:p2 
                  controlPoint1:c1 
                  controlPoint2:c2];
    
    [curvedPath setLineWidth:3.0];
    [[UIColor redColor] set];
    [curvedPath stroke];
}


- (void)updateLabels
{
    self.mLabel.text = [NSString stringWithFormat:@"%f", self.m];
    self.nLabel.text = [NSString stringWithFormat:@"%f", self.n];
}


- (IBAction)mChanged:(UISlider *)sender
{
    self.m = sender.value;
    [self updateLabels];
    [self setNeedsDisplay];
}


- (IBAction)nChanged:(UISlider *)sender
{
    self.n = sender.value;
    [self updateLabels];
    [self setNeedsDisplay];
}


@end
