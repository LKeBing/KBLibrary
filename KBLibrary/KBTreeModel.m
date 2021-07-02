//
//  KBTreeModel.m
//  SXT
//
//  Created by KB on 2019/3/2.
//  Copyright © 2019年 KeBing. All rights reserved.
//

#import "KBTreeModel.h"

@interface KBTreeModel ()

@property(nullable,nonatomic,strong) KBTreeModel *supermode_private;

@property(nonatomic,strong) NSMutableOrderedSet<__kindof KBTreeModel *> *submodes_private;
@property(nonatomic,strong) NSMutableSet<__kindof KBTreeModel *> *leafModels_private;
@property(nonatomic,strong) NSMutableSet<__kindof KBTreeModel *> *models_private;

@property(nonatomic,strong) NSMutableOrderedSet<__kindof KBTreeModel *> *visibleSubmodels_private;
@property(nonatomic,strong) NSMutableSet<__kindof KBTreeModel *> *visibleLeafModels_private;
@property(nonatomic,strong) NSMutableSet<__kindof KBTreeModel *> *visibleModels_private;

@property(nonatomic,strong) NSMutableOrderedSet<__kindof KBTreeModel *> *selectedSubmodels_private;
@property(nonatomic,strong) NSMutableSet<__kindof KBTreeModel *> *selectedLeafModels_private;
@property(nonatomic,strong) NSMutableSet<__kindof KBTreeModel *> *selectedModels_private;

@property(nonatomic,strong) KBModelGene *gene;
@property(nonatomic,strong) NSMutableSet<__kindof KBModelGene *> *leafGenes_private;
@property(nonatomic,strong) NSMutableSet<__kindof KBModelGene *> *selectedLeafGenes_private;

@property(nonatomic,strong) NSMutableSet<id<KBModelDelegate>> *delegates;

@property(nonatomic,assign) BOOL didChangeSelectedLeafModelFlag;

@property(nonatomic,strong) NSMutableSet<__kindof KBTreeModel *> *selectedDidChangeLeafModels;
@property(nonatomic,strong) NSMutableSet<__kindof KBTreeModel *> *selectedSetDidChangeSupermodels;

@property(nonatomic,assign) BOOL backupSelected;

@end

@implementation KBTreeModel


- (instancetype)init {
    if (self = [super init]) {
        _visible = YES;
        
        self.gene = [KBModelGene new];
        [self.gene.models addObject:self];
        [self.leafGenes_private addObject:self.gene];
    }
    return self;
}

- (void)releaseGene {
    self.supermode_private = nil;
    [_leafModels_private removeAllObjects];
    [_models_private removeAllObjects];
    [_visibleSubmodels_private removeAllObjects];
    [_visibleLeafModels_private removeAllObjects];
    [_visibleModels_private removeAllObjects];
    [_selectedSubmodels_private removeAllObjects];
    [_selectedLeafModels_private removeAllObjects];
    [_selectedModels_private removeAllObjects];
    [_leafGenes_private removeAllObjects];
    [_selectedLeafGenes_private removeAllObjects];
    [_delegates removeAllObjects];
    [_selectedDidChangeLeafModels removeAllObjects];
    [_selectedSetDidChangeSupermodels removeAllObjects];
    [_gene.models removeObject:self];
    if (self.submodes_private.count>0) {
        [self.submodes_private enumerateObjectsUsingBlock:^(__kindof KBTreeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj releaseGene];
        }];
    }
    [_submodes_private removeAllObjects];
}

#pragma mark - 属性的 setter 方法

- (void)setIdentifier:(NSString *)identifier {
    _identifier = identifier;

    self.gene.identifier = _identifier;
}



#pragma mark - 协议

