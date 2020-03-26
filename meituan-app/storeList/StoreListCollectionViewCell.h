//
//  StoreListCollectionViewCell.h
//  meituan-app
//
//  Created by Zhimao Lin on 2020/3/26.
//  Copyright © 2020 Zhimao Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoreListCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

NS_ASSUME_NONNULL_END
