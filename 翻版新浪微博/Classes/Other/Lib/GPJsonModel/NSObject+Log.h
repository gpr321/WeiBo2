//
//  NSObject+Log.h
//  GPJsonModel
//
//  Created by mac on 15-2-18.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "GPDebug.h"

@interface NSObject (Log)

- (void)gp_emurateIvarsUsingBlock:(void(^)(Ivar ivar,NSString *ivarName,id value))block;

@end
