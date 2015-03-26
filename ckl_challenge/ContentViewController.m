//
//  ContentViewController.m
//  ckl_challenge
//
//  Created by Marcela Tonon on 26/03/15.
//  Copyright (c) 2015 Marcela Tonon. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set the atributtes of the article on screen
    self.articleTitle.text = self.article.title ? self.article.title : @"";
    self.articleWebsite.text = self.article.website ? self.article.website : @"";
    self.articleAuthors.text = self.article.authors ? self.article.authors : @"";
    self.articleContent.text = self.article.content ? self.article.content : @"";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.articleDate.text = self.article.date ? [dateFormatter stringFromDate:self.article.date] : @"";
    
    //disable user from editing text
    self.articleContent.editable = NO;
    
    //configuring content text view
    self.articleContent.textAlignment = NSTextAlignmentJustified;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
