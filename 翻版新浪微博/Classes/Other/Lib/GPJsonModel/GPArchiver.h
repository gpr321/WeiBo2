#import "NSObject+Log.h"

#define GPObjectCoding \
- (void)encodeWithCoder:(NSCoder *)encoder{ \
    [self gp_emurateIvarsUsingBlock:^(Ivar ivar, NSString *ivarName, id value) { \
        [encoder encodeObject:value forKey:ivarName]; \
    }]; \
} \
- (id)initWithCoder:(NSCoder *)decoder{ \
    if (self = [super init]) { \
        [self gp_emurateIvarsUsingBlock:^(Ivar ivar, NSString *ivarName, id value) { \
            [self setValue:[decoder decodeObjectForKey:ivarName] forKeyPath:ivarName]; \
        }]; \
    } \
    return self; \
}