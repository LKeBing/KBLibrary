//
//  NSObject+KBCustom.m
//  Homework
//
//  Created by SXJY on 2021/6/25.
//

#import "NSObject+KBCustom.h"
#import <objc/runtime.h>

@implementation NSObject (KBCustom)
//返回当前类的所有属性
+ (NSArray *)allPropertieNames {
    
    Class cls = [self class];
    
    NSMutableArray *propertyNames = [NSMutableArray array];
    
    if (cls && ![NSStringFromClass(cls) isEqualToString:@"NSObject"]) {
        // 获取当前类的所有属性
        unsigned int count;// 记录属性个数
        objc_property_t *properties = class_copyPropertyList(cls, &count);// 得到所有属性的一个指针数组
        
        // 遍历
        for (int i = 0; i < count; i++) {
            
            // An opaque type that represents an Objective-C declared property.
            // objc_property_t 属性类型
            objc_property_t property = properties[i];
            // 获取属性的名称 C语言字符串
            const char *cName = property_getName(property);
            // 转换为Objective C 字符串
            NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
            [propertyNames addObject:name];
        }
    }
    
    return propertyNames;
}

+ (NSString *)className {
    return NSStringFromClass([self class]);
}

- (BOOL)isValidate {
    if (self == nil || [self isKindOfClass:[NSNull class]]) {
        return NO;
    } else {
        if ([self isKindOfClass:[NSString class]]) {
            NSString *str = (NSString *)self;
            if ([str.lowercaseString isEqualToString:@"null"] || str.length <= 0) {
                return NO;
            }
        } else if ([self isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dictionary = (NSDictionary *)[self copy];
            if (dictionary.count == 0) {
                return NO;
            }
        } else if ([self isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)[self copy];
            if (array.count == 0) {
                return NO;
            }
        }
        return YES;
    }
}


+ (BOOL)kb_swizzleMethod:(SEL)systemSEL withMethod:(SEL)customSEL {
    Method origMethod = class_getInstanceMethod(self, systemSEL);
    Method altMethod = class_getInstanceMethod(self, customSEL);
    if (!origMethod || !altMethod) {
        return NO;
    }
    class_addMethod(self,
                    systemSEL,
                    class_getMethodImplementation(self, systemSEL),
                    method_getTypeEncoding(origMethod));
    class_addMethod(self,
                    customSEL,
                    class_getMethodImplementation(self, customSEL),
                    method_getTypeEncoding(altMethod));
    method_exchangeImplementations(class_getInstanceMethod(self, systemSEL),
                                   class_getInstanceMethod(self, customSEL));
    return YES;
}

+ (BOOL)kb_swizzleClassMethod:(SEL)systemSEL withMethod:(SEL)customSEL {
    return [object_getClass((id)self) kb_swizzleMethod:systemSEL withMethod:customSEL];
}
- (BOOL)kb_isMethodOverride:(Class)cls selector:(SEL)sel {
    IMP clsIMP = class_getMethodImplementation(cls, sel);
    IMP superClsIMP = class_getMethodImplementation([cls superclass], sel);
    
    return clsIMP != superClsIMP;
}


@end
