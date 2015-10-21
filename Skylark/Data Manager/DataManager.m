//
//  DataManager.m
//  Skylark
//
//  Created by Tine Ramos on 10/21/15.
//  Copyright © 2015 Tine Ramos. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

+ (instancetype)sharedClient
{
    static id shared = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://feature-code-test.skylark-cms.qa.aws.ostmodern.co.uk:8000/"]];
    });
    return shared;
}

- (void)getHomeSetWithSuccessBlock:(void (^)(NSArray *array))successBlock
                      failureBlock:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
{
    [self GET:@"api/sets/" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *objects = [responseObject objectForKey:@"objects"];
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title == %@", @"Home"];
        NSDictionary *homeDictionary = [[objects filteredArrayUsingPredicate:predicate] firstObject];
        
        NSArray *items = [homeDictionary objectForKey:@"items"];
        NSMutableArray *returnArray = [NSMutableArray array];
        
        for (int i = 0; i < [items count]; i++) {
            
            NSDictionary *itemDictionary = [items objectAtIndex:i];
            
            if ([[itemDictionary objectForKey:@"content_type"] isEqualToString:@"divider"]) {
                Divider *divider = [[DatabaseManager sharedManager] createDividerObject];
                [divider populateWithJSON:itemDictionary];
                [returnArray addObject:divider];
                
                for (int j = i+1; j < [items count]; j++) {
                    
                    NSDictionary *episodeDictionary = [items objectAtIndex:j];
                    
                    if ([[episodeDictionary objectForKey:@"content_type"] isEqualToString:@"episode"]) {
                        NSString *contentUrl = [episodeDictionary objectForKey:@"content_url"];
                        
                        [self getEpisodeDetailWithContentUrl:contentUrl successBlock:^(NSDictionary *dictionary) {
                            
                            Episode *episode = [[DatabaseManager sharedManager] createEpisodeObject];
                            [episode populateWithJSON:dictionary];
                            [divider addEpisodeObject:episode];
                            
                            if (j == [items count] - 1) {
                                successBlock(returnArray);
                            }
                            
                        } failureBlock:^(AFHTTPRequestOperation *operation, NSError *error) {
                            failureBlock(operation, error);
                        }];
                    }
                    else {
                        i = j-1;
                        break;
                    }
                    
                }
                
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(operation, error);
    }];
}

- (void)getEpisodeDetailWithContentUrl:(NSString *)contentUrl
                          successBlock:(void (^)(NSDictionary *dictionary))successBlock
                          failureBlock:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
{
    [self GET:contentUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(operation, error);
    }];
}

@end
