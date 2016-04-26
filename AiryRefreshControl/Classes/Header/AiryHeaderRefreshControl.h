//
//  AiryHeaderRefreshControl.h
//  Pods
//
//  Created by Air on 4/25/16.
//
//

#import <Foundation/Foundation.h>
#import "AiryHeaderRefreshViewDataSource.h"

typedef NS_ENUM(NSInteger,AiryHeaderRefreshControlState) {
    AiryHeaderRefreshControlIdle,
    AiryHeaderRefreshControlWillRefreshing,
    AiryHeaderRefreshControlRefreshing
};

@interface AiryHeaderRefreshControl : NSObject

- (instancetype)initWithScrollView:(UIScrollView *)scrollView target:(id)target action:(SEL)action;

- (void)beginRefreshing;

- (void)endRefreshing;

- (void)setHeaderRefreshView:(UIView<AiryHeaderRefreshViewDataSource> *)headerRefreshView;

@end
