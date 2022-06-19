//
//  Calayer + Positioning.h
//  Sight
//
//  Created by 范斌 on 16/4/28.
//  Copyright © 2016年 Yueranzhishang Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface CALayer (Positioning)

/** View's X Position */
@property (nonatomic, assign) CGFloat   x;

/** View's Y Position */
@property (nonatomic, assign) CGFloat   y;

/** View's width */
@property (nonatomic, assign) CGFloat   width;

/** View's height */
@property (nonatomic, assign) CGFloat   height;

/** View's origin - Sets X and Y Positions */
@property (nonatomic, assign) CGPoint   origin;

/** View's size - Sets Width and Height */
@property (nonatomic, assign) CGSize    size;

/** Y value representing the bottom of the view **/
@property (nonatomic, assign) CGFloat   bottom;

/** X Value representing the right side of the view **/
@property (nonatomic, assign) CGFloat   right;

/** X Value representing the top of the view (alias of x) **/
@property (nonatomic, assign) CGFloat   left;

/** Y Value representing the top of the view (alias of y) **/
@property (nonatomic, assign) CGFloat   top;

/** View's bounds X value **/
@property (nonatomic, assign) CGFloat   boundsX;

/** View's bounds Y value **/
@property (nonatomic, assign) CGFloat   boundsY;

/** View's bounds width **/
@property (nonatomic, assign) CGFloat   boundsWidth;

/** View's bounds height **/
@property (nonatomic, assign) CGFloat   boundsHeight;

- (void)setHardDropShadowWithOpacity:(float)opacity;

@end
