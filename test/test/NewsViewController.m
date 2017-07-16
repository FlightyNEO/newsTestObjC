//
//  NewsViewController.m
//  test
//
//  Created by Arkadiy Grigoryanc on 16.07.17.
//  Copyright © 2017 Olya Danylova. All rights reserved.
//

#import "NewsViewController.h"
#import "ServerManager.h"
#import "NewTableViewCell.h"
#import "News.h"
#import "NewViewController.h"

@interface NewsViewController ()

@property (strong, nonatomic) NSMutableArray<News *> *news;

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Масштабирование
    self.tableView.estimatedRowHeight = 100.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // fetch news
    [self fetchNews];
    
}

- (void)fetchNews {
    
    [[ServerManager manager] fetchNews:^(NSArray *news) {
        
        self.news = [NSMutableArray arrayWithArray:news];
        
        if (news.count > 0) {
            
            [self.tableView reloadData];
            
        } else {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                                     message:@"No news"
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:alertController animated:YES completion:^{
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [alertController dismissViewControllerAnimated:YES completion:nil];
                    
                });
                
            }];
            
        }
        
    } onFailure:^(Fault *fault) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                 message:@"Sory. An error occurred, try to update."
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok"
                                                               style:UIAlertActionStyleCancel
                                                             handler:nil];
        
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:^{
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [alertController dismissViewControllerAnimated:YES completion:nil];
                
            });
            
        }];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _news.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    News *new = _news[indexPath.row];
    
    cell.label.text = new.header;
    
    cell.accessoryType = new.isRead ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier  isEqual: @"ShowNew"]) {
        
        NewViewController *vc = segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        if (indexPath != nil) {
            
            vc.news = _news[indexPath.row];
            
        }
        
    }
    
}

#pragma mark - Actions

- (IBAction)actionUnwindToNews:(UIStoryboardSegue *)segue {
    
    if ([segue.identifier isEqualToString:@"UnwindToNews"]) {
        
        NewViewController *vc = segue.sourceViewController;
        
        for (int i = 0; i < _news.count; i++) {
            
            if ([_news[i].objectId isEqualToString:vc.news.objectId]) {
                
                _news[i] = vc.news;
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                
                continue;
                
            }
            
        }
        
    }
    
}





@end