- (void)addDelegate:(id<KBModelDelegate>)delegate {
    if (delegate == nil || ![delegate conformsToProtocol:@protocol(KBModelDelegate)]) {
        return;
    }

    [self.delegates addObject:delegate];
}
- (void)removeDelegate:(id<KBModelDelegate>)delegate {
    if (delegate == nil || ![delegate conformsToProtocol:@protocol(KBModelDelegate)]) {
        return;
    }

    [self.delegates removeObject:delegate];
}






#pragma mark - 添加节点

- (void)addSubmodels:(NSArray<KBTreeModel *> *)modes {
    if (modes == nil || modes.count == 0) {
        return;
    }

    [modes makeObjectsPerformSelector:@selector(addToSupermodel:) withObject:self];
}
- (void)addToSupermodel:(KBTreeModel *)supermodel {
    if (supermodel == nil) {
        return;
    }

    [supermodel addSubmodel:self];
}
- (void)addSubmodel:(KBTreeModel *)model {
    //不能往树上加无效节点
    if (model == nil || [model isKindOfClass:[NSNull class]]) {
        return;
    }

    //添加到子节点列表
    [self.submodes_private addObject:model];
    _submodels = nil;

    if (model.visible) {
        [self.visibleSubmodels_private addObject:model];
        _visibleSubmodels = nil;
    }

    if (model.selected) {
        [self.selectedSubmodels_private addObject:model];
        _selectedSubmodels = nil;
    }

    //model加入到子节点之后就有了父节点
    [model setSupermode_private:self];

    [self model:self didAddSubmode:model];
}
- (void)model:(KBTreeModel *)model didAddSubmode:(KBTreeModel *)submodel {
    [self.leafModels_private removeObject:model];
    [self.leafModels_private unionSet:submodel.leafModels_private];
    [self.models_private unionSet:submodel.models_private];

    [self.visibleLeafModels_private removeObject:model];
    [self.visibleLeafModels_private unionSet:submodel.visibleLeafModels_private];
    [self.visibleModels_private unionSet:submodel.visibleModels_private];

    [self.selectedLeafModels_private removeObject:model];
    [self.selectedLeafModels_private unionSet:submodel.selectedLeafModels_private];
    [self.selectedModels_private unionSet:submodel.selectedModels_private];

    [self.leafGenes_private removeObject:model.gene];
    [self.selectedLeafGenes_private removeObject:model.gene];

    __weak typeof(self) weakSelf = self;

    [submodel.leafModels_private enumerateObjectsUsingBlock:^(__kindof KBTreeModel * _Nonnull obj, BOOL * _Nonnull stop) {
        KBModelGene *leafGene = obj.gene;
        if (weakSelf.allowSameGene || leafGene.identifier==nil) {
            [weakSelf.leafGenes_private addObject:leafGene];
            if (leafGene.selected) {
                [weakSelf.selectedLeafGenes_private addObject:leafGene];
            }
        } else {
            __block KBModelGene *existingGene = nil;
            [weakSelf.leafGenes_private enumerateObjectsUsingBlock:^(__kindof KBModelGene * _Nonnull obj2, BOOL * _Nonnull stop) {
                if ([leafGene.identifier isEqualToString:obj2.identifier]) {
                    existingGene = obj2;
                    *stop = YES;
                }
            }];
            if (existingGene) {
                [existingGene.models unionSet:leafGene.models];
                if (![existingGene isEqual:leafGene]) {
                    [leafGene.models removeObject:obj];
                    obj.gene = existingGene;
                    [obj replaceGene:leafGene withNewGene:existingGene];
                }
            } else {
                [weakSelf.leafGenes_private addObject:leafGene];
                if (leafGene.selected) {
                    [weakSelf.selectedLeafGenes_private addObject:leafGene];
                }
            }
        }
    }];

    _leafModels = nil;
    _models = nil;
    _visibleLeafModels = nil;
    _visibleModels = nil;
    _selectedLeafModels = nil;
    _selectedModels = nil;
    _leafGenes = nil;
    _selectedLeafGenes = nil;

    //告诉父节点我新增了个节点
    [self.supermode_private model:model didAddSubmode:submodel];
}


