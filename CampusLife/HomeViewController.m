//
//  HomeViewController.m
//  CampusLife
//
//  Created by lane on 15/7/1.
//  Copyright (c) 2015年 LANE. All rights reserved.
//

#import "HomeViewController.h"
#import "AFNetworking.h"
#import "UIRefreshControl+AFNetworking.h"
#import "UIAlertView+AFNetworking.h"

#import "PostTableViewCell.h"
#import "Post.h"
#import "MJRefresh.h"

@interface HomeViewController ()

@property (readwrite, nonatomic, strong) NSArray *posts;

@end

@implementation HomeViewController{
    
}

- (void)loadNewData:(__unused id)sender {
    
    [Post globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        if (!error) {
            self.posts = posts;
            [self.tableView reloadData];
            
        }
        [self.tableView.header endRefreshing];
    }];
    
    //    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
    
}

- (void)loadMoreData:(__unused id)sender {

    [Post globalTimelinePostsWithBlock:^(NSArray *posts, NSError *error) {
        if (!error) {
            self.posts = posts;
            [self.tableView reloadData];
            
        }
        [self.tableView.footer endRefreshing];
    }];
    
    //    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 55.0f;
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData:nil];
        
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.tableView.header.autoChangeAlpha = YES;
    
    // 上拉刷新
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData:nil];

    }];
    
    //进入刷新状态并调用loadNewData方法
    [self.tableView.header beginRefreshing];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.posts.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
    cell.post = [self.posts objectAtIndex:(NSUInteger)indexPath.row];
    return cell;
        
}

//- (CGFloat)tableView:(__unused UITableView *)tableView
//heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return [PostTableViewCell heightForCellWithPost:[self.posts objectAtIndex:(NSUInteger)indexPath.row]];
//}
//
//- (void)tableView:(UITableView *)tableView
//didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
