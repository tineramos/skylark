//
//  Episode.m
//  Skylark
//
//  Created by Tine Ramos on 10/20/15.
//  Copyright © 2015 Tine Ramos. All rights reserved.
//

#import "Episode.h"
#import "Divider.h"

@implementation Episode

// Insert code here to add functionality to your managed object subclass

- (void)populateWithJSON:(NSDictionary *)dictionary
{
    for (NSString *key in dictionary) {
        
        if (![self respondsToSelector:NSSelectorFromString(key)] ||  [key isEqualToString:@"self"]) {
            continue;
        }
        
        id value = [dictionary objectForKey:key];
        
        [self setValue:value forKey:key];
    }
}

@end