- (void)replaceGene:(KBModelGene *)oldGene withNewGene:(KBModelGene *)newGene {
    [self.leafGenes_private removeObject:oldGene];
    [self.leafGenes_private addObject:newGene];
    [self.supermode_private replaceGene:oldGene withNewGene:newGene];
}

#pragma mark - 移除节点

- (void)removeAllSubmodels {
    if (self.submodes_private == nil || self.submodes_private.count == 0) {
        return;
    }

    [self removeSubmodels:self.submodes_private.array];

    __weak typeof(self) weakSelf = self;

    [self.delegates enumerateObjectsUsingBlock:^(id<KBModelDelegate>  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(modelDidRemoveAllSubmodes:)]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [obj modelDidRemoveAllSubmodes:weakSelf];
            });
        }
    }];
}
- (void)removeSubmodels:(NSArray<KBTreeModel *> *)modes {
    if (modes == nil || modes.count == 0) {
        return;
    }

    [modes makeObjectsPerformSelector:@selector(removeFromSupermodel)];
}
- (void)removeFromSupermodel {
    if (self.supermode_private == nil) {
        return;
    }

    [self.supermode_private removeSubmodel:self];
}
- (void)removeSubmodel:(KBTreeModel *)model {
    //如果节点无效，无需执行移除操作
    if (model == nil || [model isKindOfClass:[NSNull class]]) {
        return;
    }

    //从子节点列表移除
    [self.submodes_private removeObject:model];

    //从可见的子节点列表移除
    [self.visibleSubmodels_private removeObject:model];

    //从选中的子节点列表移除
    [self.selectedSubmodels_private removeObject:model];

    //移除父节点
    [model setSupermode_private:nil];

    [self model:self didRemoveSubmode:model];
}
- (void)model:(KBTreeModel *)model didRemoveSubmode:(KBTreeModel *)submodel {
    if (model.submodes_private.count == 0) {
        [self.leafModels_private addObject:model];
    }
    [self.leafModels_private minusSet:submodel.leafModels_private];
    [self.models_private minusSet:submodel.models_private];

    if (model.submodes_private.count == 0 && model.visible) {
        [self.visibleLeafModels_private addObject:model];
    }
    [self.visibleLeafModels_private minusSet:submodel.visibleLeafModels_private];
    [self.visibleModels_private minusSet:submodel.visibleModels_private];

    if (model.submodes_private.count == 0 && model.selected) {
        [self.selectedLeafModels_private addObject:model];
    }
    [self.selectedLeafModels_private minusSet:submodel.selectedLeafModels_private];
    [self.selectedModels_private minusSet:submodel.selectedModels_private];

    if (model.submodels.count == 0) {
        [self.leafGenes_private addObject:model.gene];
    }
    if (model.submodels.count == 0 && model.gene.selected) {
        [self.selectedLeafGenes_private addObject:model.gene];
    }

    __weak typeof(self) weakSelf = self;

    [submodel.leafModels_private enumerateObjectsUsingBlock:^(__kindof KBTreeModel * _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj.gene.models containsObject:obj]) {
            if (obj.gene.models.count == 1) {
                [weakSelf.leafGenes_private removeObject:obj.gene];
                [weakSelf.selectedLeafGenes_private removeObject:obj.gene];
            } else if (obj.gene.models.count > 1) {
                [obj.gene.models removeObject:obj];
            }
        }
    }];

    _leafModels = nil;
    _models = nil;
    _visibleLeafModels = nil;
    _visibleModels = nil;
    _selectedLeafModels = nil;
    _selectedModels = nil;
    _leafGenes = nil;
    _selectedLeafGenes = nil;

    //告诉父节点我删除了个节点
    [self.supermode_private model:model didRemoveSubmode:submodel];
}


