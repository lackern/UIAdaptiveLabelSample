//
//  UIFont.m
//  labelTest
//
//  Created by Lackern on 6/4/15.
//  Copyright (c) 2015 TLC Interactive. All rights reserved.
//

#import "UIFontAdaptiveFont.h"

typedef enum
{
    kDimensionHeight,
    kDimensionWidth,
} DimensionType;

@implementation UIFontAdaptiveFont

+ (UIFont *)_adaptiveFontWithName:(NSString *)fontName minSize:(NSInteger)minSize labelDimension:(CGFloat)labelDimension testString:(NSString *)testString dimension:(DimensionType)dimension
{
    UIFont *tempFont = nil;
    NSInteger tempMin = minSize;
    NSInteger tempMax = 256;
    NSInteger mid = 0;
    NSInteger difference = 0;
    CGFloat testStringDimension = 0.0;
    
    while (tempMin <= tempMax) {
        @autoreleasepool {
            mid = tempMin + (tempMax - tempMin) / 2;
            tempFont = [UIFont fontWithName:fontName size:mid];
            
            // determine dimension to test
            if (dimension == kDimensionHeight) {
                testStringDimension = [testString sizeWithFont:tempFont].height;
            } else {
                testStringDimension = [testString sizeWithFont:tempFont].width;
            }
            difference = labelDimension - testStringDimension;
            
            if (mid == tempMin || mid == tempMax) {
                if (difference < 0) {
                    return [UIFont fontWithName:fontName size:(mid - 1)];
                }
                return [UIFont fontWithName:fontName size:mid];
            }
            
            if (difference < 0) {
                tempMax = mid - 1;
            } else if (difference > 0) {
                tempMin = mid + 1;
            } else {
                return [UIFont fontWithName:fontName size:mid];
            }
        }
    }
    return [UIFont fontWithName:fontName size:mid];
}

+ (UIFont *)adaptiveFontWithName:(NSString *)fontName minSize:(NSInteger)minSize labelSize:(CGSize)labelSize string:(NSString *)string
{
    UIFont *adaptiveFont = nil;
    NSString *testString = nil;
    
    // get font, given a max height
    testString = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    
    UIFont *fontConstrainingHeight = [self _adaptiveFontWithName:fontName minSize:minSize labelDimension:labelSize.height testString:testString dimension:kDimensionHeight];
    CGSize boundsConstrainingHeight = [string sizeWithFont:fontConstrainingHeight];
    CGSize boundsConstrainingWidth = CGSizeZero;
    
    // if WIDTH is fine (while constraining HEIGHT), return that font
    if (boundsConstrainingHeight.width <= labelSize.width) {
        adaptiveFont = fontConstrainingHeight;
    } else {
        // get font, given a max width
        // i.e., fontConstrainingWidth
        testString = string;
        adaptiveFont = [self _adaptiveFontWithName:fontName minSize:minSize labelDimension:labelSize.width testString:testString dimension:kDimensionWidth];
        
        // TEST comparison
        boundsConstrainingWidth = [string sizeWithFont:adaptiveFont];
    }
    return adaptiveFont;
}

@end
