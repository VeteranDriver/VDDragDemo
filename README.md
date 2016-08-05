# VDDragDemo


![推拉](http://upload-images.jianshu.io/upload_images/1394392-a6af5776b844a3f6.gif?imageMogr2/auto-orient/strip)

**之前在某款APP中看到了这种照片浏览效果，惊艳之余也用心思考并实现了出来，现在特地拿出来分享给大家。**
*****

####1.思路
看到这种效果的时候，首先猜测是用UICollectionView实现的，但是正常的UICollectionView的每个Cell都是首尾相连的，现在却是每个Cell都在上一个Cell的正下方，因此我猜测是在滑动的时候将下一个Cell插入到正在滑动的Cell的下方并随着Y轴方向的偏移量而移动。

####2.实现
核心代码：
    - (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
      //获取到当前cell
      int offset = scrollView.contentOffset.y / [UIScreen mainScreen].bounds.size.height ;
      NSIndexPath *index = [NSIndexPath indexPathForItem:offset inSection:0];
      UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:index];
    
      //获取到下一个cell
      NSIndexPath *nextIndex = [NSIndexPath indexPathForItem:offset + 1 inSection:0];
      UICollectionViewCell *nextCell = [self.collectionView cellForItemAtIndexPath:nextIndex];
    
      //将下一个cell插入到当前cell的下方并随着Y轴方向的偏移量而移动
      CGRect rect = nextCell.frame;
      rect.origin.y = scrollView.contentOffset.y;
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
    
      self.offsetY = scrollView.contentOffset.y;
      self.currentCell.alpha = 1.0;
    }
####3.源码
初步效果就这样了，具体使用就仁者见仁、智者见智了。源码放在[gitHub](https://github.com/VeteranDriver/VDDragDemo)上，欢迎大家指正，记得star哦！
