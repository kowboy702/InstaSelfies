//
//  apiWEB.m
//  insta_selfies
//
//  Created by Mac on 7/17/15.
//  Copyright (c) 2015 Jenson. All rights reserved.
//

#import "apiWEB.h"

@implementation apiWEB

-(void) performRequestWithURL:(NSURL *)url{
    
    //  save the reference to this object for thread access
    
    __weak apiWEB* thisWebService = self;
    
    dispatch_queue_t queue = dispatch_queue_create("web service", nil);
    
    dispatch_async(queue, ^{
        NSError *webError;
        NSURLResponse *webResponse;
        
        NSURLRequest *webRequest = [[NSURLRequest alloc] initWithURL:url];
        NSData *webResponseData = [NSURLConnection sendSynchronousRequest:webRequest returningResponse:&webResponse error:&webError];
        
        if (!webError){
            if ([thisWebService.webDelegate respondsToSelector:@selector(webCompletedWithData:)]){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [thisWebService.webDelegate webCompletedWithData:webResponseData];
                });
            }
            //  Log the error
            else {
                NSLog(@"%@", @"Could not find a completion handler for web service");
            }
        }
        else {
            if ([thisWebService.webDelegate respondsToSelector:@selector(webCompletedWithError:)]){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [thisWebService.webDelegate webCompletedWithError:webError];
                });
            }
            //  Log unavailable error
            else {
                NSLog(@"%@", @"Could not find error handler for web service on given delegate");
            }
        }
    });
}

@end
