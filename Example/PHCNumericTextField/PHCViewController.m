//
//  PHCViewController.m
//  PHCNumericTextField
//
//  Created by scott on 06/03/2016.
//  Copyright (c) 2016 scott. All rights reserved.
//

#import "PHCViewController.h"
#import <PHCNumericTextField/PHCNumericTextField.h>
#import "AmountKeyboardView.h"

@interface PHCViewController ()

@property (weak, nonatomic) IBOutlet PHCNumericTextField *numberTextField;

@end

@implementation PHCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    AmountKeyboardView *keyboardView = [[AmountKeyboardView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.numberTextField.inputView = keyboardView;
    keyboardView.textField = self.numberTextField;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
