//
//  ViewController.m
//  meituan-app
//
//  Created by Zhimao Lin on 2020/3/24.
//  Copyright © 2020 Zhimao Lin. All rights reserved.
//

#import "ViewController.h"
#import "SwiperCollectionViewCell.h"
#import <Masonry/Masonry.h>

@interface ViewController ()<UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *swiperView;
@property (nonatomic) NSInteger SWIPER_COUNT;
@property (nonatomic) NSInteger currentShowingIndexOfSwiperCell;
@property (nonatomic) CGFloat willBeginDraggingX;
@property (nonatomic) CGFloat willEndDraggingX;
@property (strong, nonatomic) NSArray<NSString *> *imageNames;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _currentShowingIndexOfSwiperCell = 0;
    _imageNames = @[@"swiper1", @"swiper2", @"swiper3"];
    _SWIPER_COUNT = _imageNames.count;
}

-(void)viewWillAppear:(BOOL)animated {
    [self performSelector:@selector(task) withObject:nil afterDelay:2];
}

- (void)viewWillDisappear:(BOOL)animated {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(task) object:nil];
}

- (void)task {
    [self scrollToNextIndexForSwiper:true];
    [self performSelector:@selector(task) withObject:nil afterDelay:2];
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
    
    SwiperCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"swiperCell" forIndexPath:indexPath];
    
    UIImage *uiImage = [UIImage imageNamed:_imageNames[indexPath.item]];
    cell.imageView.image = uiImage;
    cell.imageView.layer.cornerRadius = 8;
//    cell.imageView.layer.borderWidth = 0;
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _SWIPER_COUNT;
}

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

//- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
//    return parentSize;
//}

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
    
}

- (void)setNeedsFocusUpdate {
    
}

//- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
//
//}
//
//- (void)updateFocusIfNeeded {
//
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 200;
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return _swiperView.bounds.size;
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
//        NSLog(_currentShowingIndexOfSwiperCell);
        [self scrollToNextIndexForSwiper:false];
        NSLog(@"右滑%ld", _currentShowingIndexOfSwiperCell);
    }
    else {
        [self scrollToPreviousIndexForSwiper:false];
        NSLog(@"左滑%ld", _currentShowingIndexOfSwiperCell);
//        NSLog(_currentShowingIndexOfSwiperCell);
    }
}

@end
