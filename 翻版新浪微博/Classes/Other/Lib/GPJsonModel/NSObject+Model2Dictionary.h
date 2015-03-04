//
//  NSObject+Model2Dictionary.h
//  GPJsonModel
//
//  Created by mac on 15-2-18.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Model2Dictionary)

/**
 *  把该对象转化为一个字典
 *
 *  @return 对象字典
 */
- (NSDictionary *)gp_dictionaryFromModel;

@end
