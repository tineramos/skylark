//
//  DatabaseManager.h
//  Skylark
//
//  Created by Tine Ramos on 10/21/15.
//  Copyright © 2015 Tine Ramos. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Episode.h"
#import "Divider.h"

@interface DatabaseManager : NSObject

+ (instancetype)sharedManager;

- (Episode *)createEpisodeObject;

- (Divider *)createDividerObject;

@end
