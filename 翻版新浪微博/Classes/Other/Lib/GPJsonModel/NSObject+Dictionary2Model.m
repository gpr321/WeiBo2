//
//  NSObject+Dictionary2Model.m
//  GPJsonModel
//
//  Created by mac on 15-2-18.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import "NSObject+Dictionary2Model.h"
#import "NSObject+Log.h"
#import "GPIvar.h"
#import "NSObject+Public.h"
#import "GPDebug.h"
#import <objc/runtime.h>
#import "WBStatus.h"

@implementation NSObject (Dictionary2Model)

+ (NSArray *)gp_objectWithString:(NSString *)jsonString{
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *models = [self gp_objectWithData:data];
#ifdef GP_DEBUG
    NSAssert(models != nil, @"jsonString 的数据格式不是数组格式");
#endif
    return models;
}

+ (NSArray *)gp_objectWithContentOfFile:(NSString *)file{
    NSData *data = [NSData dataWithContentsOfFile:file];
#ifdef GP_DEBUG
    NSAssert(data != nil, @"file 文件路径有无,找不到plist文件");
#endif
    NSArray *models = [self gp_objectWithData:data];
#ifdef GP_DEBUG
    NSAssert(models != nil, @"file 对应的文件的数据格式不是数组格式");
#endif
    return models;
}

+ (NSArray *)gp_objectWithData:(NSData *)data{
#ifdef GP_DEBUG
    NSAssert(data != nil, @"data 不能为空");
#endif
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:NULL];
#ifdef GP_DEBUG
    NSAssert([array isKindOfClass:[NSArray class]], @"data 数据格式不是数组格式");
#endif
    return [self gp_objectArrayWithDictionaryArray:array];
}

+ (NSArray *)gp_objectArrayWithDictionaryArray:(NSArray *)dictArray{
    NSMutableArray *modelArray = [NSMutableArray arrayWithCapacity:dictArray.count];
    for (NSDictionary *item in dictArray) {
        [modelArray addObject:[self gp_objectWithDictionary:item]];
    }
    return modelArray;
}

+ (instancetype)gp_objectWithDictionary:(NSDictionary *)dict{
    id instance = [[self alloc] init];
    // 获取该类中属性信息
    NSDictionary *ivarsDict = [GPIvar ivarsFromObject:instance];
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        // 确定key 对应的属性名字
        NSString *propertyName = key;
        NSDictionary *dict = [self gp_dictionaryKeysMatchToPropertyNames];
        if ( dict[key] ) {
            propertyName = dict[key];
        }
        GPIvar *ivarModel = ivarsDict[propertyName];
        if ( ivarModel == nil ) return ;
        id propertyValue = nil;
        switch ( ivarModel.ivarType ) {
            case GPIvarPropertyDIYObject: { // 自定义对象
                propertyValue = [ivarModel.propertyClass gp_objectWithDictionary:value];
            }
                break;
            case GPIvarPropertyDictionaryType: { // 字典属性
                NSDictionary *clsInfoDict = [self gp_objectClassesInNSDictionaryProperties][propertyName];
                // 检查调用者是否指定了对应要处理的信息,如果没有就直接赋值
                if ( clsInfoDict == nil ) {
                    propertyValue = value;
                    break;
                }
                propertyValue = [self gp_dealWithSourceDict:value fromClassInfoDict:clsInfoDict];
            }
                break;
            case GPIvarPropertyCollectionType: { // 数组属性
                // 2. value 是一个数组类型
                NSDictionary *dict = [self gp_objectClassesInArryProperties];
                // 获取元素的类型
                Class cls = dict[propertyName];
                // 如果没有指定的话就直接赋值
                if ( cls == nil ) {
                    propertyValue = value;
                } else {
                    // 有指定的话就说明元素将要转化为一个对象,那么该元素肯定是一个字典类型
                    // 遍历该数组
                    NSMutableArray *propertyArray = [NSMutableArray arrayWithCapacity:[value count]];
                    for (NSDictionary *item in value) {
                        [propertyArray addObject:[cls gp_objectWithDictionary:item]];
                    }
                    propertyValue = propertyArray;
                }
            }
                break;
            case GPIvarPropertyDirectKeyValueType: // 可以直接使用KVC赋值的属性
                // NSNumber 和 NSString 转化
                if ( [ivarModel.typeEncode isEqualToString:@"NSString"] && [NSStringFromClass([value class]) isEqualToString:@"__NSCFNumber"] ) {
                    value = [value stringValue];
                } else if ( [ivarModel.typeEncode isEqualToString:@"NSNumber"] && ([NSStringFromClass([value class]) isEqualToString:@"__NSCFString"] || [NSStringFromClass([value class]) isEqualToString:@"__NSCFConstantString"]) ){
                    value = [value description];
                }
                propertyValue = value;
                break;
            default:
                break;
        }
        if ( propertyValue ) {
            if ( [propertyName isEqualToString:@"pic_urls"] ) {
                propertyValue = [propertyValue copy];
            }
            [instance setValue:propertyValue forKeyPath:propertyName];
        }
        [GPIvar attachIvars:nil toObject:instance];
    }];
    return instance;
}

#pragma mark - 私有方法
/**
 *  当对象属性中可能包含了一个字典属性,该字典属性可能有些键值对应着不同的对象,这个方法就是把源字典中的对应键值所对应的字典转化为对应的对象
 */
+ (NSDictionary *)gp_dealWithSourceDict:(NSDictionary *)srcDict fromClassInfoDict:(NSDictionary *)clsInfoDict{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:srcDict];
    [clsInfoDict enumerateKeysAndObjectsUsingBlock:^(NSString *itemKey, id itemValue, BOOL *stop) {
        if ( [itemValue isKindOfClass:[NSDictionary class]] ) { // 字典类型
            NSDictionary *itemClsInfoDict = clsInfoDict[itemKey];
            NSDictionary *itemSrcDict = srcDict[itemKey];
            result[itemKey] = [self gp_dealWithSourceDict:itemSrcDict fromClassInfoDict:itemClsInfoDict];
        } else { // class 类型直接创建对象更换 result 对应的 key 的值
            Class cls = itemValue;
            NSDictionary *clsDict = result[itemKey];
            result[itemKey] = [cls gp_objectWithDictionary:clsDict];
        }
    }];
    return result;
}

+ (NSDictionary *)gp_dictionaryKeysMatchToPropertyNames{
    return nil;
}

+ (NSDictionary *)gp_objectClassesInArryProperties{
    return nil;
}

+ (NSDictionary *)gp_objectClassesInNSDictionaryProperties{
    return nil;
}

@end
