//
//  NSObject+KB.m
//  Homework
//
//  Created by SXJY on 2021/6/25.
//

#import "NSObject+KB.h"
#import <objc/runtime.h>
#import "KBTool.h"

@implementation NSObject (KB)

+ (NSString *)kbClassName {
    return NSStringFromClass([self class]);
}

- (BOOL)kbValidate {
    if (self.kbNull) {
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

- (BOOL)kbNull {
    return self == nil || [self isKindOfClass:[NSNull class]];
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

- (UIViewController *)viewController {
    UIViewController *resultVC;
    resultVC = [self _viewController:[[KBTool keyWindow] rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _viewController:resultVC.presentedViewController];
    }
    return resultVC;
}
- (UIViewController *)_viewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _viewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _viewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
}


/**
 *  类方法的交换
 *
 *  @param sel1 方法1
 *  @param sel2 方法2
 */
+ (void)kb_exchangeClassMethodWithSel1:(SEL)sel1 sel2:(SEL)sel2 {
    Class cls = [self class];
    Method method1 = class_getClassMethod(cls, sel1);
    Method method2 = class_getClassMethod(cls, sel2);
    method_exchangeImplementations(method1, method2);
}

/**
 *  对象方法的交换
 *
 *  @param sel1 方法1(原本的方法)
 *  @param sel2 方法2(要替换成的方法)
 */
+ (void)kb_exchangeInstanceMethodWithSel1:(SEL)sel1 sel2:(SEL)sel2 {
    Class cls = [self class];
    Method method1 = class_getInstanceMethod(cls, sel1);
    Method method2 = class_getInstanceMethod(cls, sel2);
    BOOL didAddMethod = class_addMethod(cls,
                                        sel1,
                                        method_getImplementation(method2),
                                        method_getTypeEncoding(method2));
    if (didAddMethod) {
        class_replaceMethod(cls,
                            sel2,
                            method_getImplementation(method1),
                            method_getTypeEncoding(method1));
    }
    else {
        method_exchangeImplementations(method1, method2);
    }
}

+ (BOOL)kb_isMethodOverride:(SEL)sel {
    IMP clsIMP = class_getMethodImplementation(self, sel);
    IMP superClsIMP = class_getMethodImplementation([self superclass], sel);
    return clsIMP != superClsIMP;
}

@end
