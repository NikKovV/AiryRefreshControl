//
//  AiryRefreshControl.m
//  Pods
//
//  Created by Air on 4/25/16.
//
//

#import "AiryRefreshControl.h"
#import "AiryHeaderRefreshControl.h"
#import "AiryFooterRefreshControl.h"

@interface AiryRefreshControl()

@property (strong, nonatomic) AiryHeaderRefreshControl *headerRefreshControl;
@property (strong, nonatomic) AiryFooterRefreshControl *footerRefreshControl;

@end

@implementation AiryRefreshControl

- (instancetype)initWithHeaderRefreshControl:(AiryHeaderRefreshControl *)headerRefreshControl
{
    self = [super init];
    if (self) {
        _headerRefreshControl = headerRefreshControl;
    }
    return self;
}

- (instancetype)initWithFooterRefreshControl:(AiryFooterRefreshControl *)footerRefreshControl
{
    self = [super init];
    if (self) {
        _footerRefreshControl = footerRefreshControl;
    }
    return self;
}

- (instancetype)initWithHeaderRefreshControl:(AiryHeaderRefreshControl *)headerRefreshControl footerRefreshControl:(AiryFooterRefreshControl *)footerRefreshControl
{
    self = [super init];
    if (self) {
        _headerRefreshControl = headerRefreshControl;
        _footerRefreshControl = footerRefreshControl;
    }
    return self;
}


+ (AiryRefreshControl *)attachRefreshControlToScrollview:(UIScrollView *)scrollView target:(id)target headerRefreshAction:(SEL)headerRefreshAction footerRefreshAction:(SEL)footerRefreshAction
{
    AiryHeaderRefreshControl *headerRefreshControl = [[AiryHeaderRefreshControl alloc] initWithScrollView:scrollView target:target action:headerRefreshAction];
    AiryFooterRefreshControl *footerRefreshControl = [[AiryFooterRefreshControl alloc] initWithScrollView:scrollView target:target action:footerRefreshAction];

    return [[AiryRefreshControl alloc] initWithHeaderRefreshControl:headerRefreshControl footerRefreshControl:footerRefreshControl];
}

#pragma mark - Header Refresh Control

+ (AiryRefreshControl *)attachHeaderRefreshControlToScrollView:(UIScrollView *)scrollView target:(id)target action:(SEL)action
{
    AiryHeaderRefreshControl *headerRefreshControl = [[AiryHeaderRefreshControl alloc] initWithScrollView:scrollView target:target action:action];
    
    return [[AiryRefreshControl alloc] initWithHeaderRefreshControl:headerRefreshControl];
}

- (void)startHeaderRefreshing
{
    [_headerRefreshControl beginRefreshing];
}

- (void)stopHeaderRefreshing
{
    [_headerRefreshControl endRefreshing];
}

- (void)setHeaderRefreshView:(UIView<AiryHeaderRefreshViewDataSource> *)headerRefreshView
{
    [_headerRefreshControl setHeaderRefreshView:headerRefreshView];
}

#pragma mark - Footer Refresh Control

+ (AiryRefreshControl *)attachFooterRefreshControlToScrollView:(UIScrollView *)scrollView target:(id)target action:(SEL)action;
{
    AiryFooterRefreshControl *footerRefreshControl = [[AiryFooterRefreshControl alloc] initWithScrollView:scrollView target:target action:action];
    
    return [[AiryRefreshControl alloc] initWithFooterRefreshControl:footerRefreshControl];
}

- (void)startFooterRefreshing
{
    [_footerRefreshControl beginRefreshing];
}

- (void)stopFooterRefreshing
{
    [_footerRefreshControl endRefreshing];
}

@end
