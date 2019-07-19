//
//  HYBannerView.h
//  FeiDi
//
//  Created by YCLZONE on 27/09/2016.
//  Copyright © 2016 YCLZONE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYBannerView : UIView

+ (instancetype)bannerView;

- (void)reloadWithDataArray:(NSArray *)dataArray;

/** 点击回调 */
@property (nonatomic, copy) void (^bannerBlock)(NSString *banner);

@end
