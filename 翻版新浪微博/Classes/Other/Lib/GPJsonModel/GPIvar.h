//
//  GPIvar.h
//  GPJsonModel
//
//  Created by mac on 15-2-18.
//  Copyright (c) 2015年 gpr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

typedef NS_ENUM(NSInteger, GPIvarPropertyType){
    GPIvarPropertyUnknowType,          // 用来描述该属性没有赋值
    GPIvarPropertyDirectKeyValueType,
    GPIvarPropertyCollectionType,
    GPIvarPropertyDictionaryType,
    GPIvarPropertyDIYObject             // 自定义对象类型
};

@interface GPIvar : NSObject

@property (nonatomic,copy) NSString *ivarName;
/** 如果 ivarName 没有对应的 propertyName 该属性为空 */
@property (nonatomic,copy) NSString *propertyName;
/** 属性值 */
@property (nonatomic,strong) id ivarValue;
/** 属性的类型 */
@property (nonatomic,copy) NSString *typeEncode;
/** 描述该属性的类型,对于非自定义对象的类型为空 */
@property (nonatomic,assign) Class propertyClass;

/** 用来标志该属性属于那种类型 */
@property (nonatomic,assign) GPIvarPropertyType ivarType;
/** 用来描述该模型来自于那个目标对象 */
@property (nonatomic,weak) id sourceObj;

- (instancetype)initWithIvar:(Ivar)ivar fromObject:(id)obj;
+ (instancetype)ivarWithIvar:(Ivar)ivar fromObject:(id)obj;

#pragma mark - 工具方法
/**
 *  获取绑定在该对象上的 属性信息字典
 *
 *  @param obj 对象
 *
 *  @return 属性信息字典
 */
+ (NSDictionary *)ivarsFromObject:(id)obj;

/**
 *  设置指定的 属性信息字典 到对应的对象身上
 *
 *  @param ivars 属性信息字典
 *  @param ob    对应的对象
 */
+ (void)attachIvars:(NSDictionary *)ivars toObject:(id)ob;

@end
