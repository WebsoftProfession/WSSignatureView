//
//  WSSignature.m
//  WSSignatureView
//
//  Created by LK on 21/05/2017.
//  Copyright © 2017 WebsoftProfession. All rights reserved.
//

#import "WSSignature.h"

@implementation WSSignature
{
    UIBezierPath *pen;
    CGPoint activeStartPoint;
    CGPoint activeEndPoint;
    
    BOOL isContainsPoint;
    BOOL isEraseAllAction;
    BOOL isEditing;
    NSMutableArray *strokePathArray;
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [[UIImage imageNamed:@"face.jpg"] drawInRect:rect];
    self.layer.cornerRadius = 5.0;
    self.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.layer.borderWidth = 1.0;
    if (!pen && isEditing) {
        pen = [UIBezierPath bezierPath];
        strokePathArray = [[NSMutableArray alloc] init];
    }
    
    if (isEditing) {
        
        if (activeStartPoint.x==activeEndPoint.x && activeStartPoint.y==activeEndPoint.y) {
            [pen moveToPoint:activeStartPoint];
        }
        [pen addLineToPoint:activeEndPoint];
        [pen setLineWidth:1.0];
        [[UIColor greenColor] setStroke];
        [pen stroke];
    }
    if (!isEditing) {
        [strokePathArray addObject:pen];
        for (UIBezierPath *path in strokePathArray) {
            [[UIColor greenColor] setStroke];
            [path stroke];
        }
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[touches allObjects] lastObject];
    CGPoint touchPoint = [touch locationInView:self];
    activeStartPoint =touchPoint;
    activeEndPoint = touchPoint;
    isEditing =YES;
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    isEditing = YES;
    UITouch *touch = [[touches allObjects] lastObject];
    CGPoint touchPoint = [touch locationInView:self];
    activeEndPoint = touchPoint;
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [[touches allObjects] lastObject];
    CGPoint touchPoint = [touch locationInView:self];
    activeEndPoint = touchPoint;
    activeStartPoint = touchPoint;
    isEditing=NO;
    [self setNeedsDisplay];
    
    if (isContainsPoint) {
        
    }
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

-(void)touchesEstimatedPropertiesUpdated:(NSSet<UITouch *> *)touches{
    
}

- (UIImage *)captureSignature {
    
    CGRect rect = [self bounds];
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
    
}

-(void)clearSignaturePad{
    pen = [UIBezierPath bezierPath];
    strokePathArray = [[NSMutableArray alloc] init];
    [self setNeedsDisplay];
}

@end
