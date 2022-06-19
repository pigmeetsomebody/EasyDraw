//
//  UIView+Positioning.m
//
//  Created by Shai Mishali on 5/22/13.
//  Copyright (c) 2013 Shai Mishali. All rights reserved.
//

#import "Calayer + Positioning.h"

#define SCREEN_SCALE                    ([[UIScreen mainScreen] scale])
#define PIXEL_INTEGRAL(pointValue)      (round(pointValue * SCREEN_SCALE) / SCREEN_SCALE)

@implementation CALayer (Positioning)
@dynamic x, y, width, height, origin, size;
@dynamic boundsWidth, boundsHeight, boundsX, boundsY;

// Setters
-(void)setX:(CGFloat)x{
    self.frame      = CGRectMake(PIXEL_INTEGRAL(x), self.y, self.width, self.height);
}

-(void)setY:(CGFloat)y{
    self.frame      = CGRectMake(self.x, PIXEL_INTEGRAL(y), self.width, self.height);
}

-(void)setWidth:(CGFloat)width{
    self.frame      = CGRectMake(self.x, self.y, PIXEL_INTEGRAL(width), self.height);
}

-(void)setHeight:(CGFloat)height{
    self.frame      = CGRectMake(self.x, self.y, self.width, PIXEL_INTEGRAL(height));
}

-(void)setOrigin:(CGPoint)origin{
    self.x          = origin.x;
    self.y          = origin.y;
}

-(void)setSize:(CGSize)size{
    self.width      = size.width;
    self.height     = size.height;
}

-(void)setRight:(CGFloat)right {
    self.x          = right - self.width;
}

-(void)setBottom:(CGFloat)bottom {
    self.y          = bottom - self.height;
}

-(void)setLeft:(CGFloat)left{
    self.x          = left;
}

-(void)setTop:(CGFloat)top{
    self.y          = top;
}

-(void)setBoundsX:(CGFloat)boundsX{
    self.bounds     = CGRectMake(PIXEL_INTEGRAL(boundsX), self.boundsY, self.boundsWidth, self.boundsHeight);
}

-(void)setBoundsY:(CGFloat)boundsY{
    self.bounds     = CGRectMake(self.boundsX, PIXEL_INTEGRAL(boundsY), self.boundsWidth, self.boundsHeight);
}

-(void)setBoundsWidth:(CGFloat)boundsWidth{
    self.bounds     = CGRectMake(self.boundsX, self.boundsY, PIXEL_INTEGRAL(boundsWidth), self.boundsHeight);
}

-(void)setBoundsHeight:(CGFloat)boundsHeight{
    self.bounds     = CGRectMake(self.boundsX, self.boundsY, self.boundsWidth, PIXEL_INTEGRAL(boundsHeight));
}

// Getters
-(CGFloat)x{
    return self.frame.origin.x;
}

-(CGFloat)y{
    return self.frame.origin.y;
}

-(CGFloat)width{
    return self.frame.size.width;
}

-(CGFloat)height{
    return self.frame.size.height;
}

-(CGPoint)origin{
    return CGPointMake(self.x, self.y);
}

-(CGSize)size{
    return CGSizeMake(self.width, self.height);
}

-(CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

-(CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

-(CGFloat)left{
    return self.x;
}

-(CGFloat)top{
    return self.y;
}

-(CGFloat)boundsX{
    return self.bounds.origin.x;
}

-(CGFloat)boundsY{
    return self.bounds.origin.y;
}

-(CGFloat)boundsWidth{
    return self.bounds.size.width;
}

-(CGFloat)boundsHeight{
    return self.bounds.size.height;
}

- (void)setHardDropShadowWithOpacity:(float)opacity {
    self.shadowOffset = CGSizeMake(0, 1);
    self.shadowRadius = 0;
    self.shadowColor = [UIColor blackColor].CGColor;
    self.shadowOpacity = opacity;
}

- (BOOL)isDoubleSided {
    return NO;
}

@end
