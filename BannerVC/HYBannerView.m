//
//  HYBannerView.m
//  FeiDi
//
//  Created by YCLZONE on 27/09/2016.
//  Copyright © 2016 YCLZONE. All rights reserved.
//

#import "HYBannerView.h"
//#import <HYUIKit.h>
#import "HYBannerCollectionViewCell.h"

#define  kPadding 0

#define  kEdgeInsetTop      0
#define  kEdgeInsetLeft     0
#define  kEdgeInsetBottom   kEdgeInsetTop
#define  kEdgeInsetRight    kEdgeInsetLeft

#define kMaxColumns  1

@interface HYBannerView ()<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout
>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

/** dataArray */
@property (nonatomic, strong) NSArray *dataArray;
/** timer */
@property (nonatomic, strong) NSTimer *timer;
/** currentItem */
@property (nonatomic, assign) NSInteger currentItem;
@end

@implementation HYBannerView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    //    self.collectionView
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HYBannerCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([HYBannerCollectionViewCell class])];
}

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - Public Methods
+ (instancetype)bannerView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (void)reloadWithDataArray:(NSArray *)dataArray {
    self.dataArray = dataArray;
    [self.collectionView reloadData];
    [self setupTimer];
}

#pragma mark - Private Methods
- (void)setupTimer {
    if (!self.timer) {
        self.timer = [NSTimer timerWithTimeInterval:2
                                             target:self
                                           selector:@selector(showNextPage)
                                           userInfo:nil
                                            repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

- (void)showNextPage {
    if (++self.currentItem >= self.dataArray.count) {
        self.currentItem = 0;
    }
    
    if (!self.dataArray.count) {
        return;
    }
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentItem inSection:0]
                                atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                        animated:YES];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    self.pageControl.numberOfPages = self.dataArray.count;
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HYBannerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HYBannerCollectionViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    cell.banner = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.bannerBlock) {
        self.bannerBlock(self.dataArray[indexPath.item]);
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    NSInteger currenetPage = scrollView.contentOffset.x/screenWidth+0.5;
    self.pageControl.currentPage = currenetPage;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat width = ( screenWidth-kPadding*2 - (kEdgeInsetLeft+kEdgeInsetRight) ) / kMaxColumns;
    
    return CGSizeMake(width, screenWidth*9/16.0);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.collectionViewHeightConstraint.constant = collectionView.contentSize.height;
//        
//        if (kNumberOfItems < kMaxColumns) {
//            self.collectionViewWidthConstraint.constant = [UIScreen mainScreen].bounds.size.width-10;
//        } else {
//            self.collectionViewWidthConstraint.constant = [UIScreen mainScreen].bounds.size.width;
//        }
//        
//    });
    return UIEdgeInsetsMake(kEdgeInsetTop, kEdgeInsetLeft, kEdgeInsetBottom, kEdgeInsetRight);
}

@end
