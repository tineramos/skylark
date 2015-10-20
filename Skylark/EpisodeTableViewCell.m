//
//  EpisodeTableViewCell.m
//  Skylark
//
//  Created by Tine Ramos on 10/20/15.
//  Copyright © 2015 Tine Ramos. All rights reserved.
//

#import "EpisodeTableViewCell.h"

@interface EpisodeTableViewCell ()

@property (nonatomic, strong) IBOutlet UIImageView *videoThumbnail;
@property (nonatomic, strong) IBOutlet UILabel *videoTitle;

@end

@implementation EpisodeTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellForData:(Episode *)episode
{
    self.videoTitle.text = episode.title;
}

@end
