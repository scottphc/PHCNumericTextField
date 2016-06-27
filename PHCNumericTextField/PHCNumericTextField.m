//
//  PHCNumericTextField.m
//  Pods
//
//  Created by Scott Chou on 6/3/16.
//
//

#import "PHCNumericTextField.h"

@interface PHCNumericTextField ()

@property (strong, nonatomic) UIFont *originalFont;
@property (strong, nonatomic) NSNumberFormatter *numberFormatter;

@end

@implementation PHCNumericTextField

- (void)awakeFromNib {
    self.originalFont = self.font;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.originalFont = font;
}

- (void)setMinimumFractionDigits:(NSInteger)minimumFractionDigits {
    self.numberFormatter.minimumFractionDigits = minimumFractionDigits;
}

- (void)setMaximumFractionDigits:(NSInteger)maximumFractionDigits {
    self.numberFormatter.maximumFractionDigits = maximumFractionDigits;
}

#pragma mark - Private methods

- (void)formatText {
    NSInteger cursorStart = [self offsetFromPosition:self.beginningOfDocument toPosition:self.selectedTextRange.start];
    NSInteger groupingSeparatorCount = [self countOfGroupingSeparatorInRange:NSMakeRange(0, cursorStart)];
    NSInteger numberCount = cursorStart - groupingSeparatorCount;
    
    self.font = self.originalFont;
    self.attributedText = [self formattedTextFrom:super.text];
    
    __block NSInteger currentNumberCount = 0;
    __block NSInteger newCursorStart = 0;
    [super.text enumerateSubstringsInRange:NSMakeRange(0, [super.text length]) options:(NSStringEnumerationByComposedCharacterSequences) usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        if (currentNumberCount == numberCount) {
            *stop = YES;
        } else {
            newCursorStart++;
            if ([substring isEqualToString:self.numberFormatter.groupingSeparator] == NO) {
                currentNumberCount++;
            }
        }
    }];
    
    UITextPosition *newCursorStartPosition = [self positionFromPosition:self.beginningOfDocument offset:newCursorStart];
    self.selectedTextRange = [self textRangeFromPosition:newCursorStartPosition toPosition:newCursorStartPosition];
}

- (NSAttributedString *)formattedTextFrom:(NSString *)text {
    NSString *formattedText;
    
    NSRange range = [text rangeOfString:self.numberFormatter.decimalSeparator];
    if (range.location != NSNotFound) {
        NSNumber *numberText = [self.numberFormatter numberFromString:[text substringToIndex:range.location]];
        formattedText = [[self.numberFormatter stringFromNumber:numberText] stringByAppendingString:[text substringFromIndex:range.location]];
    } else {
        NSNumber *numberText = [self.numberFormatter numberFromString:text];
        formattedText = [self.numberFormatter stringFromNumber:numberText];
    }
    
    if (formattedText == nil) {
        return nil;
    }
    
    NSRange pointRange = [formattedText rangeOfString:self.numberFormatter.decimalSeparator];
    if (pointRange.location == NSNotFound) {
        return [[NSAttributedString alloc] initWithString:formattedText];
    } else {
        NSMutableAttributedString *attrFormattedText = [[NSMutableAttributedString alloc] initWithString:formattedText];
        UIFont *smallFont = [self.font fontWithSize:self.font.pointSize*0.75f];
        [attrFormattedText setAttributes:@{NSFontAttributeName: smallFont} range:NSMakeRange(pointRange.location, formattedText.length - pointRange.location)];
        return attrFormattedText;
    }
}

- (NSInteger)countOfGroupingSeparatorInRange:(NSRange)range {
    __block NSInteger groupingSeparatorCount = 0;
    [super.text enumerateSubstringsInRange:range options:(NSStringEnumerationByComposedCharacterSequences) usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        if ([substring isEqualToString:self.numberFormatter.groupingSeparator]) {
            groupingSeparatorCount++;
        }
    }];
    
    return groupingSeparatorCount;
}

#pragma mark - Override Methods

- (void)setText:(NSString *)text {
    self.font = self.originalFont;
    self.attributedText = [self formattedTextFrom:text];
}

- (void)insertText:(NSString *)text {
    [super insertText:text];
    [self formatText];
}

- (void)deleteBackward {
    NSInteger cursorStart = [self offsetFromPosition:self.beginningOfDocument toPosition:self.selectedTextRange.start];
    
    if ([[super.text substringToIndex:cursorStart] hasSuffix:self.numberFormatter.groupingSeparator]) {
        [super deleteBackward];
        [super deleteBackward];
    } else
        [super deleteBackward];
    
    [self formatText];
}

#pragma mark - Getter

- (NSNumberFormatter *)numberFormatter {
    if (_numberFormatter) {
        return _numberFormatter;
    }
    
    _numberFormatter = [[NSNumberFormatter alloc] init];
    _numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    _numberFormatter.lenient = YES;
    _numberFormatter.minimumFractionDigits = 0;
    _numberFormatter.maximumFractionDigits = INT_MAX;
    
    return _numberFormatter;
}

@end
