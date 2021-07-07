//
//  NSObject+KBCustom.h
//  Homework
//
//  Created by SXJY on 2021/6/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KBCustom)
//返回当前类的所有属性
+ (NSArray *)allPropertieNames;

@property (nonatomic, assign, readonly) BOOL isValidate;

/// 类名
@property (class, nonatomic, copy, readonly) NSString *className;

+ (BOOL)kb_swizzleMethod:(SEL)systemSEL withMethod:(SEL)customSEL;
+ (BOOL)kb_swizzleClassMethod:(SEL)systemSEL withMethod:(SEL)customSEL;


/// 判断某个类是否重写了某个方法
/// @param cls 要判断的类
/// @param sel 要判断的方法
- (BOOL)kb_isMethodOverride:(Class)cls selector:(SEL)sel;

@end

NS_ASSUME_NONNULL_END