- (void)exchangeSubmodelAtIndex:(NSUInteger)idx1 withSubmodelAtIndex:(NSUInteger)idx2 {
    [self.submodes_private exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
    _submodels = nil;
}
- (void)replaceSubmodel:(__kindof KBTreeModel *)submodel withModel:(__kindof KBTreeModel *)model {
    //不能往树上加无效节点
    if (model == nil || [model isKindOfClass:[NSNull class]]) {
        return;
    }

    //添加到子节点列表
    [self.submodes_private replaceObjectAtIndex:[self.submodes_private indexOfObject:submodel] withObject:model];
    _submodels = nil;

    if (model.visible) {
        [self.visibleSubmodels_private replaceObjectAtIndex:[self.visibleSubmodels_private indexOfObject:submodel] withObject:model];
        _visibleSubmodels = nil;
    }

    if (model.selected) {
        [self.selectedSubmodels_private replaceObjectAtIndex:[self.selectedSubmodels_private indexOfObject:submodel] withObject:model];
        _selectedSubmodels = nil;
    }

    //model加入到子节点之后就有了父节点
    [model setSupermode_private:self];

    [self model:self didAddSubmode:model];
}





#pragma mark - 隐藏

- (void)setVisible:(BOOL)visible {
    [self.leafModels_private makeObjectsPerformSelector:@selector(changeLeafModelVisible:) withObject:@(visible)];
}
- (void)changeLeafModelVisible:(NSNumber *)visible {
    if (_visible == visible.boolValue) {
        return;
    }

    _visible = visible.boolValue;

    [self leafModelDidChangeVisible:self];
}
- (void)leafModelDidChangeVisible:(KBTreeModel *)leafModel {

    if (leafModel.visible) {
        [self.visibleLeafModels_private addObject:leafModel];
        [self.visibleModels_private addObject:leafModel];
    } else {
        [self.visibleLeafModels_private removeObject:leafModel];
        [self.visibleModels_private removeObject:leafModel];
    }


    if (_selectedLeafModels_private.count>0) {
        BOOL selected = [self.visibleLeafModels_private isSubsetOfSet:self.selectedLeafModels_private];
        [self changeSelected:@(selected)];
    }


    _visible = self.visibleLeafModels_private.count > 0;


    if (_visible) {
        [self.visibleModels_private addObject:self];
    } else {
        [self.visibleModels_private removeObject:self];
    }

    __weak typeof(self) weakSelf = self;

    if (self.supermode_private) {
        if (_visible) {
            [self.supermode_private.visibleModels_private addObject:self];
        } else {
            [self.supermode_private.visibleModels_private removeObject:self];
        }

        [self.supermode_private.visibleSubmodels_private removeAllObjects];
        [self.supermode_private.submodes_private enumerateObjectsUsingBlock:^(__kindof KBTreeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.visible) {
                [weakSelf.supermode_private.visibleSubmodels_private addObject:obj];
            }
        }];
        [self.supermode_private.delegates enumerateObjectsUsingBlock:^(id<KBModelDelegate>  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([obj respondsToSelector:@selector(modelDidChangeVisibleSubmodels:)]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [obj modelDidChangeVisibleSubmodels:weakSelf.supermode_private];
                });
            }
        }];
    }


    _visibleSubmodels = nil;
    _visibleLeafModels = nil;
    _visibleModels = nil;


    //告诉父节点我的selected值发生改变
    [self.supermode_private leafModelDidChangeVisible:leafModel];
}







#pragma mark - 选中

- (void)setAllSelected:(BOOL)allSelected {
    [self changeCurrentModeLineAllSelected:@(allSelected)];
    [self excluseOtherModeLineIfNeeded];
}
- (void)changeCurrentModeLineAllSelected:(NSNumber *)allSelected {
    [self startUpdateSelectedInfo:^BOOL(KBTreeModel *model) {
        return model.selected != allSelected.boolValue;
    }];
}


