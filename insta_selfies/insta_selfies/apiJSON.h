//
//  apiJSON.h
//  insta_selfies
//
//  Created by Mac on 7/17/15.
//  Copyright (c) 2015 Jenson. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol apiJSON_Delegate <NSObject>

-(void) objectProcessComplete:(NSMutableArray*)processedObjects withNextURL:(NSURL*)nextURL;
-(void) objectProcessFailed:(NSError*)processingError;

@end

@interface apiJSON : NSObject

@property (weak, nonatomic) id parserDelegate;

-(void) parseDataWith:(NSData*)data;

@end
