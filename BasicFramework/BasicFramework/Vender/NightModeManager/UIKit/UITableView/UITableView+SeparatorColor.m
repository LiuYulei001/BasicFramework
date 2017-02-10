

#import "UITableView+SeparatorColor.h"
#import "DKNightVersionManager.h"
#import "objc/runtime.h"

@interface UITableView ()

@property (nonatomic, strong) UIColor *normalSeparatorColor;

@end

@implementation UITableView (SeparatorColor)

+ (void)load {
    static dispatch_once_t onceToken;                                              
    dispatch_once(&onceToken, ^{                                                   
        Class class = [self class];                                                
        SEL originalSelector = @selector(setSeparatorColor:);                                  
        SEL swizzledSelector = @selector(hook_setSeparatorColor:);                                 
        Method originalMethod = class_getInstanceMethod(class, originalSelector);  
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);  
        BOOL didAddMethod =                                                        
        class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));                   
        if (didAddMethod){
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));           
        } else {                                                                   
            method_exchangeImplementations(originalMethod, swizzledMethod);        
        }
    });
    [DKNightVersionManager addClassToSet:self.class];
}

- (void)hook_setSeparatorColor:(UIColor*)separatorColor {
    if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNormal) [self setNormalSeparatorColor:separatorColor];
    [self hook_setSeparatorColor:separatorColor];
}

- (UIColor *)nightSeparatorColor {
    UIColor *nightColor = objc_getAssociatedObject(self, @selector(nightSeparatorColor));
    if (nightColor) {
        return nightColor;
    } else if ([DKNightVersionManager useDefaultNightColor] && self.defaultNightSeparatorColor) {
        return self.defaultNightSeparatorColor;
    } else {
        UIColor *resultColor = self.normalSeparatorColor ?: [UIColor clearColor];
        return resultColor;
    }
}

- (void)setNightSeparatorColor:(UIColor *)nightSeparatorColor {
    if ([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) [self setSeparatorColor:nightSeparatorColor];
    objc_setAssociatedObject(self, @selector(nightSeparatorColor), nightSeparatorColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)normalSeparatorColor {
    return objc_getAssociatedObject(self, @selector(normalSeparatorColor));
}

- (void)setNormalSeparatorColor:(UIColor *)normalSeparatorColor {
    objc_setAssociatedObject(self, @selector(normalSeparatorColor), normalSeparatorColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)defaultNightSeparatorColor {
    return [self isMemberOfClass:[UITableView class]] ? UIColorFromRGB(0x313131) : nil;
}

@end
