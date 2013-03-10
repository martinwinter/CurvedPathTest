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

@property (assign) CGFloat thetaDeg;
@property (assign) CGFloat r;

@property (weak, nonatomic) IBOutlet UILabel *thetaLabel;
@property (weak, nonatomic) IBOutlet UILabel *rLabel;
@property (weak, nonatomic) IBOutlet UISlider *thetaSlider;
@property (weak, nonatomic) IBOutlet UISlider *rSlider;

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
    // Default values.
    self.thetaDeg = 18.0;
    self.r = 0.3;
    [self updateLabels];
    [self updateSliders];
    
    _dot1 = [[MWDotView alloc] initWithCenter:CGPointMake(100.0, 100.0) 
                                       radius:15.0 
                                        color:[UIColor whiteColor]];
    [self addSubview:_dot1];
    [_dot1 setNeedsDisplay];
    
    _dot2 = [[MWDotView alloc] initWithCenter:CGPointMake(400.0, 500.0) 
                                       radius:15.0 
                                        color:[UIColor blackColor]];
    [self addSubview:_dot2];
    [_dot2 setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect
{
    // Anchor points.
    CGPoint p1 = self.dot1.center;
    CGPoint p2 = self.dot2.center;

    // Offsets between p1 and p2.
    CGFloat dx = p2.x - p1.x;
    CGFloat dy = p2.y - p1.y;
    
    // Length of line between p1 and p2.
    CGFloat l = sqrtf(dx * dx + dy * dy);
    
    // Angle of line between p1 and p2 relative to the global coordinate system
    // in radians. Note that atan2() requires y first and x second!
    CGFloat alphaRad = atan2f(dy, dx);

    // Angle between line and control points in radians.
    CGFloat thetaRad = self.thetaDeg * M_PI / 180.0;
    
    // Flip control point angle so curve always bends towards the top.
    CGFloat ninetyDegrees = M_PI / 2.0;
    BOOL shouldFlip = (alphaRad < -ninetyDegrees || ninetyDegrees < alphaRad);
    if (shouldFlip)
    {
        thetaRad = -thetaRad;
    }
    
    // Angle theta relative to global coordinate system.
    CGFloat betaRad = alphaRad - thetaRad;
    
    // Opposite angle.
    CGFloat betaRadMirrored = alphaRad + thetaRad - M_PI;
    
    // Distance between anchor points and control points.
    CGFloat tangentLength = self.r * l;
    
    // Control points.
    CGPoint c1 = CGPointMake(p1.x + tangentLength * cosf(betaRad), 
                             p1.y + tangentLength * sinf(betaRad));
    
    CGPoint c2 = CGPointMake(p2.x + tangentLength * cosf(betaRadMirrored), 
                             p2.y + tangentLength * sinf(betaRadMirrored));
    
    UIBezierPath *curvedPath = [UIBezierPath bezierPath];
    [curvedPath moveToPoint:p1];
    [curvedPath addCurveToPoint:p2 
                  controlPoint1:c1 
                  controlPoint2:c2];
    
    [curvedPath setLineWidth:3.0];
    [[UIColor redColor] set];
    [curvedPath stroke];

    UIBezierPath *p1p2Path = [UIBezierPath bezierPath];
    [p1p2Path moveToPoint:p1];
    [p1p2Path addLineToPoint:p2];

    UIBezierPath *c1TangentPath = [UIBezierPath bezierPath];
    [c1TangentPath moveToPoint:p1];
    [c1TangentPath addLineToPoint:c1];
    
    UIBezierPath *c2TangentPath = [UIBezierPath bezierPath];
    [c2TangentPath moveToPoint:p2];
    [c2TangentPath addLineToPoint:c2];
    
    [[UIColor lightGrayColor] set];
    [curvedPath setLineWidth:2.0];
    [p1p2Path stroke];
    [c1TangentPath stroke];
    [c2TangentPath stroke];
    
    [MWDotView drawDotAtCenter:c1 
                        radius:5.0 
                         color:[UIColor greenColor] 
                       stroked:NO];

    [MWDotView drawDotAtCenter:c2 
                        radius:5.0 
                         color:[UIColor blueColor]
                       stroked:NO];
}


- (void)updateLabels
{
    self.thetaLabel.text = [NSString stringWithFormat:@"%f", self.thetaDeg];
    self.rLabel.text = [NSString stringWithFormat:@"%f", self.r];
}


- (void)updateSliders
{
    self.thetaSlider.value = self.thetaDeg;
    self.rSlider.value = self.r;
}


- (IBAction)mChanged:(UISlider *)sender
{
    self.thetaDeg = sender.value;
    [self updateLabels];
    [self setNeedsDisplay];
}


- (IBAction)nChanged:(UISlider *)sender
{
    self.r = sender.value;
    [self updateLabels];
    [self setNeedsDisplay];
}


@end
