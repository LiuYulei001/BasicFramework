//
//  LYLCollectionViewLayout.m
//  BasicFramework
//
//  Created by Rainy on 2017/3/16.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "LYLCollectionViewLayout.h"

static const CGFloat inset = 10;
static const CGFloat colCount = 3;
static const CGFloat Spacing = 0;

@interface LYLCollectionViewLayout ()

@property (nonatomic, strong) NSMutableDictionary *colunMaxYDic;

@end

@implementation LYLCollectionViewLayout

- (instancetype)init
{
    if (self=[super init]) {
        
        self.itemForHeaderFooterSpacing = Spacing;
        self.itemSpacing = inset;
        self.lineSpacing = inset;
        self.sectionInset = UIEdgeInsetsMake(inset, inset, inset, inset);
        self.colCount = colCount;
        self.colunMaxYDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (CGSize)collectionViewContentSize
{
    __block NSString * maxCol = @"0";
    //遍历找出最高的列
    [self.colunMaxYDic enumerateKeysAndObjectsUsingBlock:^(NSString * column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] > [self.colunMaxYDic[maxCol] floatValue]) {
            maxCol = column;
        }
    }];
    
    return CGSizeMake(0, [self.colunMaxYDic[maxCol] floatValue]);
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    __block NSString * minCol = @"0";
    //遍历找出最短的列
    [self.colunMaxYDic enumerateKeysAndObjectsUsingBlock:^(NSString * column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] < [self.colunMaxYDic[minCol] floatValue]) {
            minCol = column;
        }
    }];
    
    //    宽度
    CGFloat width = (self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right- (self.colCount-1) * self.itemSpacing)/self.colCount;
    //    高度
    CGFloat height = 0;
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:heightForWidth:atIndexPath:)]) {
        height = [self.delegate collectionView:self.collectionView layout:self heightForWidth:width atIndexPath:indexPath];
    }
    
    CGFloat x = self.sectionInset.left + (width + self.itemSpacing) * [minCol intValue];
    
    CGFloat space = 0.0;
    if (indexPath.item < self.colCount) {
        space = self.itemForHeaderFooterSpacing;
    }else{
        space = self.lineSpacing;
    }
    CGFloat y =[self.colunMaxYDic[minCol] floatValue] + space;
    
    //    跟新对应列的高度
    self.colunMaxYDic[minCol] = @(y + height);
    
    //    计算位置
    UICollectionViewLayoutAttributes * attri = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attri.frame = CGRectMake(x, y, width, height);
    
    return attri;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    
    __block NSString * maxCol = @"0";
    //遍历找出最高的列
    [self.colunMaxYDic enumerateKeysAndObjectsUsingBlock:^(NSString * column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] > [self.colunMaxYDic[maxCol] floatValue]) {
            maxCol = column;
        }
    }];
    
    //header
    if ([UICollectionElementKindSectionHeader isEqualToString:elementKind]) {
        UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:indexPath];
        //size
        CGSize size = CGSizeZero;
        if ([self.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)]) {
            size = [self.delegate collectionView:self.collectionView layout:self referenceSizeForHeaderInSection:indexPath.section];
        }
//        CGFloat x = self.sectionInset.left;
        CGFloat y = [[self.colunMaxYDic objectForKey:maxCol] floatValue] + self.itemForHeaderFooterSpacing;
        
        //    跟新所有对应列的高度
        for(NSString *key in self.colunMaxYDic.allKeys)
        {
            self.colunMaxYDic[key] = @(y + size.height);
        }
        
        attri.frame = CGRectMake(0 , indexPath.section ? y :0, size.width, size.height);
        return attri;
    }
    
    //footer
    else{
        UICollectionViewLayoutAttributes *attri = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:indexPath];
        //size
        CGSize size = CGSizeZero;
        if ([self.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForFooterInSection:)]) {
            size = [self.delegate collectionView:self.collectionView layout:self referenceSizeForFooterInSection:indexPath.section];
        }
//        CGFloat x = self.sectionInset.left;
        CGFloat y = [[self.colunMaxYDic objectForKey:maxCol] floatValue] + self.itemForHeaderFooterSpacing;
        
        //    跟新所有对应列的高度
        for(NSString *key in self.colunMaxYDic.allKeys)
        {
            self.colunMaxYDic[key] = @(y + size.height);
        }
        
        attri.frame = CGRectMake(0 , y, size.width, size.height);
        return attri;
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    for(NSInteger i = 0;i < self.colCount; i++)
    {
        NSString * col = [NSString stringWithFormat:@"%ld",(long)i];
        self.colunMaxYDic[col] = @0;
    }
    
    NSMutableArray * attrsArray = [NSMutableArray array];
    
    NSInteger section = [self.collectionView numberOfSections];
    for (NSInteger i = 0 ; i < section; i++) {
        
        //获取header的UICollectionViewLayoutAttributes
        UICollectionViewLayoutAttributes *headerAttrs = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:i]];
        [attrsArray addObject:headerAttrs];
        
        //获取item的UICollectionViewLayoutAttributes
        NSInteger count = [self.collectionView numberOfItemsInSection:i];
        for (NSInteger j = 0; j < count; j++) {
            UICollectionViewLayoutAttributes * attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:j inSection:i]];
            [attrsArray addObject:attrs];
        }
        
        //获取footer的UICollectionViewLayoutAttributes
        UICollectionViewLayoutAttributes *footerAttrs = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:[NSIndexPath indexPathForItem:0 inSection:i]];
        [attrsArray addObject:footerAttrs];
    }
    
    return  attrsArray;
}
@end
