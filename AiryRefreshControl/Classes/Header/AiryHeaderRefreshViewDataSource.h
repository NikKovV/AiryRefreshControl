//
//  AiryHeaderRefreshViewDataSource.h
//  Pods
//
//  Created by Air on 4/25/16.
//
//

#import <Foundation/Foundation.h>

@protocol AiryHeaderRefreshViewDataSource <NSObject>

@optional

- (void)didUpdatePullRatio:(CGFloat)pullRatio;

@required

- (CGFloat)heightForRefreshViewRefreshingState;

- (void)startRefreshing;

- (void)stopRefreshing;

@end