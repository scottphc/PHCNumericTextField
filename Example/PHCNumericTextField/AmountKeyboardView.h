//
//  AmountKeyboardView.h
//  PHCNumericTextField
//
//  Created by scott on 06/03/2016.
//  Copyright (c) 2016 scott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AmountKeyboardView : UIView

@property (strong, nonatomic, readonly) UIButton *number00Button;
@property (strong, nonatomic) NSArray *numberButtons;
@property (strong, nonatomic, readonly) UIButton *pointButton;
@property (strong, nonatomic, readonly) UIButton *acButton;
@property (strong, nonatomic, readonly) UIButton *backButton;

@property (assign, nonatomic) UITextField *textField; // assign

@end
