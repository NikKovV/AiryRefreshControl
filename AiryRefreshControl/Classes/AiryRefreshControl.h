//
//  AiryRefreshControl.h
//  Pods
//
//  Created by Air on 4/25/16.
//
//

#import <UIKit/UIKit.h>
#import "AiryHeaderRefreshViewDataSource.h"

@interface AiryRefreshControl : UIView

+ (AiryRefreshControl *)attachRefreshControlToScrollview:(UIScrollView *)scrollView target:(id)target headerRefreshAction:(SEL)headerRefreshAction footerRefreshAction:(SEL)footerRefreshAction;

#pragma mark - Header Refresh Control

+ (AiryRefreshControl *)attachHeaderRefreshControlToScrollView:(UIScrollView *)scrollView target:(id)target action:(SEL)action;

- (void)startHeaderRefreshing;
- (void)stopHeaderRefreshing;

- (void)setHeaderRefreshView:(UIView<AiryHeaderRefreshViewDataSource> *)headerRefreshView;

#pragma mark - Footer Refresh Control

+ (AiryRefreshControl *)attachFooterRefreshControlToScrollView:(UIScrollView *)scrollView target:(id)target action:(SEL)action;

- (void)startFooterRefreshing;
- (void)stopFooterRefreshing;

@end