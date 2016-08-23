//
//  SPIMainNavigationVC.m
//  SPI-Piles
//
//  Created by SPI-绿能宝 on 16/5/11.
//  Copyright © 2016年 北京SPI绿能宝. All rights reserved.
//

#import "BasicMainNC.h"


@interface BasicMainNC ()



@end

@implementation BasicMainNC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setItems];
    
}
-(void)setItems
{    
    [[UINavigationBar appearance]setBackgroundImage:[UIImage createImageWithColor:kThemeColor] forBarMetrics:UIBarMetricsDefault];
    NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:dic];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearance]setTitleTextAttributes:dic forState:UIControlStateNormal];
    //    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    UIImage *backItemImage = [[UIImage imageNamed:@"back"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 0, 0) resizingMode:UIImageResizingModeStretch];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setBackButtonBackgroundImage:backItemImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
