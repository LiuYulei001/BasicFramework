//
//  TextView_Placeholder.m
//  BasicFramework
//
//  Created by Rainy on 2016/11/7.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import "TextView_Placeholder.h"

@interface TextView_Placeholder ()

@property (nonatomic,weak) UILabel *placeholderLabel;

@end

@implementation TextView_Placeholder

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if(self) {
        
        self.backgroundColor= [UIColor clearColor];
        
        UILabel *placeholderLabel = [[UILabel alloc]init];
        
        placeholderLabel.backgroundColor= [UIColor clearColor];
        
        placeholderLabel.numberOfLines = 0;
        
        [self addSubview:placeholderLabel];
        
        self.placeholderLabel = placeholderLabel;
        
        self.placeholderColor = [UIColor lightGrayColor];
        
        self.font = [UIFont systemFontOfSize:15];
        
        [kNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        
    }
    
    return self;
    
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.placeholderLabel.Y = 8;
    
    self.placeholderLabel.X = 5;
    
    self.placeholderLabel.Sw = self.Sw - self.placeholderLabel.X * 2.0;
    
    self.placeholderLabel.Sh = [self.placeholder sizeWithFont:self.placeholderLabel.font andMaxW:_placeholderLabel.Sw].height;
    
}
- (void)textDidChange {
    
    self.placeholderLabel.hidden = self.hasText;
    
}
-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    self.placeholderLabel.text = placeholder;
    
    [self setNeedsLayout];
}
-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor= placeholderColor;
}

-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    
    [self setNeedsLayout];
    
}

- (void)setText:(NSString*)text{
    
    [super setText:text];
    
    [self textDidChange];
    
}
- (void)setAttributedText:(NSAttributedString*)attributedText
{
    
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}
- (void)dealloc{
    
    [kNotificationCenter removeObserver:self];
    
}



@end
