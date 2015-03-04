//
//  NSObject+Log.m
//  GPJsonModel
//
//  Created by mac on 15-2-18.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "NSObject+Log.h"
#import <objc/runtime.h>

@implementation NSObject (Log)

- (void)gp_emurateIvarsUsingBlock:(void(^)(Ivar ivar,NSString *ivarName,id value))block{
    unsigned count = 0;
    Class cls = [self class];
    while ( cls != [NSObject class]) {
        Ivar *ivars = class_copyIvarList(cls, &count);
        Ivar ivar;
        NSString *ivarName = nil;
        id ivarValue = nil;
        for (NSInteger i = 0; i < count; i++) {
            ivar = ivars[i];
            ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
            ivarValue = [self valueForKeyPath:ivarName];
            block(ivar,ivarName,ivarValue);
        }
        free(ivars);
        cls = class_getSuperclass(cls);
    }
}


- (NSString *)stringWithCString:(const char *)cstr fromIndex:(NSInteger)index   encoding:(NSStringEncoding)encoding{
    unsigned long len = strlen(cstr);
    NSAssert(index < len, @"index in out of cstr's length");
    char str[len - index];
    for (int i = 0; i < len - index; i++) {
        str[i] = cstr[i + index];
    }
    return [NSString stringWithCString:str encoding:encoding];
}

@end
