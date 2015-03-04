//
//  GPIvar.m
//  GPJsonModel
//
//  Created by mac on 15-2-18.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "GPIvar.h"
#import "NSObject+Log.h"
#import "GPDebug.h"

@implementation GPIvar

static NSArray *_foundationClasses;
static NSArray *_directKeyValueTypes;
static NSArray *_dictionaryTypes;
static NSArray *_collectionTypes;
+ (void)initialize
{
    _foundationClasses = @[@"NSObject", @"NSNumber",@"NSArray", @"NSURL", @"NSMutableURL",@"NSMutableArray",@"NSData",@"NSMutableData",@"NSDate",@"NSDictionary",@"NSMutableDictionary",@"NSString",@"NSMutableString",@"NSException"];
    // 可以直接作为字典的类型
    // 删除 了 @"NSURL",@"NSMutableURL",@"NSData",@"NSMutableData"
    _directKeyValueTypes = @[@"NSObject",@"NSException",@"NSNumber",@"NSDate",@"NSString",@"NSMutableString",@"c",@"i",@"s",@"l",@"q",@"c",@"I",@"S",@"L",@"Q",@"f",@"d",@"B",@"*"];
    // 集合类型,需要遍历
    _dictionaryTypes = @[@"NSDictionary",@"NSMutableDictionary"];
    _collectionTypes = @[@"NSArray",@"NSMutableArray",@"NSSet",@"NSMutableSet"]; 
}

#pragma mark - 这两个用于模型转字典
- (instancetype)initWithIvar:(Ivar)ivar fromObject:(id)obj{
#ifdef GP_DEBUG
    NSString *clsName = NSStringFromClass([obj class]);
    NSString *info = [NSString stringWithFormat:@"该类 \"%@\" 不属于自定义类只能不能使用此方法进行初始化",clsName];
    NSAssert(![_foundationClasses containsObject:NSStringFromClass([obj class])],info);
#endif
    if ( self = [super init] ) {
        self.sourceObj = obj;
        self.ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSString *propertyName = [self.ivarName substringFromIndex:1];
        NSString *typeString = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        self.typeEncode = [self subStringFrom:typeString byRegular:@"[^\"@]"];
        if ( [typeString rangeOfString:@"@"].length > 0 ) {
            self.propertyClass = NSClassFromString(self.typeEncode);
        }
        // 属性值
        self.ivarValue = [obj valueForKeyPath:self.ivarName];
        // 判断其类型
        if ( [_directKeyValueTypes containsObject:self.typeEncode] ) {
            self.ivarType = GPIvarPropertyDirectKeyValueType;
        } else if ( [_dictionaryTypes containsObject:self.typeEncode] ){
            self.ivarType = GPIvarPropertyDictionaryType;
        } else if ( [_collectionTypes containsObject:self.typeEncode] ){
            self.ivarType = GPIvarPropertyCollectionType;
        } else {
            self.ivarType = GPIvarPropertyDIYObject;
        }
        // 判断该属性是否 为 property
        if ( class_getProperty([obj class], [propertyName cStringUsingEncoding:NSUTF8StringEncoding]) ) {
            self.propertyName = propertyName;
        }
    }
    return self;
}

+ (instancetype)ivarWithIvar:(Ivar)ivar fromObject:(id)obj{
    return [[self alloc] initWithIvar:ivar fromObject:obj];
}

#pragma mark - 工具方法
+ (NSDictionary *)ivarsFromObject:(id)obj{
    NSDictionary *ivars = objc_getAssociatedObject(obj, @selector(ivarsFromObject:));
    if ( ivars == nil ) {
        NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
        __block GPIvar *ivarModel = nil;
        [obj gp_emurateIvarsUsingBlock:^(Ivar ivar, NSString *ivarName, id value) {
            ivarModel = [GPIvar ivarWithIvar:ivar fromObject:obj];
            if ( ivarModel.propertyName ) {
                dictM[ivarModel.propertyName] = ivarModel;
            }
        }];
        ivars = dictM;
        objc_setAssociatedObject(obj, @selector(ivarsFromObject:), ivars, OBJC_ASSOCIATION_RETAIN);
    }
    return ivars;
}

+ (void)attachIvars:(NSDictionary *)ivars toObject:(id)obj{
    objc_setAssociatedObject(obj, @selector(attachIvars:toObject:), ivars, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark - 私有方法
- (NSString *)subStringFrom:(NSString *)origin byRegular:(NSString *)regular{
    NSRange r = [origin rangeOfString:regular options:NSRegularExpressionSearch];
    if ( r.location == NSNotFound || r.length == 0 ) return nil;
    NSMutableString *subStrings = [NSMutableString string];
    NSString *item = nil;
    while (r.location != NSNotFound || r.length != 0 ) {
        item = [origin substringWithRange:r];
        [subStrings appendString:item];
        r = [origin rangeOfString:regular options:NSRegularExpressionSearch range:NSMakeRange(r.location + item.length, origin.length - r.location - item.length)];
    }
    return [subStrings copy];
}

@end
