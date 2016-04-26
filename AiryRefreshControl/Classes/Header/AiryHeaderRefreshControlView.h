//
//  AiryHeaderRefreshControlView.h
//  Pods
//
//  Created by Air on 4/25/16.
//
//

#import <UIKit/UIKit.h>
#import "AiryHeaderRefreshViewDataSource.h"

@interface AiryHeaderRefreshControlView : UIView

- (CGFloat)heightForRefreshControlViewRefreshingState;

- (void)scrollViewDidScrollWithPullDistance:(CGFloat)pullDistance pullRatio:(CGFloat)pullRatio;

- (void)startRefreshing;

- (void)stopRefreshing;

- (void)setHeaderRefreshView:(UIView<AiryHeaderRefreshViewDataSource> *)headerRefreshView;

@end
