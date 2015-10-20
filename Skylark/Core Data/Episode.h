//
//  Episode.h
//  Skylark
//
//  Created by Tine Ramos on 10/20/15.
//  Copyright © 2015 Tine Ramos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Divider;

NS_ASSUME_NONNULL_BEGIN

@interface Episode : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

- (void)populateWithJSON:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END

#import "Episode+CoreDataProperties.h"
