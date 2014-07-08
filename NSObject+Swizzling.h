//
//  NSObject+Swizzling.h
//  SwizzlingDemo
//
//  Created by NPHD on 14-7-4.
//  Copyright (c) 2014年 NPHD. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef IMP *IMPPointer;
@interface NSObject (Swizzling)
+ (BOOL)swizzle:(SEL)original with:(IMP)replacement store:(IMPPointer)store;
+ (void)exchangeMethond :(SEL)m1 :(SEL)m2;
+ (IMP)replaceMethod :(SEL)oldMethond :(IMP)newIMP;
@end
