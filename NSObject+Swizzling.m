//
//  NSObject+Swizzling.m
//  SwizzlingDemo
//
//  Created by NPHD on 14-7-4.
//  Copyright (c) 2014年 NPHD. All rights reserved.
//

#import "NSObject+Swizzling.h"
#import <objc/runtime.h>
/**
 IMP orginIMP1;
 @implementation NSString (Swizzling)
 id MyUppercaseString(id SELF, SEL _cmd)
 {
 NSLog(@"begin uppercaseString");
 NSString *str = orginIMP1 (SELF, _cmd);
 NSLog(@"end uppercaseString");
 return str;
 }
 + (void)load
 {
 orginIMP1 =  [self replaceMethod:@selector(uppercaseString) :(IMP)MyUppercaseString];
 }
 @end
 */
@implementation NSObject (Swizzling)

BOOL class_swizzleMethodAndStore(Class class, SEL original, IMP replacement, IMPPointer store) {
    IMP imp = NULL;
    Method method = class_getInstanceMethod(class, original);
    if (method) {
        const char *type = method_getTypeEncoding(method);
        imp = class_replaceMethod(class, original, replacement, type);
        if (!imp) {
            imp = method_getImplementation(method);
        }
    }
    if (imp && store) { *store = imp; }
    return (imp != NULL);
}
void exchangeMethond(Method m1,Method m2) {
    method_exchangeImplementations(m1, m2);
    
}
+ (BOOL)swizzle:(SEL)original with:(IMP)replacement store:(IMPPointer)store {
    return class_swizzleMethodAndStore(self, original, replacement, store);
}
+ (void)exchangeMethond:(SEL)sel1 :(SEL)sel2
{
    Method m1 = class_getInstanceMethod([self class], sel1);
    Method m2 = class_getInstanceMethod([self class], sel2);
    exchangeMethond(m1,m2);
}
+(IMP)replaceMethod :(SEL)oldMethond :(IMP)newIMP
{
    IMP orginIMP = [[self class] instanceMethodForSelector:oldMethond];
    class_replaceMethod([self class],oldMethond,newIMP,NULL);
    return orginIMP;
}
@end
