//
//  EpisodeCollectionViewCell.m
//  Skylark
//
//  Created by Tine Ramos on 10/20/15.
//  Copyright © 2015 Tine Ramos. All rights reserved.
//

#import "EpisodeCollectionViewCell.h"

@interface EpisodeCollectionViewCell ()

@property (nonatomic, strong) IBOutlet UIImageView *videoThumbnail;
@property (nonatomic, strong) IBOutlet UILabel *videoTitle;

@end

@implementation EpisodeCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCellForData:(Episode *)episode
{
    self.videoTitle.text = episode.title;
}

@end
