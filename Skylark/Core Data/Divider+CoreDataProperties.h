//
//  Divider+CoreDataProperties.h
//  Skylark
//
//  Created by Tine Ramos on 10/20/15.
//  Copyright © 2015 Tine Ramos. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Divider.h"

NS_ASSUME_NONNULL_BEGIN

@interface Divider (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *heading;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *episode;

@end

@interface Divider (CoreDataGeneratedAccessors)

- (void)addEpisodeObject:(NSManagedObject *)value;
- (void)removeEpisodeObject:(NSManagedObject *)value;
- (void)addEpisode:(NSSet<NSManagedObject *> *)values;
- (void)removeEpisode:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
