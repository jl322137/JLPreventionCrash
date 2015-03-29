//
//  NSObject+safe.m
//  JLSafeFoundation
//
//  Created by Aimy on 3/16/15.
//  Copyright (c) 2015 Aimy. All rights reserved.
//

#import "NSObject+safe.h"

#import "NSObject+swizzle.h"

@implementation NSArray (safe)

+ (void)load
{
    [self overrideMethod:@selector(objectAtIndexedSubscript:) withMethod:@selector(safeObjectAtIndexedSubscript:)];
}

- (id)safeObjectAtIndexedSubscript:(NSUInteger)index
{
    if (index >= self.count) {
        return nil;
    } else {
        return [self objectAtIndex:index];
    }
}

@end

@implementation NSMutableArray (safe)

+ (void)load
{
    [self overrideMethod:@selector(setObject:atIndexedSubscript:) withMethod:@selector(safeSetObject:atIndexedSubscript:)];
}

- (void)safeSetObject:(id)obj atIndexedSubscript:(NSUInteger)idx
{
    if (obj == nil) {
        return ;
    }
    
    if (self.count < idx) {
        return ;
    }
    
    if (idx == self.count) {
        [self addObject:obj];
    }
    else {
        [self replaceObjectAtIndex:idx withObject:obj];
    }
}

@end

@implementation NSMutableDictionary(safe)

+ (void)load
{
    [self overrideMethod:@selector(setObject:forKeyedSubscript:) withMethod:@selector(safeSetObject:forKeyedSubscript:)];
}

- (void)safeSetObject:(id)obj forKeyedSubscript:(id<NSCopying>)key
{
    if (!key) {
        return ;
    }
    
    if (!obj) {
        [self removeObjectForKey:key];
    }
    else {
        [self setObject:obj forKey:key];
    }
}

@end

@implementation UIView (safe)

+ (void)load
{
    [self exchangeMethod:@selector(setFrame:) withMethod:@selector(safeSetFrame:)];
}

- (void)safeSetFrame:(CGRect)frame
{
    if (isnan(frame.origin.x)) {
        NSLog(@"%@,isnan of x",self);
        [self safeSetFrame:CGRectZero];
        return;
    }
    
    if (isnan(frame.origin.y)) {
        NSLog(@"%@,isnan of y",self);
        [self safeSetFrame:CGRectZero];
        return;
    }
    
    if (isnan(frame.size.width)) {
        NSLog(@"%@,isnan of w",self);
        [self safeSetFrame:CGRectZero];
        return;
    }
    
    if (isnan(frame.size.height)) {
        NSLog(@"%@,isnan of h",self);
        [self safeSetFrame:CGRectZero];
        return;
    }
    
//    if (isinf(frame.origin.x)) {
//        NSLog(@"%@,isinf of x",self);
//        [self safeSetFrame:CGRectZero];
//        return;
//    }
//    
//    if (isinf(frame.origin.y)) {
//        NSLog(@"%@,isinf of y",self);
//        [self safeSetFrame:CGRectZero];
//        return;
//    }
//    
//    if (isinf(frame.size.width)) {
//        NSLog(@"%@,isinf of w",self);
//        [self safeSetFrame:CGRectZero];
//        return;
//    }
//    
//    if (isinf(frame.size.height)) {
//        NSLog(@"%@,isinf of h",self);
//        [self safeSetFrame:CGRectZero];
//        return;
//    }
    
    [self safeSetFrame:frame];
}

@end
