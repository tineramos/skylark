//
//  DatabaseManager.m
//  Skylark
//
//  Created by Tine Ramos on 10/21/15.
//  Copyright © 2015 Tine Ramos. All rights reserved.
//

#import "DatabaseManager.h"

#import "AppDelegate.h"

@interface DatabaseManager ()

@property (assign) NSManagedObjectContext *managedObjectContext;
@property (assign) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation DatabaseManager

+ (instancetype)sharedManager
{
    static id shared = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (id)init
{
    self = [super init];
    if (self) {
        _managedObjectContext = ((AppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
        [_managedObjectContext setUndoManager:nil];
    }
    return self;
}

- (Episode *)createEpisodeObject
{
    return [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Episode class]) inManagedObjectContext:self.managedObjectContext];
}

- (Divider *)createDividerObject
{
    return [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Divider class]) inManagedObjectContext:self.managedObjectContext];
}

@end
