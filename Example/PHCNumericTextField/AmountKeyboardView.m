//
//  AmountKeyboardView.m
//  PHCNumericTextField
//
//  Created by scott on 06/03/2016.
//  Copyright (c) 2016 scott. All rights reserved.
//

#import "AmountKeyboardView.h"

@interface AmountKeyboardView ()

@end

@implementation AmountKeyboardView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initial];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initial];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initial];
    }
    return self;
}

- (void)dealloc {
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    CGFloat height = (size.height + 5) / 4;
    CGFloat width = (size.width + 6) / 4;
    
    if (self.numberButtons.count < 11) {
        [self.numberButtons[7] setFrame:CGRectMake(-1, 0, width, height)];
        [self.numberButtons[8] setFrame:CGRectMake(-2+width, 0, width, height)];
        [self.numberButtons[9] setFrame:CGRectMake(-3+width*2, 0, width, height)];
        
        [self.numberButtons[4] setFrame:CGRectMake(-1, height*1-2, width, height)];
        [self.numberButtons[5] setFrame:CGRectMake(-2+width, height*1-2, width, height)];
        [self.numberButtons[6] setFrame:CGRectMake(-3+width*2, height*1-2, width, height)];
        
        [self.numberButtons[1] setFrame:CGRectMake(-1, height*2-3, width, height)];
        [self.numberButtons[2] setFrame:CGRectMake(-2+width, height*2-3, width, height)];
        [self.numberButtons[3] setFrame:CGRectMake(-3+width*2, height*2-3, width, height)];
        
        self.number00Button.frame = CGRectMake(-1, height*3-4, width, height);
        [self.numberButtons[0] setFrame:CGRectMake(-2+width, height*3-4, width, height)];
        self.pointButton.frame = CGRectMake(-3+width*2, height*3-4, width, height);
    }
    
    self.acButton.frame = CGRectMake(-4+width*3, -1, width, height);
    self.backButton.frame = CGRectMake(-4+width*3, height*1-2, width, height);
}

- (void)initial {
    UIColor *borderColor = [UIColor blackColor];
    UIColor *textColor = [UIColor blackColor];
    UIColor *normalColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    UIColor *functionColor = [UIColor colorWithRed:0.79 green:0.79 blue:0.8 alpha:0.7];
    
    _acButton = [UIButton new];
    [self.acButton setTitle:@"AC" forState:UIControlStateNormal];
    [self.acButton addTarget:self action:@selector(acButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.acButton setTitleColor:textColor forState:UIControlStateNormal];
    [self.acButton layer].borderColor = borderColor.CGColor;
    self.acButton.backgroundColor = functionColor;
    [self addSubview:self.acButton];
    
    _backButton = [UIButton new];
    [self.backButton setTitle:@"⌫" forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.backButton setTitleColor:textColor forState:UIControlStateNormal];
    [self.backButton layer].borderColor = borderColor.CGColor;
    self.backButton.backgroundColor = functionColor;
    [self addSubview:self.backButton];
    
    // Add number button
    NSMutableArray *numberButtons = [NSMutableArray array];
    for (NSInteger number = 0; number < 10; number++) {
        UIButton *numberButton = [UIButton new];
        [numberButton setTitle:[NSString stringWithFormat:@"%td", number] forState:UIControlStateNormal];
        numberButton.tag = number;
        [numberButton addTarget:self action:@selector(numberButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:numberButton];
        [numberButtons addObject:numberButton];
        
        [numberButton setTitleColor:textColor forState:UIControlStateNormal];
        [numberButton layer].borderColor = borderColor.CGColor;
        numberButton.backgroundColor = normalColor;
    }
    self.numberButtons = numberButtons;
    
    _number00Button = [UIButton new];
    [self.number00Button setTitle:@"00" forState:UIControlStateNormal];
    [self.number00Button addTarget:self action:@selector(number00ButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.number00Button setTitleColor:textColor forState:UIControlStateNormal];
    [self.number00Button layer].borderColor = borderColor.CGColor;
    self.number00Button.backgroundColor = normalColor;
    [self addSubview:self.number00Button];
    
    _pointButton = [UIButton new];
    NSString *decimalPoint = [[NSLocale currentLocale] objectForKey:NSLocaleDecimalSeparator];
    if ([decimalPoint isEqualToString:@""] == NO)
        [self.pointButton setTitle:decimalPoint forState:UIControlStateNormal];
    [self.pointButton addTarget:self action:@selector(pointButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.pointButton setTitleColor:textColor forState:UIControlStateNormal];
    [self.pointButton layer].borderColor = borderColor.CGColor;
    self.pointButton.backgroundColor = normalColor;
    [self addSubview:self.pointButton];
}

#pragma mark - Button Event

- (void)numberButtonClicked:(UIButton *)button {
    NSInteger startOffset = [self.textField offsetFromPosition:self.textField.beginningOfDocument toPosition:self.textField.selectedTextRange.start];
    NSInteger endOffset = [self.textField offsetFromPosition:self.textField.beginningOfDocument toPosition:self.textField.selectedTextRange.end];
    if (startOffset == 0 && endOffset != 0 && endOffset == self.textField.text.length)
        self.textField.text = @"";
    
    if ([self.textField.text isEqualToString:@"0"])
        self.textField.text = @"";
    
    [self.textField insertText:[NSString stringWithFormat:@"%td", button.tag]];
}

- (void)number00ButtonClicked:(UIButton *)button {
    NSInteger startOffset = [self.textField offsetFromPosition:self.textField.beginningOfDocument toPosition:self.textField.selectedTextRange.start];
    NSInteger endOffset = [self.textField offsetFromPosition:self.textField.beginningOfDocument toPosition:self.textField.selectedTextRange.end];
    if (startOffset == 0 && endOffset != 0 && endOffset == self.textField.text.length)
        self.textField.text = @"";
    
    if ([self.textField.text isEqualToString:@"0"])
        self.textField.text = @"";
    
    if ([self.textField.text isEqualToString:@""]) {
        [self.textField insertText:@"0"];
    } else
        [self.textField insertText:@"00"];
}

- (void)pointButtonClicked:(id)sender {
    NSString *decimalPoint = [[NSLocale currentLocale] objectForKey:NSLocaleDecimalSeparator];
    if ([decimalPoint isEqualToString:@""])
        decimalPoint = @".";

    NSRange range = [self.textField.text rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:decimalPoint]];
    if (range.location == NSNotFound)
        [self.textField insertText:decimalPoint];
}

- (void)acButtonClicked:(id)sender {
    self.textField.text = @"";
    [self.textField insertText:@"0"];
}

- (void)cButtonClicked:(id)sender {
    self.textField.text = @"";
    [self.textField insertText:@"0"];
}

- (void)backButtonClicked:(id)sender {
    if (self.textField.text.length > 1) {
        [self.textField deleteBackward];
    } else {
        self.textField.text = @"";
        [self.textField insertText:@"0"];
    }
}

@end
