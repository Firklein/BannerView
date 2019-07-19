//
//  BannerVC.m
//  BannerVC
//
//  Created by csj on 2019/7/19.
//  Copyright © 2019 csj. All rights reserved.
//

#import "BannerVC.h"
#import <Masonry.h>
#import "HYBannerView.h"

#define kScreenW    ([UIScreen mainScreen].bounds.size.width)

@interface BannerVC ()

@property (weak, nonatomic) IBOutlet UITableView *conTable;
/** 轮播图 */
@property (nonatomic, weak) HYBannerView *bannerView;
/** 轮播图图片地址 */
@property (nonatomic, strong) NSArray *bannerArray;

@end

@implementation BannerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.bannerArray = @[@"11",@"22",@"33",@"44"];
    [self setupBanner];
    [self.bannerView reloadWithDataArray:self.bannerArray];
    
}

/** 轮播图 */
- (void)setupBanner {
    HYBannerView *bannerView = [HYBannerView bannerView];
    bannerView.frame = CGRectMake(0, 0, kScreenW, 220);
    bannerView.backgroundColor = [UIColor redColor];
    [bannerView setBannerBlock:^(NSString *banner) {
        if (banner.length) {
            [self showWebVCWithURL:banner];
        }
    }];
    self.bannerView = bannerView;
    UIView *headerView = self.conTable.tableHeaderView;
    [headerView addSubview:[[UISearchBar alloc] initWithFrame:CGRectZero]];
    [headerView addSubview:bannerView];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(headerView);
    }];
}

//选择轮播图进入h5页面
- (void)showWebVCWithURL:(NSString *)url {
    if (!url.length) {
        return;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"targetIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return FLT_EPSILON;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return FLT_EPSILON;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
