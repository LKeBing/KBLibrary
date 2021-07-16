//
//  KBBlock.h
//  KBLibrary
//
//  Created by SXJY on 2021/6/25.
//

#import <Foundation/Foundation.h>

#ifndef KBBlock_h
#define KBBlock_h

/**void(^)(void)*/
typedef void(^KBEmptyBlock)(void);
/**void(^)(BOOL)*/
typedef void(^KBBoolBlock)(BOOL bol);
/**void(^)(NSInteger)*/
typedef void(^KBIntegerBlock)(NSInteger itg);
/**void(^)(NSString)*/
typedef void(^KBStringBlock)(NSString * _Nullable str);
/**void(^)(NSNumber)*/
typedef void(^KBNumberBlock)(NSNumber * _Nullable num);
/**void(^)(NSData)*/
typedef void(^KBDataBlock)(NSData * _Nullable dat);
/**void(^)(NSArray)*/
typedef void(^KBArrayBlock)(NSArray * _Nullable arr);
/**void(^)(NSDictionary)*/
typedef void(^KBDictionaryBlock)(NSDictionary * _Nullable dic);
/**void(^)(id)*/
typedef void(^KBAnyBlock)(id _Nullable obj);


/**void(^)(BOOL,NSString)*/
typedef void(^KBBoolStringBlock)(BOOL bol, NSString * _Nullable str);
/**void(^)(BOOL,NSNumber)*/
typedef void(^KBBoolNumberBlock)(BOOL bol, NSNumber * _Nullable num);
/**void(^)(BOOL,NSData)*/
typedef void(^KBBoolDataBlock)(BOOL bol, NSData * _Nullable dat);
/**void(^)(BOOL,NSArray)*/
typedef void(^KBBoolArrayBlock)(BOOL bol, NSArray * _Nullable arr);
/**void(^)(BOOL,NSDictionary)*/
typedef void(^KBBoolDictionaryBlock)(BOOL bol, NSDictionary * _Nullable dic);


/**void(^)(NSInteger,NSString)*/
typedef void(^KBIntegerStringBlock)(NSInteger itg, NSString * _Nullable str);
/**void(^)(NSIntege,NSNumberr)*/
typedef void(^KBIntegerNumberBlock)(NSInteger itg, NSNumber * _Nullable num);
/**void(^)(NSInteger,NSData)*/
typedef void(^KBIntegerDataBlock)(NSInteger itg, NSData * _Nullable dat);
/**void(^)(NSInteger,NSArray)*/
typedef void(^KBIntegerArrayBlock)(NSInteger itg, NSArray * _Nullable arr);
/**void(^)(NSInteger,NSDictionary)*/
typedef void(^KBIntegerDictionaryBlock)(NSInteger itg, NSDictionary * _Nullable dic);


/**void(^)(NSString,NSString)*/
typedef void(^KBStringResultBlock)(NSString * _Nullable str, NSString * _Nullable msg);
/**void(^)(NSNumber,NSString)*/
typedef void(^KBNumberResultBlock)(NSNumber * _Nullable num, NSString * _Nullable msg);
/**void(^)(NSData,NSString)*/
typedef void(^KBDataResultBlock)(NSData * _Nullable dat, NSString * _Nullable msg);
/**void(^)(NSArray,NSString)*/
typedef void(^KBArrayResultBlock)(NSArray * _Nullable arr, NSString * _Nullable msg);
/**void(^)(NSDictionary,NSString)*/
typedef void(^KBDictionaryResultBlock)(NSDictionary * _Nullable dic, NSString * _Nullable msg);
/**void(^)(id,NSString)*/
typedef void(^KBAnyResultBlock)(id _Nullable obj, NSString * _Nullable msg);


#endif /* KBBlock_h */
