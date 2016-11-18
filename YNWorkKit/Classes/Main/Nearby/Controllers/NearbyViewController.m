//
//  NearbyViewController.m
//  YNWorkKit
//
//  Created by zyn on 2016/11/17.
//  Copyright © 2016年 张艳能. All rights reserved.
//

#import "NearbyViewController.h"
#import "DataModel.h"

@interface NearbyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

/**
   数据源
 */
@property (nonatomic,strong) NSArray *dataSource;

@end

@implementation NearbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}

- (void)setupUI {
    
    self.navigationItem.title = @"动画效果";
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_identifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_identifier"];
    }
    cell.textLabel.text = [self.dataSource[indexPath.row] title];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DataModel *model = self.dataSource[indexPath.row];
    Class class = NSClassFromString(model.targetVc);
    [self.navigationController pushViewController:[[class alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [DataModel modelDataSource];
    }
    return _dataSource;
}

@end
