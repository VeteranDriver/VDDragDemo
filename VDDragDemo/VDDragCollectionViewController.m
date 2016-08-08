//
//  VDDragCollectionViewController.m
//  VDDragDemo
//
//  Created by lyb on 16/8/3.
//  Copyright © 2016年 lyb. All rights reserved.
//

#import "VDDragCollectionViewController.h"

#import "VDDragCollectionViewController.h"
#import "VDDragCollectionViewCell.h"

#define imageCount 19
@interface VDDragCollectionViewController ()

@property (nonatomic, assign) CGFloat offsetY;
@property (nonatomic, strong) UICollectionViewCell *currentCell;


@end

@implementation VDDragCollectionViewController

static NSString * const reuseIdentifier = @"VDDragCell";

- (instancetype)init{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    if (self = [super initWithCollectionViewLayout:layout]) {
        
        self.offsetY = 0;
        self.collectionView.pagingEnabled = YES;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.showsVerticalScrollIndicator = NO;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[VDDragCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
}


#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return imageCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    VDDragCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSString *str = [NSString stringWithFormat:@"%zd",indexPath.item + 1];
    NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:@"jpg"];
    
    cell.image = [UIImage imageWithContentsOfFile:path];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y < 0) {//顶部第一个cell下拉不产生效果
        
        return;
    }
    
    //获取到当前cell
    NSInteger offset = scrollView.contentOffset.y / [UIScreen mainScreen].bounds.size.height ;
    NSIndexPath *index = [NSIndexPath indexPathForItem:offset inSection:0];
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:index];
    
    //获取到下一个cell
    NSIndexPath *nextIndex = [NSIndexPath indexPathForItem:offset + 1 inSection:0];
    UICollectionViewCell *nextCell = [self.collectionView cellForItemAtIndexPath:nextIndex];
    
    
    //将下一个cell插入到当前cell的下方
    CGRect rect = nextCell.frame;
    rect.origin.y = self.collectionView.contentOffset.y;
    nextCell.frame = rect;
    
    [self.collectionView insertSubview:nextCell belowSubview:cell];
    
    //下拉设置透明度
    if (scrollView.contentOffset.y < self.offsetY) {
        
        CGFloat progress = (self.offsetY - scrollView.contentOffset.y) / [UIScreen mainScreen].bounds.size.height;
        cell.alpha = progress;
        
        self.currentCell = nil;
        self.currentCell = cell;
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self adjustCurrentCell:scrollView];//暂时修复底部间隙BUG，待修改
    
    self.offsetY = scrollView.contentOffset.y;
    self.currentCell.alpha = 1.0;
    
}


- (void)adjustCurrentCell:(UIScrollView *)scrollView {
    
    //获取到当前cell
    NSInteger offset = scrollView.contentOffset.y / [UIScreen mainScreen].bounds.size.height ;
    NSIndexPath *index = [NSIndexPath indexPathForItem:offset inSection:0];
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:index];
    
    CGRect rect = cell.frame;
    rect.origin.y = self.collectionView.contentOffset.y;
    cell.frame = rect;
}

@end
