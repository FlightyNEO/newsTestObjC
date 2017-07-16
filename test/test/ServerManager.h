//
//  ServerManager.h
//  test
//
//  Created by Arkadiy Grigoryanc on 16.07.17.
//  Copyright © 2017 Olya Danylova. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Fault;
@class News;

@interface ServerManager : NSObject

+ (ServerManager *)manager;

- (void)fetchNews:(void(^)(NSArray<News *> *news))success
        onFailure:(void(^)(Fault *fault))failure;

- (void)readNew:(News *)new
      onSuccess:(void(^)(void))success
      onFailure:(void(^)(Fault *fault))failure;

@end