- (void)setSelected:(BOOL)selected {
    [self changeCurrentModeLineSelected:@(selected)];
    [self excluseOtherModeLineIfNeeded];
}
- (void)changeCurrentModeLineSelected:(NSNumber *)selected {
    [self startUpdateSelectedInfo:^BOOL(KBTreeModel *model) {
        return model.visible && model.selected != selected.boolValue;
    }];
}


- (void)changeSelected:(NSNumber *)selected {
    if (_selected == selected.boolValue) {
        return;
    }

    _selected = selected.boolValue;

    __weak typeof(self) weakSelf = self;

    [self.delegates enumerateObjectsUsingBlock:^(id<KBModelDelegate>  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(modelDidChangeSelected:)]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [obj modelDidChangeSelected:weakSelf];
            });
        }
    }];
}
- (void)changeModelLineSelectedSet:(KBTreeModel *)leafModel {

    if (leafModel==nil) {
        leafModel = self;
    }

    @synchronized (self) {
        if (leafModel.selected) {
            if ([self.submodels containsObject:leafModel]) {
                [self.selectedSubmodels_private addObject:leafModel];
            }
            [self.selectedLeafModels_private addObject:leafModel];
            [self.selectedModels_private addObject:leafModel];
            if (leafModel.gene && ![self.selectedLeafGenes_private containsObject:leafModel.gene]) {
                [self.selectedLeafGenes_private addObject:leafModel.gene];
            }
        } else {
            if ([self.submodels containsObject:leafModel]) {
                [self.selectedSubmodels_private removeObject:leafModel];
            }
            [self.selectedLeafModels_private removeObject:leafModel];
            [self.selectedModels_private removeObject:leafModel];
            if (leafModel.gene && [self.selectedLeafGenes_private containsObject:leafModel.gene]) {
                [self.selectedLeafGenes_private removeObject:leafModel.gene];
            }
        }
    }

    _selectedSubmodels = nil;
    _selectedLeafModels = nil;
    _selectedModels = nil;
    _selectedLeafGenes = nil;
    _didChangeSelectedLeafModelFlag = YES;

    [self.supermode_private changeModelLineSelectedSet:leafModel];
}

- (void)changeModelLineSelected {
    BOOL selected = [self.visibleLeafModels_private isSubsetOfSet:self.selectedLeafModels_private];
    [self changeSelected:@(selected)];

    __weak typeof(self) weakSelf = self;

    if (self.didChangeSelectedLeafModelFlag) {
        self.didChangeSelectedLeafModelFlag = NO;
        [self.delegates enumerateObjectsUsingBlock:^(id<KBModelDelegate>  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([obj respondsToSelector:@selector(modelDidChangeSelectedLeafModels:)]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [obj modelDidChangeSelectedLeafModels:weakSelf];
                });
            }
        }];
    }

    [self.supermode_private changeModelLineSelected];
}

- (void)excluseOtherModeLineIfNeeded {
    KBTreeModel *model = self.supermode_private;
    while (model != nil) {
        KBTreeModel *supermodel = model.supermodel;
        if (supermodel) {
            if (supermodel.exclusionSelected) {
                [supermodel.submodes_private enumerateObjectsUsingBlock:^(__kindof KBTreeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (![obj isEqual:model] && obj.selectedLeafModels_private.count > 0) {
                        [obj changeCurrentModeLineSelected:@NO];
                    }
                }];
            }
            model = supermodel;
        } else {
            break;
        }
    }
}











#pragma mark -- 备份与恢复

- (void)backup {
    [self.models_private enumerateObjectsUsingBlock:^(__kindof KBTreeModel * _Nonnull obj, BOOL * _Nonnull stop) {
        obj.backupSelected = obj.selected;
    }];
}
- (void)recovery {
    [self startUpdateSelectedInfo:^BOOL(KBTreeModel *model) {
        return model.selected != model.backupSelected;
    }];
}






