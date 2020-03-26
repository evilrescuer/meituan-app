//
//  ViewController.m
//  meituan-app
//
//  Created by Zhimao Lin on 2020/3/24.
//  Copyright © 2020 Zhimao Lin. All rights reserved.
//

#import "ViewController.h"
#import "SwiperCollectionViewCell.h"
#import "SwiperCollectionView.h"
#import "StoreListCollectionView.h"
#import "StoreListCollectionViewCell.h"
#import <Masonry/Masonry.h>

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet SwiperCollectionView *swiperView;
@property (nonatomic) NSInteger SWIPER_COUNT;
@property (nonatomic) NSInteger currentShowingIndexOfSwiperCell;
@property (nonatomic) CGFloat willBeginDraggingX;
@property (nonatomic) CGFloat willEndDraggingX;
@property (strong, nonatomic) NSArray<NSString *> *swiperImageNames;

@property (weak, nonatomic) IBOutlet StoreListCollectionView *storeListView;
@property (strong, nonatomic) NSArray<NSString *> *storeListImageNames;
@property (strong, nonatomic) NSArray<NSString *> *storeListDescriptions;
@property (nonatomic) NSInteger STORE_LIST_COUNT;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentShowingIndexOfSwiperCell = 0;
    _swiperImageNames = @[@"swiper1", @"swiper2", @"swiper3"];
    _storeListImageNames = @[@"store1", @"store2", @"store3", @"store4", @"store5", @"store6"];
    _storeListDescriptions = @[@"无骨烤鱼饭（万意美食城店）", @"肯德基c宅急送（天通苑西店）", @"田老师红烧肉（北苑p卜蜂莲花店）", @"高端枸杞", @"新鲜水果草莓", @"海南西瓜"];

    _SWIPER_COUNT = _swiperImageNames.count;
    _STORE_LIST_COUNT = _storeListImageNames.count;
    _swiperView.layer.cornerRadius = 8;
    _storeListView.layer.cornerRadius = 8;
}

-(void)viewWillAppear:(BOOL)animated {
    [self performSelector:@selector(task) withObject:nil afterDelay:3];
}

- (void)viewWillDisappear:(BOOL)animated {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(task) object:nil];
}

- (void)task {
    [self scrollToNextIndexForSwiper:true];
    [self performSelector:@selector(task) withObject:nil afterDelay:3];
}

- (void)addIndexForSwiper:(NSInteger)num :(BOOL)loop {
    NSInteger tempResult = _currentShowingIndexOfSwiperCell + num;

    if(loop) {
        tempResult %= _SWIPER_COUNT;
    }

    if(tempResult >= 0 && tempResult < _SWIPER_COUNT) {
        _currentShowingIndexOfSwiperCell += num;
    }

    _currentShowingIndexOfSwiperCell = _currentShowingIndexOfSwiperCell % _SWIPER_COUNT;
}

- (void)scrollToIndexForSwiper {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_currentShowingIndexOfSwiperCell inSection:0];
    [_swiperView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:true];
}

- (void)scrollToPreviousIndexForSwiper:(BOOL)loop {
    [self addIndexForSwiper:-1 :loop];
    [self scrollToIndexForSwiper];
}

- (void)scrollToNextIndexForSwiper:(BOOL)loop {
    [self addIndexForSwiper:1 :loop];
    [self scrollToIndexForSwiper];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (collectionView.class == SwiperCollectionView.class) {
        SwiperCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"swiperCell" forIndexPath:indexPath];
        
        UIImage *uiImage = [UIImage imageNamed:_swiperImageNames[indexPath.item]];
        cell.imageView.image = uiImage;
        cell.imageView.layer.cornerRadius = 8;
        cell.layer.cornerRadius = 8;
        return cell;
    }
    else if (collectionView.class == StoreListCollectionView.class) {
        StoreListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"storeListCell" forIndexPath:indexPath];
        
        UIImage *uiImage = [UIImage imageNamed:_storeListImageNames[indexPath.item]];
        cell.imageView.image = uiImage;
        cell.imageView.layer.cornerRadius = 8;
        cell.textLabel.text = _storeListDescriptions[indexPath.item];
        cell.layer.cornerRadius = 8;
        return cell;
    }
    return nil;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView.class == SwiperCollectionView.class) {
        return _SWIPER_COUNT;
    }
    else if (collectionView.class == StoreListCollectionView.class) {
        return _STORE_LIST_COUNT;
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView.class == SwiperCollectionView.class) {
        return _swiperView.bounds.size;
    }
    else if (collectionView.class == StoreListCollectionView.class) {
        CGFloat width = (_storeListView.bounds.size.width - 20) / 2;
        return CGSizeMake(width, width + 80);
    }
    return CGSizeZero;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _willBeginDraggingX = scrollView.contentOffset.x;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    _willEndDraggingX = scrollView.contentOffset.x;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    _willEndDraggingX = scrollView.contentOffset.x;
    if(_willEndDraggingX > _willBeginDraggingX) {
        [self scrollToNextIndexForSwiper:false];
    }
    else {
        [self scrollToPreviousIndexForSwiper:false];
    }
}

@end
