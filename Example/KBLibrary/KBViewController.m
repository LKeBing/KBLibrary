//
//  KBViewController.m
//  KBLibrary
//
//  Created by LKeBing on 07/06/2021.
//  Copyright (c) 2021 LKeBing. All rights reserved.
//

#import "KBViewController.h"
#import "KBLibrary.h"
#import "KBTableViewCell.h"

@interface KBViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation KBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    kb_tableView_register_cell(tableView, UITableViewCell);
    kb_tableView_register_nibCell(tableView, KBTableViewCell);
    
    NSString *test = [NSNull null];
    KBLog(@"%f",test.doubleValue * 3);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row%2==1) {
        UITableViewCell *cell = kb_tableView_reuse_cell(tableView, UITableViewCell);
        cell.backgroundColor = kbRandomColor;
        return cell;
    } else {
        UITableViewCell *cell = kb_tableView_reuse_cell(tableView, KBTableViewCell);
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [KBTool roundTo2Decimal:110.34857943];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