- (void)startUpdateSelectedInfo:(BOOL(^)(KBTreeModel *model))block {
    [_selectedDidChangeLeafModels removeAllObjects];
    [_selectedSetDidChangeSupermodels removeAllObjects];
    
    __weak typeof(self) weakSelf = self;

    [self.leafGenes_private enumerateObjectsUsingBlock:^(__kindof KBModelGene * _Nonnull gene, BOOL * _Nonnull stop) {
        [gene.models enumerateObjectsUsingBlock:^(KBTreeModel * _Nonnull model, BOOL * _Nonnull stop) {
            if (block(model)) {
                [model changeSelected:@(!model.selected)];
                
                [weakSelf.selectedDidChangeLeafModels addObject:model];
                
                KBTreeModel *supermodel = model.supermode_private;
                while (supermodel) {
                    [weakSelf.selectedSetDidChangeSupermodels addObject:supermodel];
                    supermodel = supermodel.supermodel;
                }
            };
        }];
    }];
    
    [self.selectedDidChangeLeafModels makeObjectsPerformSelector:@selector(changeModelLineSelectedSet:) withObject:nil];
    [self.selectedSetDidChangeSupermodels makeObjectsPerformSelector:@selector(changeModelLineSelected)];
}




#pragma mark - 属性的 getter 方法，懒加载

- (NSMutableSet<KBTreeModel *> *)selectedDidChangeLeafModels {
    if (_selectedDidChangeLeafModels == nil) {
        _selectedDidChangeLeafModels = [NSMutableSet new];
    }
    return _selectedDidChangeLeafModels;
}
- (NSMutableSet<KBTreeModel *> *)selectedSetDidChangeSupermodels {
    if (_selectedSetDidChangeSupermodels == nil) {
        _selectedSetDidChangeSupermodels = [NSMutableSet new];
    }
    return _selectedSetDidChangeSupermodels;
}
- (NSMutableSet<KBModelGene *> *)leafGenes_private {
    if (_leafGenes_private == nil) {
        _leafGenes_private = [NSMutableSet new];
    }
    return _leafGenes_private;
}
- (NSMutableSet<id<KBModelDelegate>> *)delegates {
    if (_delegates == nil) {
        _delegates = [NSMutableSet set];
    }
    return _delegates;
}
- (NSMutableSet<KBTreeModel *> *)selectedLeafModels_private {
    if (_selectedLeafModels_private == nil) {
        _selectedLeafModels_private = [NSMutableSet new];
    }
    return _selectedLeafModels_private;
}
- (NSMutableOrderedSet<KBTreeModel *> *)visibleSubmodels_private {
    if (_visibleSubmodels_private == nil) {
        _visibleSubmodels_private = [[NSMutableOrderedSet alloc] init];
    }
    return _visibleSubmodels_private;
}
- (NSMutableSet<KBTreeModel *> *)visibleLeafModels_private {
    if (_visibleLeafModels_private == nil) {
        _visibleLeafModels_private = [NSMutableSet setWithObject:self];
    }
    return _visibleLeafModels_private;
}
- (NSMutableSet<KBTreeModel *> *)visibleModels_private {
    if (_visibleModels_private == nil) {
        _visibleModels_private = [NSMutableSet setWithObject:self];
    }
    return _visibleModels_private;
}
- (NSMutableSet<KBTreeModel *> *)leafModels_private {
    if (_leafModels_private == nil) {
        _leafModels_private = [NSMutableSet setWithObject:self];
    }
    return _leafModels_private;
}
- (NSMutableOrderedSet<KBTreeModel *> *)submodes_private {
    if (_submodes_private == nil) {
        _submodes_private = [[NSMutableOrderedSet alloc] init];//我刚被创建的时候，还没有子节点，该列表为空
    }
    return _submodes_private;
}
- (NSMutableSet<KBTreeModel *> *)models_private {
    if (_models_private == nil) {
        _models_private = [NSMutableSet setWithObject:self];
    }
    return _models_private;
}
- (NSMutableOrderedSet<KBTreeModel *> *)selectedSubmodels_private {
    if (_selectedSubmodels_private == nil) {
        _selectedSubmodels_private = [NSMutableOrderedSet new];
    }
    return _selectedSubmodels_private;
}
- (NSMutableSet<KBTreeModel *> *)selectedModels_private {
    if (_selectedModels_private == nil) {
        _selectedModels_private = [NSMutableSet new];
    }
    return _selectedModels_private;
}
- (NSMutableSet<KBModelGene *> *)selectedLeafGenes_private {
    if (_selectedLeafGenes_private == nil) {
        _selectedLeafGenes_private = [NSMutableSet new];
    }
    return _selectedLeafGenes_private;
}






