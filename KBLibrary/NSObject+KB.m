//
//  NSObject+KB.m
//  Homework
//
//  Created by SXJY on 2021/6/25.
//

#import "NSObject+KB.h"
#import <objc/runtime.h>

@implementation NSObject (KB)

+ (NSString *)kbClassName {
    return NSStringFromClass([self class]);
}

- (BOOL)kbValidate {
    if (self == nil || [self isKindOfClass:[NSNull class]]) {
        return NO;
    } else {
        if ([self isKindOfClass:[NSString class]]) {
            NSString *str = (NSString *)self;
            return str.length > 0 && ![str.lowercaseString isEqualToString:@"null"];
        } else if ([self isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dictionary = (NSDictionary *)self;
            return dictionary.count > 0;
        } else if ([self isKindOfClass:[NSArray class]]) {
            NSArray *array = (NSArray *)self;
            return array.count > 0;
        } else {
            return YES;
        }
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

+ (BOOL)kb_isMethodOverride:(SEL)sel {
    IMP clsIMP = class_getMethodImplementation(self, sel);
    IMP superClsIMP = class_getMethodImplementation([self superclass], sel);
    return clsIMP != superClsIMP;
}

//返回当前类的属性名字
+ (NSArray *)kb_propertieNames {
    
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
    
    return propertyNames.copy;
}

@end
