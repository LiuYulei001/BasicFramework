//
//  LYLPageVC.m
//  BasicFramework
//
//  Created by Rainy on 2017/3/20.
//  Copyright © 2017年 Rainy. All rights reserved.
//

#import "LYLPageVC.h"

@interface LYLPageVC ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property(nonatomic,strong)UIPageViewController *myPageVC;

@end

@implementation LYLPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark - <UIPageViewControllerDelegate,UIPageViewControllerDataSource>
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = [self.controllers indexOfObject:viewController];
    return index ? self.controllers[index - 1] : nil;
}
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = [self.controllers indexOfObject:viewController];
    if (index == self.controllers.count - 1) {
        return nil;
    }
    return self.controllers[index + 1];
}
-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return self.controllers.count;
}
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    UIViewController *temp_VC = pageViewController.viewControllers[0];
    if (temp_VC) {
        NSInteger index = [self.controllers indexOfObject:temp_VC];
        if (self.delegate && [self.delegate respondsToSelector:@selector(pageVCDidEndScrollAtIndex:)]) {
            [self.delegate pageVCDidEndScrollAtIndex:index];
        }
    }
}

#pragma mark - setCurentController
-(void)setCurrentControllerAtIndex:(NSInteger )index
{
    if (index < 0 || index > self.controllers.count - 1) {
        
        return;
    }
    [self.myPageVC setViewControllers:@[self.controllers[index]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

#pragma mark - set
-(void)setControllers:(NSArray *)controllers
{
    if (!controllers || !controllers.count) {
        return;
    }
    _controllers = controllers;
    [self setCurrentControllerAtIndex:0];
    
}
-(UIPageViewController *)myPageVC
{
    if (!_myPageVC) {
        
        _myPageVC = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _myPageVC.delegate = self;
        _myPageVC.dataSource = self;
        _myPageVC.view.frame = self.view.bounds;
        [self.view addSubview:_myPageVC.view];
    }
    return _myPageVC;
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
