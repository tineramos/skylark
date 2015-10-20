//
//  EpisodeDetailViewController.m
//  Skylark
//
//  Created by Tine Ramos on 10/20/15.
//  Copyright © 2015 Tine Ramos. All rights reserved.
//

#import "EpisodeDetailViewController.h"

#import "UIColor+CreateMethods.h"

@interface EpisodeDetailViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *posterImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, weak) IBOutlet UIButton *watchNowButton;

@end

@implementation EpisodeDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleLabel.text = [self.episode.title uppercaseString];
    
    self.containerView.alpha = 0.0f;
    self.watchNowButton.alpha = 0.0f;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self performSelector:@selector(animateDetailView) withObject:nil afterDelay:1.5f];
}

- (void)animateDetailView
{
    [UIView animateWithDuration:2.0f animations:^{
        self.containerView.alpha = 0.8f;
        self.watchNowButton.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
