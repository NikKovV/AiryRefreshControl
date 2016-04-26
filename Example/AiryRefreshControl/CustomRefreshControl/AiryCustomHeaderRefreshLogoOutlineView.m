//
//  AiryCustomHeaderRefreshLogoOutlineView.m
//  AiryRefreshControl
//
//  Created by Air on 4/26/16.
//  Copyright © 2016 airymiao. All rights reserved.
//

#import "AiryCustomHeaderRefreshLogoOutlineView.h"

@interface AiryCustomHeaderRefreshLogoOutlineView()

@property (strong, nonatomic) CAShapeLayer *logoOutlineLayer;

@property (strong, nonatomic) UIImageView *logoImageView;


@end

@implementation AiryCustomHeaderRefreshLogoOutlineView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.backgroundColor = [UIColor clearColor];
    
    [self render];
}

- (void)drawRect:(CGRect)rect
{
    [self drawLogoOutline];
}

- (void)drawLogoOutline
{
    CGFloat borderWidth = 1.0;
    UIColor *borderColor = [UIColor colorWithRed:45 / 255.0 green:79 / 255.0 blue:131 / 255.0 alpha:1.0];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // Right circle
    [path addArcWithCenter:CGPointMake(37, 26) radius:11 startAngle:-1.169501319 * M_PI_2 endAngle:M_PI_2 clockwise:true];
    
    // Bottom line
    [path moveToPoint:CGPointMake(37, 37)];
    [path addLineToPoint:CGPointMake(11, 37)];
    
    // Left circle
    [path moveToPoint:CGPointMake(11, 37)];
    [path addArcWithCenter:CGPointMake(11, 28) radius:9 startAngle:M_PI_2 endAngle:3 * M_PI_2 clockwise:true];
    
    // Top circle
    [path addArcWithCenter:CGPointMake(23, 19) radius:12 startAngle:M_PI endAngle:1.92202087 * M_PI  clockwise:true];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = borderColor.CGColor;
    layer.lineWidth = borderWidth;
    layer.strokeEnd = 0.0;
    
    [self.layer addSublayer:layer];
    
    self.logoOutlineLayer = layer;
}

- (void)drawWithRatio:(CGFloat)ratio
{
    [CATransaction begin];
    self.logoOutlineLayer.strokeEnd = ratio;
    [CATransaction commit];
    
    [self fadeLogoImageViewWithRatio:ratio];
}

- (void)render
{
    [self renderLogoImageView];
}

#pragma mark - Logo Image View

- (void)renderLogoImageView
{
    _logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo-plus"]];
    
    _logoImageView.alpha = 0.0;
    [self addSubview:_logoImageView];
    
    [self applyConstraintsToLogoImageView:_logoImageView inView:self];
}

- (void)applyConstraintsToLogoImageView:(UIImageView *)logoImageView inView:(UIView *)view
{
    logoImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:logoImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:logoImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:logoImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:16.0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:logoImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:16.0]];
}

- (void)fadeLogoImageViewWithRatio:(CGFloat)ratio
{
    _logoImageView.alpha = ratio;
}

- (void)scaleLogoImage
{
    [UIView animateWithDuration:0.3 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _logoImageView.transform = CGAffineTransformMakeScale(1.25, 1.25);
    } completion:^(BOOL finished) {
        _logoImageView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

@end
