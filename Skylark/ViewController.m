//
//  ViewController.m
//  Skylark
//
//  Created by Tine Ramos on 10/18/15.
//  Copyright © 2015 Tine Ramos. All rights reserved.
//

#import "ViewController.h"

#import "DataManager.h"

#import "HomeSectionView.h"
#import "EpisodeTableViewCell.h"

#import "MBProgressHUD.h"
#import "UIColor+CreateMethods.h"

#define kEpisodeCellId  @"episodeCellId"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *tableViewData;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.tableHeaderView = [UIView new];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([EpisodeTableViewCell class])
                                               bundle:nil]
         forCellReuseIdentifier:kEpisodeCellId];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self downloadHomeSet];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)tableViewData
{
    // holds array of section for Home set
    if (!_tableViewData) {
        _tableViewData = [NSArray array];
    }
    return _tableViewData;
}

- (NSArray *)colorSectionArray
{
    return @[@"00C4D0", @"6BDE70"];
}

#pragma mark - Data methods

- (void)downloadHomeSet
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading...";
    
    [[DataManager sharedClient] getHomeSetWithSuccessBlock:^(NSArray *homeArray) {
        self.tableViewData = homeArray;
        [self.tableView reloadData];
        [hud hide:YES afterDelay:0.8f];
    } failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES afterDelay:0.8f];
    }];
}

#pragma mark - UITableView Datasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.tableViewData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Divider *divider = [self.tableViewData objectAtIndex:section];
    return [divider.episode count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EpisodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kEpisodeCellId];
    
    if (!cell) {
        cell = [[EpisodeTableViewCell alloc] init];
    }
    
    Divider *divider = [self.tableViewData objectAtIndex:indexPath.section];
    Episode *episode = (Episode *)[[divider.episode allObjects] objectAtIndex:indexPath.row];
    
    [cell setCellForData:episode];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 155.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HomeSectionView *sectionView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([HomeSectionView class])
                                                                  owner:self
                                                                options:nil]
                                    firstObject];
    
    Divider *divider = [self.tableViewData objectAtIndex:section];
    sectionView.sectionLabel.text = [divider.heading uppercaseString];
    sectionView.colorView.backgroundColor = [UIColor colorWithHex:[[self colorSectionArray] objectAtIndex:section]];
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 55.0f;
}

@end
