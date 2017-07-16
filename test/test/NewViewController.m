//
//  NewViewController.m
//  test
//
//  Created by Arkadiy Grigoryanc on 16.07.17.
//  Copyright © 2017 Olya Danylova. All rights reserved.
//

#import "NewViewController.h"
#import "News.h"
#import "ServerManager.h"

@interface NewViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *readButton;

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_news != nil) {
        
        // Set text
        _textView.text = _news.text;
        
        // Set button title
        NSString *title = _news.isRead ? @"Was read" : @"Mark as read";
        [_readButton setTitle:title forState:UIControlStateNormal];
        
        // Set header
        self.navigationItem.title = _news.header;
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)actionRead:(UIButton *)sender {
    
    if (_news != nil && !_news.isRead) {
        
        [[ServerManager manager] readNew:_news onSuccess:^{
            
            [sender setTitle:@"Was read" forState:UIControlStateNormal];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self performSegueWithIdentifier:@"UnwindToNews" sender:nil];
                
            });
            
        } onFailure:^(Fault *fault) {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                     message:@"Sory. An error occurred, please try again later."
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok"
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:nil];
            
            [alertController addAction:cancelAction];
            
            [self presentViewController:alertController animated:YES completion:^{
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [alertController dismissViewControllerAnimated:YES completion:nil];
                    
                });
                
            }];
            
        }];
        
    }
    
}







@end










