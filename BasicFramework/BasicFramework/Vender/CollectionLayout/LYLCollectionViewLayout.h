//
//  LYLCollectionViewLayout.h
//  BasicFramework
//
//  Created by Rainy on 2017/3/16.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYLCollectionViewLayout;

@protocol LYLCollectionViewLayoutDelegate <NSObject>

@required
//item heigh
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(LYLCollectionViewLayout *)collectionViewLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath*)indexPath;

@optional
//section header
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(LYLCollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
//section footer
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(LYLCollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;

@end

@interface LYLCollectionViewLayout : UICollectionViewLayout

@property(nonatomic, assign)UIEdgeInsets sectionInset; //sectionInset
@property(nonatomic, assign)CGFloat lineSpacing;  //line space
@property(nonatomic, assign)CGFloat itemSpacing; //item space
@property(nonatomic, assign)CGFloat itemForHeaderFooterSpacing;
@property(nonatomic, assign)CGFloat colCount; //column count
@property(nonatomic, weak)id<LYLCollectionViewLayoutDelegate> delegate;

@end
