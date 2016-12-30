

#import <UIKit/UIKit.h>

@interface BasicMainVC : UIViewController

@property(nonatomic,assign)CGFloat keyboarHeight;

-(void)addNotifications;
- (void)removeKeyboardNotification;

-(void)keyboardDidShow:(NSNotification *)aNotification;
- (void)keyboardWillShow:(NSNotification *)aNotification;
- (void)keyboardWillHide:(NSNotification *)aNotification;


@end
