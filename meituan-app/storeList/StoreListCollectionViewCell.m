//
//  StoreListCollectionViewCell.m
//  meituan-app
//
//  Created by Zhimao Lin on 2020/3/26.
//  Copyright © 2020 Zhimao Lin. All rights reserved.
//

#import "StoreListCollectionViewCell.h"

@implementation StoreListCollectionViewCell
- (UICollectionViewLayoutAttributes*)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes*)layoutAttributes {

    [self setNeedsLayout];

    [self layoutIfNeeded];

    CGSize size = [self.contentView systemLayoutSizeFittingSize: layoutAttributes.size];

    CGRect cellFrame = layoutAttributes.frame;

    cellFrame.size.height= size.height;

    layoutAttributes.frame= cellFrame;

    return layoutAttributes;

}
@end
