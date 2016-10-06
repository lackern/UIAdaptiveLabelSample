//
//  UIFont.h
//  labelTest
//
//  Created by Lackern on 6/4/15.
//  Copyright (c) 2015 TLC Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFontAdaptiveFont : UIFont

+ (UIFont *)adaptiveFontWithName:(NSString *)fontName minSize:(NSInteger)minSize labelSize:(CGSize)labelSize string:(NSString *)string;

@end

