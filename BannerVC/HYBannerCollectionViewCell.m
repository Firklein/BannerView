//
//  HYBannerCollectionViewCell.m
//  FeiDi
//
//  Created by YCLZONE on 27/09/2016.
//  Copyright © 2016 YCLZONE. All rights reserved.
//

#import "HYBannerCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface HYBannerCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation HYBannerCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)setBanner:(NSString *)banner {
    _banner = banner;
    if ([banner hasPrefix:@"http"]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:banner]
                          placeholderImage:[UIImage imageNamed:@"banner_1080x338-1"]];
    } else {
        self.imageView.image = [UIImage imageNamed:banner];
    }
}


@end
