//
//  KBProperty.h
//  SXT
//
//  Created by SXJY on 2019/1/18.
//  Copyright © 2019 KeBing. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef KBProperty_h
#define KBProperty_h

#define KBAssignProperty                        @property (nonatomic, assign)
#define KBCopyProperty                          @property (nonatomic, copy, nullable)
#define KBStrongProperty                        @property (nonatomic, strong, nullable)
#define KBWeakProperty                          @property (nonatomic, weak, nullable)

#define KBStrongPropertyWithClass(class)        KBStrongProperty class *

#define KBStrongReadProperty                    @property (nonatomic, strong, readonly)
#define KBCopyReadProperty                      @property (nonatomic, copy, readonly)
#define KBStrongReadPropertyWithClass(class)    KBStrongReadProperty class *

#define KBStringProperty                        KBCopyProperty NSString *
#define KBDataProperty                          KBStrongProperty NSData *
#define KBNumberProperty                        KBStrongProperty NSNumber *
#define KBViewProperty                          KBStrongProperty UIView *
#define KBColorProperty                         KBStrongProperty UIColor *
#define KBImageProperty                         KBStrongProperty UIImage *
#define KBIntegerProperty                       KBAssignProperty NSInteger
#define KBFloatProperty                         KBAssignProperty CGFloat
#define KBBOOLProperty                          KBAssignProperty BOOL
#define KBInsetsProperty                        KBAssignProperty UIEdgeInsets
#define KBStrongIdProperty                      KBStrongProperty id


#define KBArrayProperty                             KBStrongProperty NSArray *
#define KBMutableArrayProperty                      KBStrongProperty NSMutableArray *
#define KBArrayPropertyWithType(ObjType)            KBStrongProperty NSArray<ObjType *> *
#define KBMutableArrayPropertyWithType(ObjType)     KBStrongProperty NSMutableArray<ObjType *> *


#define KBDictionaryProperty                            KBStrongProperty NSDictionary *
#define KBMutableDictionaryProperty                     KBStrongProperty NSMutableDictionary *
#define KBDictionaryPropertyWithType(key,value)         KBStrongProperty NSDictionary<key *,value *> *
#define KBMutableDictionaryPropertyWithType(key,value)  KBStrongProperty NSMutableDictionary<key *,value *> *


#define KBMutableSetPropertyWithType(ObjType)           KBStrongProperty NSMutableSet<ObjType *> *
#define KBMutableOrderedSetPropertyWithType(ObjType)    KBStrongProperty NSMutableOrderedSet<ObjType *> *


#define KBBlockProperty                         KBCopyProperty


#define kbAppDelegateProperty(ProtocolType)        KBWeakProperty id<ProtocolType>
#define kbAppDelegatesProperty(ProtocolType)       KBStrongProperty NSMutableSet<id<ProtocolType>> *

#endif /* KBProperty_h */
