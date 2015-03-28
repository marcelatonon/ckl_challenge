//
//  Article.h
//  ckl_challenge
//
//  Created by Marcela Tonon on 25/03/15.
//  Copyright (c) 2015 Marcela Tonon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *authors;
@property (nonatomic, strong) NSString *website;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic) bool read;

@end
