//
//  AiryCustomHeaderRefreshView.m
//  AiryRefreshControl
//
//  Created by Air on 4/26/16.
//  Copyright © 2016 airymiao. All rights reserved.
//

#import "AiryCustomHeaderRefreshView.h"
#import "AiryCustomHeaderRefreshLogoOutlineView.h"

@interface AiryCustomHeaderRefreshView()

@property (strong, nonatomic) AiryCustomHeaderRefreshLogoOutlineView *logoOutlineView;
@property (strong, nonatomic) UIView *logoBottomLineView;

@end

@implementation AiryCustomHeaderRefreshView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self render];
    }
    return self;
}

- (void)render
{
    self.backgroundColor = [UIColor clearColor];
    
    [self renderLogoOutlineView];
    [self renderLogoBottomLineView];
}

#pragma mark - Logo Outline View

- (void)renderLogoOutlineView
{
    _logoOutlineView = [[AiryCustomHeaderRefreshLogoOutlineView alloc] init];
    [self addSubview:_logoOutlineView];
    
    [self applyConstraintsToLogoOutlineView:_logoOutlineView inView:self];
}

- (void)applyConstraintsToLogoOutlineView:(UIView *)logoOutlineView inView:(UIView *)view
{
    logoOutlineView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:logoOutlineView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:logoOutlineView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:15]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:logoOutlineView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:logoOutlineView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.0]];
}

- (void)drawLogoOutlineWithRatio:(CGFloat)ratio
{
    [_logoOutlineView drawWithRatio:ratio];
}

#pragma mark - Bottom Line View

- (void)renderLogoBottomLineView
{
    _logoBottomLineView = [[UIView alloc] init];
    _logoBottomLineView.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
    _logoBottomLineView.clipsToBounds = YES;
    _logoBottomLineView.layer.cornerRadius = 3.0;
    
    _logoBottomLineView.alpha = 0;
    
    [self addSubview:_logoBottomLineView];
    
    [self applyConstraintsToLogoBottomLineView:_logoBottomLineView logoOutlineView:_logoOutlineView inView:self];
}

- (void)applyConstraintsToLogoBottomLineView:(UIView *)logoBottomLineView logoOutlineView:(UIView *)logoOutlineView inView:(UIView *)view
{
    logoBottomLineView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:logoBottomLineView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:logoBottomLineView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:6.0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:logoBottomLineView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:6.0]];
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:logoBottomLineView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:logoOutlineView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:3.0]];
}

#pragma mark - View Height Handler

- (CGFloat)heightForRefreshViewRefreshingState
{
    return 80.0;
}

- (void)didUpdatePullRatio:(CGFloat)pullRatio
{
    [self drawLogoOutlineWithRatio:pullRatio];
}

#pragma mark - Refresh Methods

- (void)startRefreshing
{
    _logoOutlineView.transform = CGAffineTransformMakeTranslation(0, -15);
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse animations:^{
        _logoOutlineView.transform = CGAffineTransformMakeTranslation(0, 5);
        
        _logoBottomLineView.transform = CGAffineTransformMakeScale(5.0, 1.0);
        _logoBottomLineView.alpha = 1.0;
    } completion:^(BOOL finished) {
        _logoOutlineView.transform = CGAffineTransformMakeTranslation(0, 0);
        
        _logoBottomLineView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        _logoBottomLineView.alpha = 0;
    }];
}

- (void)stopRefreshing
{
    [_logoOutlineView.layer removeAllAnimations];
    [_logoBottomLineView.layer removeAllAnimations];
}

@end
