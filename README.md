# AiryRefreshControl

[![Version](https://img.shields.io/cocoapods/v/AiryRefreshControl.svg?style=flat)](http://cocoapods.org/pods/AiryRefreshControl)
[![License](https://img.shields.io/cocoapods/l/AiryRefreshControl.svg?style=flat)](http://cocoapods.org/pods/AiryRefreshControl)
[![Platform](https://img.shields.io/cocoapods/p/AiryRefreshControl.svg?style=flat)](http://cocoapods.org/pods/AiryRefreshControl)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

#### Header RefreshControl

```
AiryRefreshControl *headerRefreshControl = [AiryRefreshControl attachHeaderRefreshControlToScrollView:self.scrollView target:self action:@selector(loadLatest)];
```

You can also customise your header refresh view by adopt protocol  `AiryHeaderRefreshViewDataSource`,then set the view to `AiryRefreshControl` like this:

```
AiryRefreshControl *headerRefreshControl = [AiryRefreshControl attachHeaderRefreshControlToScrollView:self.scrollView target:self action:@selector(loadLatest)];

UIView<AiryHeaderRefreshViewDataSource> *customHeaderRefreshView = [[AiryCustomHeaderRefreshView alloc] init];
[headerRefreshControl setHeaderRefreshView:customHeaderRefreshView];
```

#### Footer Refresh Control

```
AiryRefreshControl *footerRefreshControl = [AiryRefreshControl attachFooterRefreshControlToScrollView:self.scrollView target:self action:@selector(loadMore)];
```

#### Header & Footer Refresh Control

```
AiryRefreshControl *refreshControl = [AiryRefreshControl attachRefreshControlToScrollview:self.scrollView target:self headerRefreshAction:@selector(loadLatest) footerRefreshAction:@selector(loadMore)];
```

## Installation

AiryRefreshControl is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AiryRefreshControl"
```

## Author

[airymiao](airymiao@gmail.com)

## License

AiryRefreshControl is available under the MIT license. See the LICENSE file for more info.
