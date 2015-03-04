//
//  NSObject+Dictionary2Model.h
//  GPJsonModel
//
//  Created by mac on 15-2-18.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Dictionary2Model)

/**
 *  通过一个字典来构建一个模型
 *
 *  @param dict 字典
 *
 *  @return 模型实例
 */
+ (instancetype)gp_objectWithDictionary:(NSDictionary *)dict;

/**
 *  加载对应路径的 .plist 文件为对应的对象数组
 *
 *  @param file 文件路径
 *
 *  @return 对象模型数组
 */
+ (NSArray *)gp_objectWithContentOfFile:(NSString *)file;

/**
 *  把一个 json 字符串二进制数据转化为一个对象数组模型
 *
 *  @param data json 字符串二进制数据
 *
 *  @return 对象模型数组
 */
+ (NSArray *)gp_objectWithData:(NSData *)data;

/**
 *  把一个 json 字符串转化为一个对象数组模型
 *
 *  @param jsonString jsonString 字符串
 *
 *  @return 对象模型数组
 */
+ (NSArray *)gp_objectWithString:(NSString *)jsonString;

/**
 *  把字典模型数组转化为模型数组
 *
 *  @param dictArray 字典模型数组
 *
 *  @return 模型数组
 */
+ (NSArray *)gp_objectArrayWithDictionaryArray:(NSArray *)dictArray;

/**
 *  对于类中有数组属性,实现该方法可以表明对应的数组里面的元素对应着什么类型
 *  key 作为属性的名字 值对应元素对应的类型
 *  @return 返回值示例 @{@"petsArray" : [Dog class]}
 */
+ (NSDictionary *)gp_objectClassesInArryProperties;

/**
 *  对于类中有字典属性,实现该方法可以描述字典中某些key的元素对应着什么类型对象
 *
 *  @{
 *      @"dogId" : @"1234",
 *      @"petsDictionary" : @{
 *                              @"name" : @"tom",
 *                              @"age"  : @2
 *                            },
 *      @"petsDictionary2" : @{
 *                              @"owner" : @"jack",
 *                              @"dog1"  : @{
 *                                              @"name" : @"tom",
 *                                              @"age"  : @2
 *                                          },
 *                              @"pets"  : @{
 *                                              @"owner" : @"Rose",
 *                                              @"pets_dog1" : @{
 *                                                              @"name" : @"tom",
 *                                                              @"age"  : @2
 *                                                              }
 *                                          }
 *
 *                            },
 *      @"petsArray" : @[
 *                          @{"name" : @"rose" ,@"age" : @3},
 *                          @{"name" : @"tome" ,@"age" : @4}
 *                      ],
 *      @"owner" : @"jack"
 *      }
 *  @return 返回值示例 @{@"petsDict" : @{
 *                                      @"dog" : [Dog class],
 *                                      @"cat" : [Cat class],
 *                                      @"pets" : @{
 *                                                     @"pets_dog" : [Dog class],
 *                                                     @"pets_cat" : [Cat class]
 *                                                  }
 *                                      };
 */
+ (NSDictionary *)gp_objectClassesInNSDictionaryProperties;

/**
 *  有时候字典中某些 key 跟指定 property 名字不一致,这时候需要实现这个方法来指定对应的属性
 *
 *  @return 返回值示例 @{
 *                          @"objDictionaryKey" : @"objPropertyName",
 *                          @"objDictionaryKey.dicSubKey" : @"objSubPropertyName"
 *                      }
 */
+ (NSDictionary *)gp_dictionaryKeysMatchToPropertyNames;

@end
