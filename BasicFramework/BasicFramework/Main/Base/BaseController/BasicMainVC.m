
#define backIMG [UIImage imageNamed:@"back"]

#import "BasicMainVC.h"

@interface BasicMainVC ()<UIGestureRecognizerDelegate>

@property(nonatomic,strong)UIBarButtonItem *BarButtonItem;


@end

@implementation BasicMainVC
//=============================================================================
//在相应控制器关闭手势返回
//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
//}
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//}
//-(void)backAction{
//    
//    [self.myAlertView show];
//}
//=============================================================================
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //打开手势返回
    if (self.navigationController != nil && self.navigationController.viewControllers.count > 1) {
        
        self.navigationItem.leftBarButtonItem = self.BarButtonItem;
        self.navigationController.interactivePopGestureRecognizer.enabled = YES ;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - removeKeyboardNotification
- (void)removeKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
}
#pragma mark - addNotifications
-(void)addNotifications
{
    
    
    [kNotificationCenter addObserver:self
                            selector:@selector(keyboardWillShow:)
                                name:UIKeyboardWillShowNotification
                              object:nil];
    
    [kNotificationCenter addObserver:self
                            selector:@selector(keyboardDidShow:)
                                name:UIKeyboardDidShowNotification
                              object:nil];
    
    [kNotificationCenter addObserver:self
                            selector:@selector(keyboardWillHide:)
                                name:UIKeyboardWillHideNotification
                              object:nil];
}
#pragma mark - UIKeyboard - Notification
-(void)keyboardDidShow:(NSNotification *)aNotification
{
    
}
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    self.keyboarHeight = keyboardRect.size.height;
    
}
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    self.keyboarHeight = 0;
}





#pragma mark - lazy
-(UIBarButtonItem *)BarButtonItem
{
    if (!_BarButtonItem) {
        
        UIImageView *imgVC = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 13, 21)];
        imgVC.image = backIMG;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backAction)];
        imgVC.userInteractionEnabled = YES;
        [imgVC addGestureRecognizer:tap];
        imgVC.contentMode = UIViewContentModeScaleAspectFit;
        _BarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imgVC];
    }
    return _BarButtonItem;
}

-(void)dealloc
{
    [kNotificationCenter removeObserver:self];
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
