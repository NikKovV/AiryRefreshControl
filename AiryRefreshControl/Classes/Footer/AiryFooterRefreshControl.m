//
//  AiryFooterRefreshControl.m
//  Pods
//
//  Created by Air on 4/25/16.
//
//

#import "AiryFooterRefreshControl.h"
#import "AiryFooterRefreshView.h"

static CGFloat AiryFooterRefreshViewHeight = 30.0;

@interface AiryFooterRefreshControl()

@property (assign, nonatomic) AiryFooterRefreshControlState state;

@property (strong, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) id target;
@property (assign, nonatomic) SEL action;

@property (strong, nonatomic) AiryFooterRefreshView *refreshView;

@end

@implementation AiryFooterRefreshControl

@synthesize state = _state;

- (instancetype)initWithScrollView:(UIScrollView *)scrollView target:(id)target action:(SEL)action
{
    self = [super init];
    if (self) {
        self.scrollView = scrollView;
        self.target = target;
        self.action = action;
        
        _state = AiryFooterRefreshControlIdle;
        
        [self addRefreshView];
        
        [self registerObservers];
    }
    return self;
}

- (void)dealloc
{
    [self unregisterObservers];
}

#pragma mark - State

- (void)setState:(AiryFooterRefreshControlState)state
{
    _state = state;
}

- (AiryFooterRefreshControlState)state
{
    return _state;
}

- (void)beginRefreshing
{
    [self setState:AiryFooterRefreshControlRefreshing];
    
    [self makeRefreshViewBeginRefreshing];
}

- (void)endRefreshing
{
    [self makeRefreshViewEndRefreshing];

    [self setState:AiryFooterRefreshControlIdle];
}

#pragma mark - Render

- (void)addRefreshView
{
    _refreshView = [[AiryFooterRefreshView alloc] initWithFrame:CGRectMake(0, _scrollView.contentSize.height,CGRectGetWidth([UIScreen mainScreen].bounds) , AiryFooterRefreshViewHeight)];
    
    [_scrollView addSubview:_refreshView];
}

- (void)updateFooterViewLayout
{
    CGRect frame = _refreshView.frame;
    frame.origin.y = _scrollView.contentSize.height;
    _refreshView.frame = frame;
}

#pragma mark - Observer

- (void)registerObservers
{
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [_scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)unregisterObservers
{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    [_scrollView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self handleScrollViewContentOffset];
    } else if([keyPath isEqualToString:@"contentSize"]){
        [self handleScrollViewContentSize];
    }
}

- (void)handleScrollViewContentOffset
{
    CGFloat pullDistance = _scrollView.contentOffset.y + _scrollView.contentInset.top;
    
    if (pullDistance <= 0) {
        return;
    }
    
    if (_scrollView.contentOffset.y + CGRectGetHeight(_scrollView.frame) > _scrollView.contentSize.height) {
        if (_state == AiryFooterRefreshControlIdle) {
            [self setState:AiryFooterRefreshControlRefreshing];
            [self makeRefreshViewBeginRefreshing];
        }
    }
}

- (void)handleScrollViewContentSize
{
    [self updateFooterViewLayout];
}


#pragma mark - Refresh Method

- (void)makeRefreshViewBeginRefreshing
{
    [_refreshView startRefreshing];
    
    if ([_target respondsToSelector:_action]) {
        [_target performSelectorOnMainThread:_action withObject:nil waitUntilDone:false];
    }
}

- (void)makeRefreshViewEndRefreshing
{
    [_refreshView stopRefreshing];
}


@end