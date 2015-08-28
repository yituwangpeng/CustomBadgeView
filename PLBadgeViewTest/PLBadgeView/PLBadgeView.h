//
//  PLBadgeView.h
//  TestBadgeView
//
//  Created by 王鹏 on 15/6/18.
//  Copyright (c) 2015年 王鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLBadgeView : UIView
/**@name Text*/
/**The text to display in the badge.*/
@property (nonatomic, retain) NSString *text;
/**The color of the text.*/
@property (nonatomic, retain) UIColor *textColor;
/**The font of the text.*/
@property (nonatomic, retain) UIFont *font;

/**@name Badge*/
/**The background color of the badge.*/
@property (nonatomic, retain) UIColor *badgeBackgroundColor;
/**Wether or not the badge has a glossy overlay.*/
@property (nonatomic, assign) BOOL showGloss;
/**The corner radius of the badge.
 @note This will be set automatically unless manually set.*/
@property (nonatomic, assign) CGFloat cornerRadius;

/**The minimum width of the badge.
 @note This setting only has an effect if it is larger than the height of the badge. The minimum shape will otherwise always be a circle.*/
@property (nonatomic, assign) CGFloat minimumWidth;
/**The maximum width of the badge.
 @note This setting only has an effect if it is larger than the height of the badge. If the size of the badge exceeds this size, the text will be truncated and "..." will be tacked onto the end of the string.*/
@property (nonatomic, assign) CGFloat maximumWidth;
/**The badge will be hidden if the text's value is equal to 0.*/
@property (nonatomic, assign) BOOL hidesWhenZero;
/**
 * The offset for the text in badge.
 */
@property (nonatomic) UIOffset textPositionAdjustment;
/**The badge center*/
@property (nonatomic, assign) CGPoint badgeCenter;
@end
