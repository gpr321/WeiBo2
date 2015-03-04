#ifdef DEBUG
#define GPLog(...) NSLog(__VA_ARGS__)
#else
#define GPLog(...)
#endif

// 如果不想输出提示信息就注释掉该宏
#define GP_DEBUG

// description 方法
#define GPDescription \
- (NSString *)description{ \
    NSMutableString *string = [NSMutableString string]; \
    [string appendFormat:@"<%@ %p> {\n",NSStringFromClass([self class]),self]; \
    [self gp_emurateIvarsUsingBlock:^(Ivar ivar, NSString *ivarName, id value) { \
        [string appendFormat:@"\t%@ = %@\n",ivarName,value]; \
    }]; \
    [string appendString:@"}"]; \
    return string; \
} \
