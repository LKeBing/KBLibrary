//
//  KBTreeModel.h
//  SXT
//
//  Created by KB on 2019/3/2.
//  Copyright © 2019年 KeBing. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class KBTreeModel;
@protocol KBModelDelegate <NSObject>
@optional;
- (void)modelDidChangeSelected:(KBTreeModel *)model;
- (void)modelDidChangeSelectedLeafModels:(KBTreeModel *)model;
- (void)modelDidChangeVisibleSubmodels:(KBTreeModel *)model;
- (void)modelDidRemoveAllSubmodes:(KBTreeModel *)model;
@end


@interface KBModelGene : NSObject
@property (nonatomic,getter=isSelected) BOOL selected;
@property (nonatomic,strong) NSMutableSet<KBTreeModel *> *models;
@property (nonatomic,copy,nullable) NSString *identifier;
@end



@interface KBTreeModel : NSObject


/**
 这个模型的标题
 */
@property (nonatomic,copy,nullable) NSString *title;
/**
 关于这个模型的详细描述
 */
@property (nonatomic,copy,nullable) NSString *detail;
/**
 唯一标识
 */
@property (nonatomic,copy,nullable) NSString *identifier;



/**
 父模型
 */
@property (nullable,nonatomic,readonly) __kindof KBTreeModel *supermodel;
/**
 所有子模型
 */
@property (nonatomic,readonly,strong) NSArray<__kindof KBTreeModel *> *submodels;
/**
 这棵数上所有的叶子模型，如果还没有子模型，那我自己就是一片叶子模型，这个列表就我自己，如果后期我添加了子模型，我就不再是叶子模型模型，需要从这个列表中移除
 */
@property (nonatomic,readonly,strong) NSSet<__kindof KBTreeModel *> *leafModels;
/**
 这棵数上所有的模型，包含自己
 */
@property (nonatomic,readonly,strong) NSSet<__kindof KBTreeModel *> *models;




/**
 该模型是否可见
 */
@property (nonatomic, getter=isVisible) BOOL visible;
/**
 可见的子模型
 */
@property (nonatomic,readonly,strong) NSArray<__kindof KBTreeModel *> *visibleSubmodels;
/**
 可见的叶子模型模型
 */
@property (nonatomic,readonly,strong) NSSet<__kindof KBTreeModel *> *visibleLeafModels;
/**
 可见的所有模型
 */
@property (nonatomic,readonly,strong) NSSet<__kindof KBTreeModel *> *visibleModels;




/**
 该模型是否选中
 如果该模型的选中状态发生改变，它的所有可视叶子模型都要跟着发生改变
 如果该模型下的所有可视叶子模型都被选中了，它自己的状态会跟着改变
 */
@property (nonatomic, getter=isSelected) BOOL selected;
/**
该模型是否选中
如果该模型的选中状态发生改变，它的所有叶子模型都要跟着发生改变
如果该模型下的所有叶子模型都被选中了，它自己的状态会跟着改变
*/
@property (nonatomic, getter=isAllSelected) BOOL allSelected;

/**
 该模型下子模型简选中操作是否互斥，如果互斥，那么同时只能有一个子模型被选中
 */
@property (nonatomic, getter=isExclusionSelected) BOOL exclusionSelected;
/**
 该模型下被选中的子模型
 */
@property (nonatomic,readonly,copy) NSArray<__kindof KBTreeModel *> *selectedSubmodels;
/**
 该模型下被选中的叶子模型模型
 */
@property (nonatomic,readonly,copy) NSSet<__kindof KBTreeModel *> *selectedLeafModels;
/**
 该模型下所有被选中的模型
 */
@property (nonatomic,readonly,copy) NSSet<__kindof KBTreeModel *> *selectedModels;




/**
 该模型往下是否允许一样的基因存在
 */
@property (nonatomic,assign) BOOL allowSameGene;
/**
 该模型下所有的叶子模型基因
 */
@property (nonatomic,readonly,strong) NSSet<__kindof KBModelGene *> *leafGenes;
/**
 该模型下处于选中状态的叶子模型模型基因
 */
@property (nonatomic,readonly,strong) NSSet<__kindof KBModelGene *> *selectedLeafGenes;




/**
 添加单个子模型
 
 @param model 要添加的子模型
 */
- (void)addSubmodel:(__kindof KBTreeModel *)model;
/**
 添加单个子模型
 
 将调用者添加到supermodel
 */
- (void)addToSupermodel:(__kindof KBTreeModel *)supermodel;
/**
 批量添加子模型
 
 @param models 多个子模型
 */
- (void)addSubmodels:(NSArray<__kindof KBTreeModel *> *)models;
/**
 移除单个子模型
 
 @param model 要移除的子模型
 */
- (void)removeSubmodel:(__kindof KBTreeModel *)model;
/**
 批量移除子模型
 
 @param models 多个子模型
 */
- (void)removeSubmodels:(NSArray<__kindof KBTreeModel *> *)models;
/**
 清空所有子模型
 */
- (void)removeAllSubmodels;
/**
 把自己从父模型上移除
 */
- (void)removeFromSupermodel;

- (void)exchangeSubmodelAtIndex:(NSUInteger)idx1 withSubmodelAtIndex:(NSUInteger)idx2;
- (void)replaceSubmodel:(__kindof KBTreeModel *)submodel withModel:(__kindof KBTreeModel *)model;

- (void)addDelegate:(id<KBModelDelegate>)delegate;
- (void)removeDelegate:(id<KBModelDelegate>)delegate;


- (void)backup;
- (void)recovery;

- (void)releaseGene;

@end

NS_ASSUME_NONNULL_END