@synthesize submodels = _submodels;
@synthesize models = _models;
@synthesize leafModels = _leafModels;
@synthesize visibleModels = _visibleModels;
@synthesize visibleLeafModels = _visibleLeafModels;
@synthesize visibleSubmodels = _visibleSubmodels;
@synthesize selectedLeafModels = _selectedLeafModels;
@synthesize selectedSubmodels = _selectedSubmodels;
@synthesize selectedModels = _selectedModels;
@synthesize leafGenes = _leafGenes;
@synthesize selectedLeafGenes = _selectedLeafGenes;

- (KBTreeModel *)supermodel {
    return self.supermode_private;
}
- (NSArray<KBTreeModel *> *)submodels {
    if (_submodels == nil) {
        _submodels = [self.submodes_private array];
    }
    return _submodels;
}
- (NSSet<KBTreeModel *> *)models {
    if (_models == nil) {
        _models = self.models_private.copy;
    }
    return _models;
}
- (NSSet<KBTreeModel *> *)leafModels {
    if (_leafModels == nil) {
        _leafModels = self.leafModels_private.copy;
    }
    return _leafModels;
}
- (NSSet<KBTreeModel *> *)visibleModels {
    if (_visibleModels == nil) {
        _visibleModels = self.visibleModels_private.copy;
    }
    return _visibleModels;
}
- (NSSet<KBTreeModel *> *)visibleLeafModels {
    if (_visibleLeafModels == nil) {
        _visibleLeafModels = self.visibleLeafModels_private.copy;
    }
    return _visibleLeafModels;
}
- (NSArray<KBTreeModel *> *)visibleSubmodels {
    if (_visibleSubmodels == nil) {
        _visibleSubmodels = self.visibleSubmodels_private.copy;
    }
    return _visibleSubmodels;
}
- (NSSet<KBTreeModel *> *)selectedLeafModels {
    if (_selectedLeafModels == nil) {
        _selectedLeafModels = self.selectedLeafModels_private.copy;
    }
    return _selectedLeafModels;
}
- (NSArray<KBTreeModel *> *)selectedSubmodels {
    if (_selectedSubmodels == nil) {
        _selectedSubmodels = self.selectedSubmodels_private.copy;
    }
    return _selectedSubmodels;
}
- (NSSet<KBTreeModel *> *)selectedModels {
    if (_selectedModels) {
        _selectedModels = self.selectedModels_private.copy;
    }
    return _selectedModels;
}
- (NSSet<KBModelGene *> *)leafGenes {
    if (_leafGenes == nil) {
        _leafGenes = self.leafGenes_private.copy;
    }
    return _leafGenes;
}
- (NSSet<KBModelGene *> *)selectedLeafGenes {
    if (_selectedLeafGenes == nil) {
        _selectedLeafGenes = self.selectedLeafGenes_private.copy;
    }
    return _selectedLeafGenes;
}

- (void)dealloc {
//    NSLog(@"释放%@",self.class);
}

@end


@implementation KBModelGene

- (NSMutableSet<KBTreeModel *> *)models {
    if (_models == nil) {
        _models = [NSMutableSet new];
    }
    return _models;
}

@end
