//
//  News.m
//  test
//
//  Created by Arkadiy Grigoryanc on 16.07.17.
//  Copyright © 2017 Olya Danylova. All rights reserved.
//

#import "News.h"

@implementation News

- (instancetype)init {
    self = [super init];
    
    if (self) {
        
        _header = @"[Header]";
        _isRead = NO;
        
    }
    
    return self;
    
}

@end
