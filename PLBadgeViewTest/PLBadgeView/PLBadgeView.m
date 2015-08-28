//
//  PLBadgeView.m
//  TestBadgeView
//
//  Created by 王鹏 on 15/6/18.
//  Copyright (c) 2015年 王鹏. All rights reserved.
//

#import "PLBadgeView.h"
#define RGB(x,y,z) [UIColor colorWithRed:x/255. green:y/255. blue:z/255. alpha:1.]

@interface PLBadgeView ()
{
    CATextLayer *textLayer;
    CAShapeLayer *backgroundLayer;
}
@end
@implementation PLBadgeView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup
{
    //Set the view properties
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = NO;
    self.clipsToBounds = NO;
    
    //Set the minimum width / height if necessary;
    if (self.frame.size.height == 0 ) {
        CGRect frame = self.frame;
        frame.size.height = 24.0;
        _minimumWidth = 24.0;
        self.frame = frame;
    } else {
        _minimumWidth = self.frame.size.height;
    }
    
    _maximumWidth = CGFLOAT_MAX;

    //Set the default
    _textColor = [UIColor whiteColor];
    _font = [UIFont systemFontOfSize:16.0];
    _cornerRadius = self.frame.size.height / 2;
    _hidesWhenZero = YES;
    _badgeCenter = self.center;
    _badgeBackgroundColor = RGB(239, 89, 65);
    _textPositionAdjustment = UIOffsetMake(4.0, 0.0);
    
    //Create the text layer
    textLayer = [CATextLayer layer];
    textLayer.foregroundColor = _textColor.CGColor;
    //set layer font
    CFStringRef fontName = (__bridge CFStringRef)_font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    textLayer.font = fontRef;
    textLayer.fontSize = _font.pointSize;
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.truncationMode = kCATruncationEnd;
    textLayer.wrapped = NO;
    textLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    
    //Create the background layer
    backgroundLayer = [CAShapeLayer layer];
    backgroundLayer.fillColor = _badgeBackgroundColor.CGColor;
    backgroundLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    backgroundLayer.contentsScale = [UIScreen mainScreen].scale;
    
    [self.layer addSublayer:backgroundLayer];
    [self.layer addSublayer:textLayer];
    
}
#pragma mark layout
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.frame;
    //Get the width for the current string
    if (_text) {
        frame.size.width = [self sizeForString:_text includeBuffer:YES].width + [self textPositionAdjustment].horizontal * 2;
    }
    if (frame.size.width < _minimumWidth) {
        frame.size.width = _minimumWidth;
    } else if (frame.size.width > _maximumWidth) {
        frame.size.width = _maximumWidth;
    }
    
    //Set the corner radius
    _cornerRadius = frame.size.height / 2;
    
    //Change the frame
    self.frame = frame;
    self.center = _badgeCenter;
    
    CGRect tempFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    backgroundLayer.frame = tempFrame;
    
    CGRect textFrame;
    textFrame = CGRectMake([self textPositionAdjustment].horizontal, ((self.frame.size.height - _font.lineHeight) / 2), self.frame.size.width - [self textPositionAdjustment].horizontal * 2, _font.lineHeight);
    textLayer.frame = textFrame;
    
    //Update the paths of the layers
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:tempFrame cornerRadius:_cornerRadius];
    backgroundLayer.path = path.CGPath;

}

- (CGSize)sizeForString:(NSString *)string includeBuffer:(BOOL)include
{
    if (!_font || !string) {
        return CGSizeMake(0, 0);
    }
    
    CGSize textSize = CGSizeZero;
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:(string ? string : @"") attributes:@{NSFontAttributeName : _font}];
        
        textSize = [attributedString boundingRectWithSize:(CGSize){CGFLOAT_MAX, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    }else{
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        textSize = [string sizeWithFont:_font
                           constrainedToSize:(CGSize){CGFLOAT_MAX, CGFLOAT_MAX}];
#endif

    }
    
    return textSize;
}
#pragma mark - Private

- (void)hideForZeroIfNeeded{
    self.hidden = ([_text isEqualToString:@"0"] && _hidesWhenZero);
}
#pragma mark - settings

- (void)setText:(NSString *)text
{
    _text = text;
    //If the new text is shorter, display the new text before shrinking
    if ([self sizeForString:textLayer.string includeBuffer:YES].width >= [self sizeForString:text includeBuffer:YES].width) {
        textLayer.string = text;
        [self setNeedsDisplay];
    } else {
        //If longer display new text after the animation
        textLayer.string = text;
        }
    
    //Update the frame
    [self setNeedsLayout];
    [self layoutIfNeeded];
    //Hide badge if text is zero
    [self hideForZeroIfNeeded];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
