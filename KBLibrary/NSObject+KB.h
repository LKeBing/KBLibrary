//
//  NSObject+KB.h
//  Homework
//
//  Created by SXJY on 2021/6/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KB)

/// 类名
@property (class, nonatomic, copy, readonly) NSString *kbClassName;

/// 验证该对象是否有效，主要是查看是否为nil，或者内容是否为空
@property (nonatomic, assign, readonly) BOOL kbValidate;

/// 魔法交换两个实例方法的方法体
/// @param systemSEL 系统的实例方法
/// @param customSEL 自定义实例方法
+ (BOOL)kb_swizzleMethod:(SEL)systemSEL withMethod:(SEL)customSEL;

/// 判断某个类是否重写了某个方法
/// @param sel 要判断的方法
+ (BOOL)kb_isMethodOverride:(SEL)sel;

/// 返回当前类的属性名字
+ (NSArray *)kb_propertieNames;

@end

NS_ASSUME_NONNULL_END
