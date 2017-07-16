//
//  News.h
//  test
//
//  Created by Arkadiy Grigoryanc on 16.07.17.
//  Copyright © 2017 Olya Danylova. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject

@property (strong, nonatomic) NSString *objectId;
@property (strong, nonatomic) NSString *header;
@property (strong, nonatomic) NSString *text;
@property (assign, nonatomic) bool isRead;

@end
