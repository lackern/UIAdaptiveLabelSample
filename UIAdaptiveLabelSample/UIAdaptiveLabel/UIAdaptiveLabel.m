//
//  MyLabel.m
//  labelTest
//
//  Created by Lackern on 6/4/15.
//  Copyright (c) 2015 TLC Interactive. All rights reserved.
//

#import "UIAdaptiveLabel.h"
#import "UIFontAdaptiveFont.h"

@implementation UIAdaptiveLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.font = [UIFontAdaptiveFont adaptiveFontWithName:self.font.fontName minSize:5 labelSize:self.frame.size string:self.text];
    
}

@end
