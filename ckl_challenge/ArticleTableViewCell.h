//
//  ArticleTableViewCell.h
//  ckl_challenge
//
//  Created by Marcela Tonon on 27/03/15.
//  Copyright (c) 2015 Marcela Tonon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UILabel *cellAuthors;
@property (weak, nonatomic) IBOutlet UILabel *cellWebsite;
@property (weak, nonatomic) IBOutlet UILabel *cellDate;

@end
