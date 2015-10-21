//
//  DataManager.h
//  Skylark
//
//  Created by Tine Ramos on 10/21/15.
//  Copyright © 2015 Tine Ramos. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

#import "DatabaseManager.h"

@interface DataManager : AFHTTPRequestOperationManager

+ (instancetype)sharedClient;

- (void)getHomeSetWithSuccessBlock:(void (^)(NSArray *array))successBlock
                      failureBlock:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;

@end
