//
//  GWLPhotoGroupTableViewController.m
//  GWLPhotoSelector
//
//  Created by GaoWanli on 15/7/23.
//  Copyright (c) 2015年 GWL. All rights reserved.
//

#import "GWLPhotoGroupTableViewController.h"
#import "GWLPhotoGroupDetailController.h"

@interface GWLPhotoGroupCell : UITableViewCell

@property(nonatomic, strong) GWLPhotoGroup *photoGroup;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic, weak) UIImageView *iconView;
@property(nonatomic, weak) UILabel *infoLabel;

@end

@implementation GWLPhotoGroupCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"photoGroupCell";
    GWLPhotoGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
        cell = [[GWLPhotoGroupCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
        [self makeCellSubviews];
    return self;
}

- (void)makeCellSubviews {
    UIImageView *iconView = [[UIImageView alloc]init];
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    iconView.backgroundColor = [UIColor clearColor];
    self.iconView = iconView;
    [self addSubview:iconView];
    
    UILabel *infoLabel = [[UILabel alloc]init];
    infoLabel.textAlignment = NSTextAlignmentLeft;
    self.infoLabel = infoLabel;
    [self addSubview:infoLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat padding = 10;
    CGFloat controlWH = 44;
    CGFloat marginLR = 15;
    CGFloat marginTB = (CGRectGetHeight(self.frame) - controlWH) * 0.5;
    
    _iconView.frame = CGRectMake(marginLR, marginTB, controlWH, controlWH);
    
    _infoLabel.frame = CGRectMake(CGRectGetMaxX(_iconView.frame) + padding, marginTB, CGRectGetWidth(self.frame) - CGRectGetMaxX(_iconView.frame) - marginLR, controlWH);
}

- (void)setPhotoGroup:(GWLPhotoGroup *)photoGroup {
    _photoGroup = photoGroup;
    [self.iconView setImage:photoGroup.groupIcon];
    self.infoLabel.text = [NSString stringWithFormat:@"%@(%zd)",photoGroup.groupName,photoGroup.photoALAssets.count];
}

@end

@interface GWLPhotoGroupTableViewController ()

@property(nonatomic, weak) UIView *errorMessageView;
@property(nonatomic, strong) GWLPhotoGroupDetailController *photoGroupDetailController;

@end

@implementation GWLPhotoGroupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"相簿";
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtnDidClick)];
}

- (void)cancelBtnDidClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showErrorMessageView {
    self.errorMessageView.hidden = NO;
}

/**设置数据*/
- (void)setPhotoGroupArray:(NSArray *)photoGroupArray{
    _photoGroupArray = photoGroupArray;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.photoGroupArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GWLPhotoGroupCell *cell = [GWLPhotoGroupCell cellWithTableView:tableView];
    GWLPhotoGroup *photoGroup = self.photoGroupArray[indexPath.section];
    if (photoGroup.photoALAssets.count == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else {
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    cell.photoGroup = photoGroup;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kGWLPhotoSelector_Cell_Height;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GWLPhotoGroup *photoGroup = self.photoGroupArray[indexPath.section];
    if (photoGroup.photoALAssets.count == 0)
        return;
    GWLPhotoGroupDetailController *photoGroupDetailController;
    if (!self.canMultiAlbumSelect) {
        for (GWLPhotoGroup *photoGroup in self.photoGroupArray) {
            for (GWLPhotoALAssets *photoALAssets in photoGroup.photoALAssets) {
                photoALAssets.selected = NO;
            }
        }
        photoGroupDetailController = [[GWLPhotoGroupDetailController alloc]init];
        photoGroupDetailController.maxCount = self.maxCount;
        photoGroupDetailController.block = self.block;
    }else {
        if (!_photoGroupDetailController) {
            _photoGroupDetailController = [[GWLPhotoGroupDetailController alloc]init];
            _photoGroupDetailController.maxCount = self.maxCount;
            _photoGroupDetailController.block = self.block;
        }
        photoGroupDetailController = _photoGroupDetailController;
    }
    photoGroupDetailController.photoALAssets = photoGroup.photoALAssets;
    [self.navigationController pushViewController:photoGroupDetailController animated:YES];
}

#pragma mark - getter && setter
- (void)setMaxCount:(NSInteger)maxCount {
    _maxCount = maxCount;
}

- (UIView *)errorMessageView {
    if (!_errorMessageView) {
        UIView *errorMessageView = [[UIView alloc]init];
        errorMessageView.backgroundColor = [UIColor whiteColor];
        errorMessageView.frame = self.view.bounds;
        errorMessageView.hidden = YES;
        self.errorMessageView = errorMessageView;
        [self.view addSubview:errorMessageView];
        
        UILabel *msgLabel = [[UILabel alloc]init];
        msgLabel.text = kGWLPhotoSelector_ErrorMessageText;
        msgLabel.backgroundColor = [UIColor clearColor];
        msgLabel.font = [UIFont systemFontOfSize:15];
        msgLabel.textAlignment = NSTextAlignmentCenter;
        msgLabel.textColor = [UIColor lightGrayColor];
        CGFloat msgLabelHeight = 15;
        msgLabel.frame = CGRectMake(0, (CGRectGetHeight(errorMessageView.frame) - msgLabelHeight - 64) * 0.5 , CGRectGetWidth(errorMessageView.frame), msgLabelHeight);
        [errorMessageView addSubview:msgLabel];
        
        _errorMessageView = errorMessageView;
    }
    return _errorMessageView;
}

@end
