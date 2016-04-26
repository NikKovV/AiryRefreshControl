//
//  AiryFooterRefreshControl.h
//  Pods
//
//  Created by Air on 4/25/16.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,AiryFooterRefreshControlState) {
    AiryFooterRefreshControlIdle,
    AiryFooterRefreshControlRefreshing,
    AiryFooterRefreshControlNoMore
};

@interface AiryFooterRefreshControl : NSObject

- (instancetype)initWithScrollView:(UIScrollView *)scrollView target:(id)target action:(SEL)action;

- (void)beginRefreshing;

- (void)endRefreshing;


@end
