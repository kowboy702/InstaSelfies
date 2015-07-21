//
//  apiJSON.m
//  insta_selfies
//
//  Created by Mac on 7/17/15.
//  Copyright (c) 2015 Jenson. All rights reserved.
//

#import "apiJSON.h"
#import "Selfie.h"

@implementation apiJSON

//  Perform JSON parsing with the data recieved

-(void) parseDataWith:(NSData*)data{
    
    //  Save self as weak variable to allow for thread referencing
    
    __weak apiJSON* thisParser = self;
    
    dispatch_queue_t queue = dispatch_queue_create("parser queue", nil);
    
    dispatch_async(queue, ^{
        NSMutableArray *results = [NSMutableArray new];
        NSURL *nextURL;
        
        NSError *parseError;
        
        //  Convert the data to a dictionary of properties
        
        NSDictionary *selfieDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parseError];
        
        if (!parseError){
            //  Collect actual selfie data
            
            NSArray *jsonData = [selfieDict objectForKey:@"data"];
            
            if (jsonData){
                for (NSDictionary *cSelfie in jsonData){
                    
                    // Image selfies have 14 parameters, thus we want to skip anything which has
                    //  less than that
                    
                    if ([cSelfie count] < 14) continue;
                    
                    //  This is a successful api image object, we can parse to selfie
                    //  object without dictionary/compile time error
                    
                    Selfie *newSelfie = [Selfie new];
                    [newSelfie setValuesForKeysWithDictionary:cSelfie];
                    [newSelfie handleImageStrings];   // Retrieve image string urls from dictionary
                    
                    //  add to final result
                    
                    [results addObject:newSelfie];
                }
                
                nextURL = [NSURL URLWithString:[[selfieDict objectForKey:@"pagination"] objectForKey:@"next_url"]];
            }
            else jsonData = @[];
            
            if ([thisParser.parserDelegate respondsToSelector:@selector(objectProcessComplete:withNextURL:)]){
                
                //  continue on the main thread for proper UI update
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [thisParser.parserDelegate objectProcessComplete:results withNextURL:nextURL];
                });
            }
            else {
                // log unavailable delegate function
                
                NSLog(@"%@",@"Completion procedure unavailable in the given delegate.");
            }
        }
        //  Handle erroneous API returns or parses
        else {
            if ([thisParser.parserDelegate respondsToSelector:@selector(objectProcessFailed:)]){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [thisParser.parserDelegate objectProcessFailed:parseError];
                });
            }
            else {
                NSLog(@"%@", @"Error handle procedure unavailable in the given delegate.");
            }
        }
    });
}

@end
