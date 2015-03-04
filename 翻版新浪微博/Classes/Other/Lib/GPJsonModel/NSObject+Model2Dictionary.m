//
//  NSObject+Model2Dictionary.m
//  GPJsonModel
//
//  Created by mac on 15-2-18.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "NSObject+Model2Dictionary.h"
#import "NSObject+Log.h"
#import "GPIvar.h"
#import "NSObject+Public.h"

@implementation NSObject (Model2Dictionary)

- (NSDictionary *)gp_dictionaryFromModel{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    __block GPIvar *ivarModel = nil;
    [self gp_emurateIvarsUsingBlock:^(Ivar ivar, NSString *ivarName, id value) {
        ivarModel = [GPIvar ivarWithIvar:ivar fromObject:self];
        if ( ivarModel.ivarValue == nil ) return ;
        switch (ivarModel.ivarType) {
            case GPIvarPropertyDirectKeyValueType:
                dictM[ivarModel.propertyName] = ivarModel.ivarValue;
                break;
            case GPIvarPropertyCollectionType:{
                dictM[ivarModel.propertyName] = [NSObject gp_arrayValueStringFromCollection:ivarModel.ivarValue];
                }
                break;
            case GPIvarPropertyDictionaryType:
                dictM[ivarModel.propertyName] = [NSObject gp_dictionaryValuesStringFromDictionary:ivarModel.ivarValue];
                break;
            case GPIvarPropertyDIYObject:
                 dictM[ivarModel.propertyName] = [ivarModel.ivarValue gp_dictionaryFromModel];
                break;
                
            default:
                break;
        }
    }];
    return dictM;
}

#pragma mark - 私有方法
+ (NSArray *)gp_arrayValueStringFromCollection:(id)collection{
    NSAssert([collection isKindOfClass:[NSArray class]] || [collection isKindOfClass:[NSSet class]], @"该类型不能使用 for in 遍历");
    NSMutableArray *array = [NSMutableArray array];
    for (id item in collection) { // 可以直接赋值的对象类型
        NSString *className = NSStringFromClass([item class]);
        if ( [[self directKeyValueClasses] containsObject:className] ) {
            [array addObject:item];
        } else if ( [[self collectionClasses] containsObject:className] ){
            // 数组 或者 set 类型
            [array addObject:[self gp_arrayValueStringFromCollection:item]];
        } else if ( [[self dictionaryClasses] containsObject:className] ){
            // 字典类型
            [array addObject:[self gp_dictionaryValuesStringFromDictionary:item]];
        } else { // 自定义对象的情况
            [array addObject:[item gp_dictionaryFromModel]];
        }
    }
    return array;
}

+ (NSDictionary *)gp_dictionaryValuesStringFromDictionary:(NSDictionary *)dict{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id item, BOOL *stop) {
        NSString *className = NSStringFromClass([item class]);
        if ( [[self directKeyValueClasses] containsObject:className] ) {
            // 可以直接赋值的对象类型
            dictM[key] = item;
        } else if ( [[self collectionClasses] containsObject:className] ){
            // 数组 或者 set 类型
            dictM[key] = [self gp_arrayValueStringFromCollection:item];
        } else if ( [[self dictionaryClasses] containsObject:className] ){
            // 字典类型
            dictM[key] = [self gp_dictionaryValuesStringFromDictionary:item];
        } else { // 自定义对象的情况
            dictM[key] = [item gp_dictionaryFromModel];
        }
    }];
    return dictM;
}


@end
