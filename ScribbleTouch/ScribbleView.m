//
//  ScribbleView.m
//  ScribbleTouch
//
//  Created by Richard Tyran on 1/14/15.
//  Copyright (c) 2015 Richard Tyran. All rights reserved.
//

#import "ScribbleView.h"

@implementation ScribbleView


//    @[
//
//    @[
//        @"type":@"path"
//        @"fillColor":[UIColor greenColor],
//        @"strokeColor":[UIColor blackColor],
//        @"strokeWideth":@2,
//        @"points":@[CGPoint,CGPoint,CGPoint];
//
//    },
//
//    @{
//        @"type":@"circle"
//        @"fillColor":[UIColor greenColor],
//        @"strokeColor":[UIColor blackColor],
//        @"strokeWideth":@2,
//        @"frame":CGRect;
//    }


- (NSMutableArray *)scribbles {
    
    if (_scribbles == nil) {_scribbles = [@[] mutableCopy]; }
    return _scribbles;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    
    for (NSDictionary * scribble in self.scribbles) {
        
        CGContextSetLineWidth(context,[scribble[@"strokeWidth"] floatValue]);
        
        UIColor * strokeColor = scribble[@"strokeColor"];
        
        
        CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
        
        UIColor *fillColor = scribble[@"fillColor"];
        
        
        CGContextSetFillColorWithColor(context, fillColor.CGColor);
        
        CGPoint firstPoint = [scribble[@"points"][0] CGPointValue];
        CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
        
        for (NSValue * pointValue in scribble [@"points"]) {
            
            CGPoint point = [pointValue CGPointValue];
            CGContextAddLineToPoint(context, point.x, point.y);
            
        }
        
        CGContextFillPath(context);
        
        CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
        
        for (NSValue * pointValue in scribble [@"points"]) {
            
            CGPoint point = [pointValue CGPointValue];
            CGContextAddLineToPoint(context, point.x, point.y);
            
        }
        
        
        CGContextStrokePath(context);
        CGContextSetAlpha(context, 0.5);
        
        
        
    }
}

@end



