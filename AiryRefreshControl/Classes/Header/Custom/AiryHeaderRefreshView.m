//
//  AiryHeaderRefreshView.m
//  Pods
//
//  Created by Air on 4/25/16.
//
//

#import "AiryHeaderRefreshView.h"

static CGFloat AiryHeaderActivityIndicatorViewHeight = 20.0;

@interface AiryHeaderRefreshView()

@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation AiryHeaderRefreshView

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
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:activityIndicatorView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:AiryHeaderActivityIndicatorViewHeight]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:activityIndicatorView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:AiryHeaderActivityIndicatorViewHeight]];
}

- (void)didUpdatePullRatio:(CGFloat)pullRatio
{
    [self startRefreshing];
}

#pragma mark - View Height Handler

- (CGFloat)heightForRefreshViewRefreshingState
{
    return 44.0;
}

#pragma mark - Refresh Methods

- (void)startRefreshing
{
    [self.activityIndicatorView startAnimating];
}

- (void)stopRefreshing
{
    [self.activityIndicatorView stopAnimating];
}

@end
