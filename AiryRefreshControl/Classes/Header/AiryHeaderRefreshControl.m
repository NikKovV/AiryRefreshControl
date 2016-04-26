//
//  AiryHeaderRefreshControl.m
//  Pods
//
//  Created by Air on 4/25/16.
//
//

#import "AiryHeaderRefreshControl.h"
#import "AiryHeaderRefreshControlView.h"

@interface AiryHeaderRefreshControl()

@property (assign, nonatomic) AiryHeaderRefreshControlState state;

@property (strong, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) id target;
@property (assign, nonatomic) SEL action;

@property (strong, nonatomic) AiryHeaderRefreshControlView *refreshView;

@property (assign, nonatomic) BOOL isScrollViewOriginInsetChanged;
@property (assign, nonatomic) UIEdgeInsets scrollViewOriginInset;

@end

@implementation AiryHeaderRefreshControl

@synthesize state = _state;

- (instancetype)initWithScrollView:(UIScrollView *)scrollView target:(id)target action:(SEL)action
{
    self = [super init];
    if (self) {
        self.scrollView = scrollView;
        
        self.target = target;
        self.action = action;
        
        _state = AiryHeaderRefreshControlIdle;
        
        [self renderRefreshView];
        
        [self registerObservers];
    }
    return self;
}

- (void)dealloc
{
    [self unregisterObservers];
}

#pragma mark - State

- (void)setState:(AiryHeaderRefreshControlState)state
{
    _state = state;
}

- (AiryHeaderRefreshControlState)state
{
    return _state;
}

- (void)beginRefreshing
{
    [self setState:AiryHeaderRefreshControlRefreshing];
    [self makeRefreshViewBeginRefreshing];
}

- (void)endRefreshing
{
    [self setState:AiryHeaderRefreshControlIdle];
    [self makeRefreshViewEndRefreshing];
}

#pragma mark - Render

- (void)renderRefreshView
{
    _refreshView = [[AiryHeaderRefreshControlView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 0)];
    [_scrollView addSubview:_refreshView];
}

- (void)updateRefreshViewLayoutWithPullDistance:(CGFloat)pullDistance pullRatio:(CGFloat)pullRatio
{
    // Update refreshView layout
    CGRect refreshFrame = _refreshView.frame;
    
    refreshFrame.origin.y = -pullDistance;
    refreshFrame.size.height = pullDistance;
    
    _refreshView.frame = refreshFrame;
    
    [_refreshView setNeedsLayout];
    [_refreshView layoutIfNeeded];
    
    [_refreshView scrollViewDidScrollWithPullDistance:pullDistance pullRatio:pullRatio];
}

- (void)updateScrollViewLayout:(BOOL)isRefreshing
{
    UIEdgeInsets refreshingEdgeInsets;
    
    if (isRefreshing) {
        _scrollViewOriginInset = _scrollView.contentInset;
        _isScrollViewOriginInsetChanged = true;
        
        refreshingEdgeInsets = _scrollView.contentInset;
        refreshingEdgeInsets.top += [_refreshView heightForRefreshControlViewRefreshingState];
    } else {
        refreshingEdgeInsets = _scrollViewOriginInset;
    }
    
    _scrollView.contentInset = refreshingEdgeInsets;
    
    [_scrollView setContentOffset:CGPointMake(0, -_scrollView.contentInset.top) animated:NO];
}

#pragma mark - Observer

- (void)registerObservers
{
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)unregisterObservers
{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self handleScrollViewContentOffset];
    }
}

- (void)handleScrollViewContentOffset
{
    CGFloat pullDistance = -(_scrollView.contentOffset.y + _scrollView.contentInset.top);
    
    if (pullDistance < 0) {
        return;
    }
    
    pullDistance = MAX(0.0, pullDistance);
    
    CGFloat refreshingHeight = [_refreshView heightForRefreshControlViewRefreshingState];
    
    CGFloat pullRatio = MIN(MAX(pullDistance,0.0),refreshingHeight) / refreshingHeight;
    
    if (_state == AiryHeaderRefreshControlRefreshing) {
        return;
    }
    
    if (_scrollView.isDragging) {
        if (_state == AiryHeaderRefreshControlIdle) {
            [self setState:AiryHeaderRefreshControlWillRefreshing];
        }
        
        [self updateRefreshViewLayoutWithPullDistance:pullDistance pullRatio:pullRatio];
    } else {
        if (_state == AiryHeaderRefreshControlIdle) {
            if (-_scrollView.contentOffset.y == _scrollView.contentInset.top || !_isScrollViewOriginInsetChanged) {
                return;
            }
            // Reset scroll view content inset to default
            _scrollView.contentInset = _scrollViewOriginInset;
            _scrollView.contentOffset = CGPointMake(0, -_scrollView.contentInset.top);
            return;
        }
        
        // Update state by pull ratio
        if (pullRatio == 1) {
            [self setState:AiryHeaderRefreshControlRefreshing];
            
            [self makeRefreshViewBeginRefreshing];
        } else {
            [self setState:AiryHeaderRefreshControlIdle];
        }
    }
}

#pragma mark - Refresh Method

- (void)makeRefreshViewBeginRefreshing
{
    [self updateScrollViewLayout:true];
    
    [self updateRefreshViewLayoutWithPullDistance:[_refreshView heightForRefreshControlViewRefreshingState] pullRatio:1.0];
    
    [_refreshView startRefreshing];
    
    if ([_target respondsToSelector:_action]) {
        [_target performSelectorOnMainThread:_action withObject:nil waitUntilDone:false];
    }
}

- (void)makeRefreshViewEndRefreshing
{
    [self updateScrollViewLayout:false];
    
    [self updateRefreshViewLayoutWithPullDistance:0 pullRatio:0];
    
    [_refreshView stopRefreshing];
}

- (void)setHeaderRefreshView:(UIView<AiryHeaderRefreshViewDataSource> *)headerRefreshView
{
    [_refreshView setHeaderRefreshView:headerRefreshView];
}

@end
