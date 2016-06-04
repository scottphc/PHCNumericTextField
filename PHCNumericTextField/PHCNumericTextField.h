//
//  PHCNumericTextField.h
//  Pods
//
//  Created by Scott Chou on 6/3/16.
//
//

#import <UIKit/UIKit.h>

@interface PHCNumericTextField : UITextField

- (void)setMinimumFractionDigits:(NSInteger)minimumFractionDigits;
- (void)setMaximumFractionDigits:(NSInteger)maximumFractionDigits;

@end
