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

#define KBIntProperty                           KBAssignProperty int
#define KBIntegerProperty                       KBAssignProperty NSInteger
#define KBFloatProperty                         KBAssignProperty CGFloat
#define KBBOOLProperty                          KBAssignProperty BOOL
#define KBSizeProperty                          KBAssignProperty CGSize
#define KBPointProperty                         KBAssignProperty CGPoint
#define KBInsetsProperty                        KBAssignProperty UIEdgeInsets

#define KBStrongIdProperty                      KBStrongProperty id

#define KBStrongPropertyWithClass(class)        KBStrongProperty class *
#define KBStrongReadProperty                    @property (nonatomic, strong, readonly)
#define KBCopyReadProperty                      @property (nonatomic, copy, readonly)
#define KBStrongReadPropertyWithClass(class)    KBStrongReadProperty class *

#define KBStringProperty                        KBStrongPropertyWithClass(NSString)
#define KBAttributedStringProperty              KBStrongPropertyWithClass(NSAttributedString)
#define KBDataProperty                          KBStrongPropertyWithClass(NSData)
#define KBNumberProperty                        KBStrongPropertyWithClass(NSNumber)
#define KBColorProperty                         KBStrongPropertyWithClass(UIColor)
#define KBImageProperty                         KBStrongPropertyWithClass(UIImage)
#define KBURLProperty                           KBStrongPropertyWithClass(NSURL)

#define KBArrayProperty                             KBStrongPropertyWithClass(NSArray)
#define KBMutableArrayProperty                      KBStrongPropertyWithClass(NSMutableArray)
#define KBArrayPropertyWithType(ObjType)            KBStrongPropertyWithClass(NSArray<ObjType *>)
#define KBMutableArrayPropertyWithType(ObjType)     KBStrongPropertyWithClass(NSMutableArray<ObjType *>)

#define KBDictionaryProperty                            KBStrongPropertyWithClass(NSDictionary)
#define KBMutableDictionaryProperty                     KBStrongPropertyWithClass(NSMutableDictionary)
#define KBDictionaryPropertyWithType(key,value)         KBStrongPropertyWithClass(NSDictionary<key *,value *>)
#define KBMutableDictionaryPropertyWithType(key,value)  KBStrongPropertyWithClass(NSMutableDictionary<key *,value *>)

#define KBMutableSetPropertyWithType(ObjType)           KBStrongPropertyWithClass(NSMutableSet<ObjType *>)
#define KBMutableOrderedSetPropertyWithType(ObjType)    KBStrongPropertyWithClass(NSMutableOrderedSet<ObjType *>)

#define KBBlockProperty                         KBCopyProperty

#define KBDelegateProperty(ProtocolType)        KBWeakProperty id<ProtocolType>
#define KBDelegatesProperty(ProtocolType)       KBStrongPropertyWithClass(NSMutableSet<id<ProtocolType>>)

#define KBViewProperty          KBStrongPropertyWithClass(UIView)
#define KBLabelProperty         KBStrongPropertyWithClass(UILabel)
#define KBButtonProperty        KBStrongPropertyWithClass(UIButton)
#define KBImageViewProperty     KBStrongPropertyWithClass(UIImageView)

#endif /* KBProperty_h */
