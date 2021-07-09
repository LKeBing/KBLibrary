//
//  KBDeleteSubviewsTableViewCell.m
//  KBLibrary_Example
//
//  Created by SXJY on 2021/7/9.
//  Copyright © 2021 LKeBing. All rights reserved.
//

#import "KBDeleteSubviewsTableViewCell.h"
#import "KBLibrary.h"

@implementation KBDeleteSubviewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.backgroundColor = kbRandomColor;
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)delete:(id)sender {
    [self.contentView kb_removeSubviews];
}

@end
