//
//  AiryHeaderRefreshControlView.m
//  Pods
//
//  Created by Air on 4/25/16.
//
//

#import "AiryHeaderRefreshControlView.h"
#import "AiryHeaderRefreshView.h"

@interface AiryHeaderRefreshControlView()

@property (strong, nonatomic) UIView<AiryHeaderRefreshViewDataSource> *refreshView;

@end

@implementation AiryHeaderRefreshControlView

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
    // Hide spinner
    self.tintColor = [UIColor clearColor];
    
    self.clipsToBounds = YES;
    
    [self renderRefreshView];
}


#pragma mark - Content View

- (void)renderRefreshView
{
    _refreshView = [[AiryHeaderRefreshView alloc] init];
    
    [self setHeaderRefreshView:_refreshView];
}

- (void)applyConstraintsToRefreshView:(UIView *)refreshView inView:(UIView *)view
{
    refreshView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *views = @{@"refreshView":refreshView};
    
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[refreshView]-0-|" options:0 metrics:nil views:views]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[refreshView]-0-|" options:0 metrics:nil views:views]];
}

- (void)scrollViewDidScrollWithPullDistance:(CGFloat)pullDistance pullRatio:(CGFloat)pullRatio
{
    if ([_refreshView respondsToSelector:@selector(didUpdatePullRatio:)]) {
        [_refreshView didUpdatePullRatio:pullRatio];
    }
}

#pragma mark - Export Methods

- (CGFloat)heightForRefreshControlViewRefreshingState
{
    return [_refreshView heightForRefreshViewRefreshingState];
}

- (void)startRefreshing
{
    [_refreshView startRefreshing];
}

- (void)stopRefreshing
{
    [_refreshView stopRefreshing];
}

- (void)setHeaderRefreshView:(UIView<AiryHeaderRefreshViewDataSource> *)headerRefreshView
{
    [_refreshView removeFromSuperview];
    
    _refreshView = headerRefreshView;
    
    [self addSubview:_refreshView];
    
    [self applyConstraintsToRefreshView:_refreshView inView:self];
}

@end
