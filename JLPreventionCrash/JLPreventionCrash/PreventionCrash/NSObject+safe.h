//
//  NSObject+safe.h
//  JLSafeFoundation
//
//  Created by Aimy on 3/16/15.
//  Copyright (c) 2015 Aimy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//weak strong self for retain cycle
#define WEAK_SELF __weak typeof(self)weakSelf = self
#define STRONG_SELF __strong typeof(weakSelf)self = weakSelf

/*
 这几个都是自己公司App已经添加了的，亲测可行
 其实可以依葫芦画瓢swizzle修改其他类的方法，减少因为nil或者越界产生的crash，但是不确定是否会影响系统运行
 所以使用swizzle修改还是要谨慎（因为掉过大坑😭😭😭）
*/
@interface NSArray (safe)

@end

@interface NSMutableArray (safe)

@end

@interface NSMutableDictionary (safe)

@end

@interface UIView (safe)

@end