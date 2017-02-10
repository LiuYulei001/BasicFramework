

/**
 
 使用方法例：
 控制器：
 - (void)viewDidLoad {
 [super viewDidLoad];
 [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"Cell"];
 self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
 UILabel *navigationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 375, 44)];
 navigationLabel.text = @"DKNightVersion";
 navigationLabel.textAlignment = NSTextAlignmentCenter;
*navigationLabel.nightTextColor = [UIColor whiteColor];
 self.navigationItem.titleView = navigationLabel;
 
 UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Present" style:UIBarButtonItemStylePlain target:self action:@selector(present)];
 self.navigationItem.leftBarButtonItem = item;
 item.tintColor = [UIColor blackColor];
*item.nightTintColor = [UIColor greenColor];
*[DKNightVersionManager setUseDefaultNightColor:YES];
 }
 - (void)nightFalls {
*[DKNightVersionManager nightFalling];
 }
 - (void)dawnComes {
*[DKNightVersionManager dawnComing];
 }
 视图：
*[DKNightVersionManager addClassToSet:self.class];
 self.label = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 230, 80)];
 self.label.numberOfLines = 0;
 self.label.text = @"DKNightVersion is a light wei-ght framework adding night   version to your iOS app.";
 self.label.textColor = [UIColor darkGrayColor];
*self.label.nightTextColor = [UIColor whiteColor];
 self.label.lineBreakMode = NSLineBreakByCharWrapping;
*self.nightBackgroundColor = UIColorFromRGB(0x343434);
 [self.contentView addSubview:self.label];
 
 CGRect rect = CGRectMake(250, 10, 120, 80);
 self.button = [[UIButton alloc] initWithFrame:rect];
 self.button.titleLabel.font = [UIFont systemFontOfSize:20];
*self.button.nightTitleColor = [UIColor whiteColor];
 [self.button setTitleColor:[UIColor colorWithRed:0.478 green:0.651 blue:0.988 alpha:1.0] forState:UIControlStateNormal];
 
 */

#ifndef DKNightVerision_DKNightVersion_h
#define DKNightVerision_DKNightVersion_h

#import "DKNightVersionManager.h"
#import "UILabel+NightVersion.h"
#import "UIView+NightVersion.h"
#import "UIScrollView+NightVersion.h"
#import "UITableView+NightVersion.h"
#import "UITableViewCell+NightVersion.h"
#import "UINavigationBar+NightVersion.h"
#import "UITabBar+NightVersion.h"
#import "UIButton+NightVersion.h"
#import "UIBarButtonItem+NightVersion.h"
#import "UIViewController+ChangeColor.h"


#endif
