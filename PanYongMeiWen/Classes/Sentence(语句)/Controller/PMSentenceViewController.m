//
//  PMSentenceViewController.m
//  PanYongMeiWen
//
//  Created by panyong on 14-1-28.
//  Copyright (c) 2014年 panyong. All rights reserved.
//

#import "PMSentenceViewController.h"
#import "PMHTTPTool.h"
#import "PMStatusTool.h"
#import "PMAccountTool.h"
@interface PMSentenceViewController ()

@end

@implementation PMSentenceViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell" ];
    //1.设置UI界面
    [self setupUI];
    //2.设置数据
    [self setupData];
    
}


- (void)setupUI
{
    //1.设置UI界面的button
    //2.设置背景色
    self.view.backgroundColor = PMGlobalBgColor;

}


- (void)setupData
{
    
    PMLog(@"access_token:%@------------",[PMAccountTool currentAccount].access_token);
    
    
    [PMStatusTool statusesWithAccessToken:[PMAccountTool currentAccount].access_token success:^(NSArray *statuses) {
        PMLog(@"获取数据成功");
    } failure:nil];
    
    
//    [PWStatusTool statusesWithAccessToken:[IWAccountTool currentAccount].access_token success:^(NSArray *statuses) {
//        _statuses = statuses;
//        [self.tableView reloadData];
//    } failure:nil];
}




/**
 *  控制器的view重新显示出来的时候就会调用（在这个方法中会重新显示滚动条）
 *  覆盖这个方法的目的是：不要在控制器的view显示出来时出现滚动条
 */
- (void)viewDidAppear:(BOOL)animated {}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = @"哈哈哈";
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tabBarItem.badgeValue = @"200";
    self.tabBarItem.title = @"哈哈";
    UIViewController *view = [[UIViewController alloc] init];
    view.title = @"nima";
    view.view.backgroundColor = [UIColor redColor];
    //view.hidesBottomBarWhenPushed = YES;
   [self.navigationController pushViewController:view animated:YES];

}


@end
