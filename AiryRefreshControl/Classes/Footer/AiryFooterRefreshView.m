//
//  AiryFooterRefreshView.m
//  Pods
//
//  Created by Air on 4/25/16.
//
//

#import "AiryFooterRefreshView.h"

static CGFloat AiryFooterActivityIndicatorViewHeight = 20.0;

@interface AiryFooterRefreshView()

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation AiryFooterRefreshView


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
    [self renderActivityIndicatorView];
}

- (void)renderActivityIndicatorView
{
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [self addSubview:self.activityIndicatorView];
    
    [self applyConstraintsToActivityIndicatorView:self.activityIndicatorView inView:self];
}

- (void)applyConstraintsToActivityIndicatorView:(UIActivityIndicatorView *)activityIndicatorView inView:(UIView *)view
{
    activityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:activityIndicatorView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:activityIndicatorView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:activityIndicatorView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:AiryFooterActivityIndicatorViewHeight]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:activityIndicatorView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:AiryFooterActivityIndicatorViewHeight]];
}

#pragma mark - Export Methods

- (void)startRefreshing
{
    [self.activityIndicatorView startAnimating];
}

- (void)stopRefreshing
{
    [self.activityIndicatorView stopAnimating];
}


@end
