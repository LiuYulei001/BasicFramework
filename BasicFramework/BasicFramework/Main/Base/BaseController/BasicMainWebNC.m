//
//  SPIMainWebNavigationController.m
//  SPI-Piles
//
//  Created by SPI-绿能宝 on 16/5/18.
//  Copyright © 2016年 北京SPI绿能宝. All rights reserved.
//

#import "BasicMainWebNC.h"

//#import "SPIServiceWebVC.h"


@interface BasicMainWebNC ()<UINavigationBarDelegate>


@property BOOL shouldPopItemAfterPopViewController;

@end

@implementation BasicMainWebNC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setItems];
    
}
-(void)setItems
{
    self.shouldPopItemAfterPopViewController = NO;
    
    [[UINavigationBar appearance]setBackgroundImage:[UIImage createImageWithColor:kThemeColor] forBarMetrics:UIBarMetricsDefault];
    NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:dic];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    [[UIBarButtonItem appearance]setTitleTextAttributes:dic forState:UIControlStateNormal];
    //    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    UIImage *backItemImage = [[UIImage imageNamed:@"back"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 0, 0) resizingMode:UIImageResizingModeStretch];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setBackButtonBackgroundImage:backItemImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

-(UIViewController*)popViewControllerAnimated:(BOOL)animated{
    self.shouldPopItemAfterPopViewController = YES;
    return [super popViewControllerAnimated:animated];
}

-(NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    self.shouldPopItemAfterPopViewController = YES;
    return [super popToViewController:viewController animated:animated];
}

-(NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated{
    self.shouldPopItemAfterPopViewController = YES;
    return [super popToRootViewControllerAnimated:animated];
}
-(BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item{
    
    if (self.shouldPopItemAfterPopViewController) {
        self.shouldPopItemAfterPopViewController = NO;
        return YES;
    }
    
//    if ([self.topViewController isKindOfClass:[SPIServiceWebVC class]]) {
//        SPIServiceWebVC* webVC = (SPIServiceWebVC *)self.viewControllers.lastObject;
//        if (webVC.myWebView.canGoBack) {
//            
//            
//            [webVC.myWebView goBack];
//            [webVC.snapShotsArray removeLastObject];
//            
//            self.shouldPopItemAfterPopViewController = NO;
//            
//            return NO;
//        }else{
//            [self popViewControllerAnimated:YES];
//            return NO;
//        }
//    }else{
        [self popViewControllerAnimated:YES];
        return NO;
//    }
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
