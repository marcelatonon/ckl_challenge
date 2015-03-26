//
//  ArticleViewController.h
//  ckl_challenge
//
//  Created by Marcela Tonon on 25/03/15.
//  Copyright (c) 2015 Marcela Tonon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleViewController : UITableViewController <UITableViewDataSource>

@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end
