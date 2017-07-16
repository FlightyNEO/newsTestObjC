//
//  ServerManager.m
//  test
//
//  Created by Arkadiy Grigoryanc on 16.07.17.
//  Copyright © 2017 Olya Danylova. All rights reserved.
//

#import "ServerManager.h"
#import "Backendless.h"
#import "News.h"

#define APPLICATION_ID @"7F8AC5BF-6E47-E00D-FFC6-B77E03D08D00"
#define API_KEY @"1D90D4CE-FE28-EB9D-FFF5-60D30F942300"
#define SERVER_URL @"https://api.backendless.com"

#define backendless [Backendless sharedInstance]

@implementation ServerManager

+ (ServerManager *)manager {
    
    static ServerManager *manager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        manager = [[ServerManager alloc] init];
        
    });
    
    return manager;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        
        [backendless setHostUrl:SERVER_URL];
        [backendless initApp:APPLICATION_ID APIKey:API_KEY];
        
    }
    
    return self;
}

#pragma mark - API

/* fetch all 'news' */
- (void)fetchNews:(void(^)(NSArray<News *> *news))success
        onFailure:(void(^)(Fault *fault))failure {
    
    id<IDataStore>dataStore = [backendless.data of:News.class];
    
    [dataStore find:^(NSArray *response) {
        
        success(response);
        
    } error:^(Fault *fault) {
        
        failure(fault);
        
        NSLog(@"Server reported an error: %@", fault);
        
    }];
    
}

/* mark 'new' as read */
- (void)readNew:(News *)new
      onSuccess:(void(^)(void))success
      onFailure:(void(^)(Fault *fault))failure {
    
    new.isRead = YES;
    
    id<IDataStore>dataStore = [backendless.data of:News.class];
    
    [dataStore save:new response:^(NSDictionary<NSString*, NSString *> *result) {
        
        success();
        
    } error:^(Fault *fault) {
        
        failure(fault);
        
        NSLog(@"Server reported an error: %@", fault);
        
    }];
    
    
}







@end














