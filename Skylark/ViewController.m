//
//  ViewController.m
//  Skylark
//
//  Created by Tine Ramos on 10/18/15.
//  Copyright © 2015 Tine Ramos. All rights reserved.
//

#import "ViewController.h"

#import "DataManager.h"

#import "SectionCollectionReusableView.h"
#import "EpisodeCollectionViewCell.h"

#import "MBProgressHUD.h"

#define kEpisodeCellId  @"episodeCellId"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *collectionViewData;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self downloadHomeSet];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)collectionViewData
{
    // holds array of section for Home set
    if (!_collectionViewData) {
        _collectionViewData = [NSArray array];
    }
    return _collectionViewData;
}

#pragma mark - Data methods

- (void)downloadHomeSet
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.collectionView animated:YES];
    hud.labelText = @"Loading...";
    
    [[DataManager sharedClient] getHomeSetWithSuccessBlock:^(NSArray *homeArray) {
        self.collectionViewData = homeArray;
        [self.collectionView reloadData];
        [hud hide:YES afterDelay:0.8f];
    } failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
        [hud hide:YES afterDelay:0.8f];
    }];
}

#pragma mark - UICollectionView Datasource methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.collectionViewData count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    Divider *divider = [self.collectionViewData objectAtIndex:section];
    return [divider.episode count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EpisodeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kEpisodeCellId forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[EpisodeCollectionViewCell alloc] init];
    }
    
    Divider *divider = [self.collectionViewData objectAtIndex:indexPath.section];
    [cell setCellForData:(Episode *)[[divider.episode allObjects] objectAtIndex:indexPath.row]];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        SectionCollectionReusableView *sectionView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                        withReuseIdentifier:NSStringFromClass([SectionCollectionReusableView class])
                                                                                               forIndexPath:indexPath];
        
        Divider *divider = [self.collectionViewData objectAtIndex:indexPath.section];
        sectionView.sectionLabel.text = divider.heading;
    }
    
    return nil;
}

@end
