//
//  AiryViewController.m
//  AiryRefreshControl
//
//  Created by airymiao on 04/25/2016.
//  Copyright (c) 2016 airymiao. All rights reserved.
//

#import "AiryViewController.h"
#import <AiryRefreshControl/AiryRefreshControl.h>
#import "AiryCustomHeaderRefreshView.h"

@interface AiryViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) AiryRefreshControl *refreshControl;
@property (strong, nonatomic) AiryRefreshControl *headerRefreshControl;
@property (strong, nonatomic) AiryRefreshControl *footerRefreshControl;

@property (strong, nonatomic) NSMutableArray *data;

@end

@implementation AiryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _data = [NSMutableArray array];
    
    for (int i = 0 ; i < 16; i++) {
        [_data addObject:[NSString stringWithFormat:@"Row %i",i]];
    }
    
    [self renderTableView];
    
    [self renderRefreshControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)title
{
    return @"AiryRefreshControl Demo";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SimpleCell"];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SimpleCell"];
    }
    
    NSString *title = _data[indexPath.row];
    
    cell.textLabel.text = title;
    
    return cell;
}

- (void)renderTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *views = @{@"tableView":self.tableView};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tableView]-0-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[tableView]-0-|" options:0 metrics:nil views:views]];
}

#pragma mark - Refresh Control

- (void)renderRefreshControl
{
    
    /* Header Refresh Control */
    //    _headerRefreshControl = [AiryRefreshControl attachHeaderRefreshControlToScrollView:self.tableView target:self action:@selector(loadLatest)];
    
    /* Footer Refresh Control */
    //    _footerRefreshControl = [AiryRefreshControl attachFooterRefreshControlToScrollView:self.tableView target:self action:@selector(loadMore)];
    
    /* Header & Footer Refresh Control */
    _refreshControl = [AiryRefreshControl attachRefreshControlToScrollview:self.tableView target:self headerRefreshAction:@selector(loadLatest) footerRefreshAction:@selector(loadMore)];
    
    UIView<AiryHeaderRefreshViewDataSource> *customHeaderRefreshView = [[AiryCustomHeaderRefreshView alloc] init];
    [_refreshControl setHeaderRefreshView:customHeaderRefreshView];
}

- (void)loadLatest
{
    NSLog(@"Load Latest");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"Load Latest Finished");
        if (_refreshControl) {
            [_refreshControl stopHeaderRefreshing];
        }else if (_headerRefreshControl) {
            [_headerRefreshControl stopHeaderRefreshing];
        }
        
        
        NSMutableArray *headerData = [NSMutableArray array];
        
        for (int i = 0 ; i < 10; i++) {
            [headerData addObject:[NSString stringWithFormat:@"Header Row %i",arc4random_uniform(10000)]];
        }
        
        [_data replaceObjectsInRange:NSMakeRange(0, 0) withObjectsFromArray:headerData];
        
        [self.tableView reloadData];
    });
}

- (void)loadMore
{
    NSLog(@"Load More");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSLog(@"Load More Finished");
        if (_refreshControl) {
            [_refreshControl stopFooterRefreshing];
        }else if (_footerRefreshControl) {
            [_footerRefreshControl stopFooterRefreshing];
        }
        
        
        NSMutableArray *footerData = [NSMutableArray array];
        
        for (int i = 0 ; i < 10; i++) {
            [footerData addObject:[NSString stringWithFormat:@"Footer Row %i",arc4random_uniform(10000)]];
        }
        
        [_data addObjectsFromArray:footerData];
        
        [self.tableView reloadData];
    });
    
}

@end
