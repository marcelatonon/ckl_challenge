//
//  ArticleViewController.m
//  ckl_challenge
//
//  Created by Marcela Tonon on 25/03/15.
//  Copyright (c) 2015 Marcela Tonon. All rights reserved.
//

#import <RestKit/RestKit.h>
#import "ArticleViewController.h"
#import "Article.h"
#import "ContentViewController.h"
#import "ArticleTableViewCell.h"

@interface ArticleViewController ()

@property (nonatomic)  NSArray *articles;

@end

@implementation ArticleViewController

@synthesize articles = _articles;

- (void) getArticles {
    //requesting the articles from URL
    [[RKObjectManager sharedManager] getObjectsAtPath:@"" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        self.articles = mappingResult.array;
        //loading the tableview with the articles
        [self.tableView reloadData];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Failed with error: %@", [error localizedDescription]);
    }];
}

#pragma mark - Action methods

- (void) sortArticlesBy:(NSString *)keypath {
    //creating a Sort Descriptor to sort the articles by a chosen keypath
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:keypath ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [self.articles sortedArrayUsingDescriptors:sortDescriptors];
    self.articles = sortedArray;
    [self.tableView reloadData];
}

- (IBAction)sortArticlesClick:(UIBarButtonItem *)sender {
    //creating an ActionSheet to show Sort options
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:@"Sort By" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *sortByTitle = [UIAlertAction actionWithTitle:@"Title" style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action) {[self sortArticlesBy:@"title"];}];
    UIAlertAction *sortByAuthors = [UIAlertAction actionWithTitle:@"Authors" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {[self sortArticlesBy:@"authors"];}];
    UIAlertAction *sortByWebsite = [UIAlertAction actionWithTitle:@"Website" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {[self sortArticlesBy:@"website"];}];
    UIAlertAction *sortByDate = [UIAlertAction actionWithTitle:@"Date" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {[self sortArticlesBy:@"date"];}];
    
    [actionSheet addAction:sortByTitle];
    [actionSheet addAction:sortByAuthors];
    [actionSheet addAction:sortByWebsite];
    [actionSheet addAction:sortByDate];

    //needed when the device is an iPad: to open a Popover
    actionSheet.popoverPresentationController.barButtonItem = sender;
    actionSheet.popoverPresentationController.sourceView = self.view;
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}

#pragma mark - UIView methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Articles";
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:    NSForegroundColorAttributeName]; //changing title color
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.455 green:0.01 blue:0.02 alpha:1]; //background color
    self.navigationController.navigationBar.tintColor = [UIColor blackColor]; //barItem font color
    
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self getArticles];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableView methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"newArticle";
    ArticleTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell = [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (ArticleTableViewCell *)configureCell:(ArticleTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    //configuring each cell of the tableview
    Article *article = [self.articles objectAtIndex:indexPath.row];
    cell.cellTitle.text = article.title ? article.title : @"";
    cell.cellAuthors.text = article.authors ? article.authors : @"";
    cell.cellWebsite.text = article.website ? article.website : @"";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    cell.cellDate.text = article.date ? [dateFormatter stringFromDate:article.date] : @"";
    if(article.read){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static ArticleTableViewCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    //configuring an auxiliar cell to discover the dimensions of the cell and resizing it on the screen
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:@"newArticle"];
    });
    sizingCell = [self configureCell:sizingCell atIndexPath:indexPath];
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1.0f + 20.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articles.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Article *article = [self.articles objectAtIndex:indexPath.row];
    article.read = YES;
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"contentSegue"]) {
        //open the content of the selected article
        ContentViewController *detailViewController = [segue destinationViewController];
        NSInteger indexArticle = [[self.tableView indexPathForSelectedRow] row];
        detailViewController.article = [self.articles objectAtIndex:indexArticle];
    }
}


@end
