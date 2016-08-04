//
//  VDDragCollectionViewCell.m
//  VDDragDemo
//
//  Created by lyb on 16/8/3.
//  Copyright © 2016年 lyb. All rights reserved.
//

#import "VDDragCollectionViewCell.h"

@interface VDDragCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation VDDragCollectionViewCell

- (UIImageView *)imgView{
    
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc]init];
    }
    return _imgView;
}

- (void)setImage:(UIImage *)image{
    
    _image = image;
    
    self.imgView.image = image;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self addSubview:self.imgView];
    self.imgView.frame = self.bounds;
}

@end
