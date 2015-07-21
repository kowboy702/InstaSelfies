//
//  apiWEB.h
//  insta_selfies
//
//  Created by Mac on 7/17/15.
//  Copyright (c) 2015 Jenson. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol apiWEB_Delegate <NSObject>

-(void) webCompletedWithData:(NSData*)data;
-(void) webCompletedWithError:(NSError*)error;

@end

@interface apiWEB : NSObject

@property (weak, nonatomic) id webDelegate;

-(void) performRequestWithURL:(NSURL*)url;

@end
