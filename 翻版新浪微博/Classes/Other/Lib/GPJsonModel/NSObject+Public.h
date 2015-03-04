//
//  NSObject+Public.h
//  runtimeTest
//
//  Created by mac on 15-2-19.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Public)

/**
 *  这里汇总了所有可以直接赋值到字典中的value的类型
 */
+ (NSArray *)directKeyValueClasses;

/**
 *  这里汇总了字典的各种类型
 */
+ (NSArray *)dictionaryClasses;

/**
 *  这里汇总了各种集合类型
 */
+ (NSArray *)collectionClasses;

@end
