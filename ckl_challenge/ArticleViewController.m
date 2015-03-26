//
//  ArticleViewController.m
//  ckl_challenge
//
//  Created by Marcela Tonon on 25/03/15.
//  Copyright (c) 2015 Marcela Tonon. All rights reserved.
//

#import "ArticleViewController.h"
#import "Article.h"
#import "ContentViewController.h"
#import <RestKit/RestKit.h>

@interface ArticleViewController ()

@property (nonatomic)  NSArray *articles;

@end

@implementation ArticleViewController

@synthesize articles = _articles;

- (void) getArticles {
    //requesting the articles from URL
    [[RKObjectManager sharedManager] getObjectsAtPath:@"" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        self.articles = mappingResult.array;
        [self.tableView reloadData];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Failed with error: %@", [error localizedDescription]);
    }];
}

#pragma mark - UIView methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Articles";
    [self getArticles];
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableView methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Article *article = [self.articles objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"newArticle";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = article.title;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articles.count;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"selecionou linha %ld", (long)indexPath.row);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"entreou");
    if ([[segue identifier] isEqualToString:@"contentSegue"]) {
        ContentViewController *detailViewController = [segue destinationViewController];
        NSInteger indexArticle = [[self.tableView indexPathForSelectedRow] row];
        detailViewController.article = [self.articles objectAtIndex:indexArticle];
    }
}


@end
