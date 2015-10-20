//
//  EpisodeTableViewCell.h
//  Skylark
//
//  Created by Tine Ramos on 10/20/15.
//  Copyright © 2015 Tine Ramos. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Episode.h"

@interface EpisodeTableViewCell : UITableViewCell

- (void)setCellForData:(Episode *)episode;

@end
