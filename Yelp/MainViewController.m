//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "YelpClient.h"
#import "Business.h"
#import "BusinessCell.h"
#import "FilterViewController.h"

NSString * const kYelpConsumerKey = @"yAHmcBbMAeAmKTXRjSznjg";
NSString * const kYelpConsumerSecret = @"nwAprwl3XPDVJ4M7-pxbL-5M4Bw";
NSString * const kYelpToken = @"nD3JqRJ1mOisr52xDBjGNlaKEPHq4y5W";
NSString * const kYelpTokenSecret = @"3sBzECy6bdg4qyty8S7o-sIeeSQ";

@interface MainViewController () <FilterViewControllerDelegate, UISearchBarDelegate>

@property (nonatomic, strong) YelpClient *client;
@property (nonatomic, strong) NSArray *businesses;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)onTap:(id)sender;

@property (nonatomic, strong) NSDictionary *filters;
@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation MainViewController

- (void)fetchRestaurantsWithQuery:(NSString *)query params:(NSDictionary *)params {
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    
    [self.client searchWithTerm:query params:params success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"got response from Yelp");
        NSArray *businessDictionaries = response[@"businesses"];
        self.businesses = [Business businessesWithDictionaries:businessDictionaries];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.filters = [NSDictionary dictionary];
        [self fetchRestaurantsWithQuery:@"Restaurants" params:self.filters];
        self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 290, 44.0)];
        //[self.searchBar sizeToFit];
        // UIView *barWrapper = [[UIView alloc]initWithFrame:self.searchBar.bounds];
        // [barWrapper addSubview:self.searchBar];
        
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.businesses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCell" forIndexPath:indexPath];
    cell.business = self.businesses[indexPath.row];
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Yelp";
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil] forCellReuseIdentifier:@"BusinessCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.searchBar.delegate = self;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(onFilterButton)];
    self.navigationItem.titleView = self.searchBar;
}

#pragma mark - Private methods

- (void)onFilterButton {
    FilterViewController *vc = [[FilterViewController alloc] init];
    vc.delegate = self;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
}

#pragma mark - FilterViewControler delegate methods

- (void)filterViewController:(FilterViewController *)filterViewController didChangeFilters:(NSDictionary *)filters {
    NSLog(@"Received a filter event notification %@", filters);
    self.filters = filters;
    NSString *searchText = self.searchBar.text;
    if ([searchText  isEqual: @""]) {
        searchText = @"Restaurants";
    }
    [self fetchRestaurantsWithQuery:searchText params:self.filters];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    NSLog(@"onTap being called");
    [self.searchBar resignFirstResponder];
    [self.view endEditing:YES];
}

#pragma mark - UISearch Bar Delegate methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText  isEqual: @""]) {
        searchText = @"Restaurants";
    }
    [self fetchRestaurantsWithQuery:searchText params:self.filters];
}

@end
