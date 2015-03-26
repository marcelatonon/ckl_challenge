//
//  ContentViewController.h
//  ckl_challenge
//
//  Created by Marcela Tonon on 26/03/15.
//  Copyright (c) 2015 Marcela Tonon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

@interface ContentViewController : UIViewController

@property (nonatomic, strong) Article *article;
@property (strong, nonatomic) IBOutlet UILabel *articleTitle;
@property (strong, nonatomic) IBOutlet UILabel *articleAuthors;
@property (strong, nonatomic) IBOutlet UILabel *articleWebsite;
@property (strong, nonatomic) IBOutlet UILabel *articleDate;
@property (strong, nonatomic) IBOutlet UITextView *articleContent;

@end
