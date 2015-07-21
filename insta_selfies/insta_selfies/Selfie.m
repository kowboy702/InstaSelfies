//
//  Selfie.m
//  insta_selfies
//
//  Created by Mac on 7/17/15.
//  Copyright (c) 2015 Jenson. All rights reserved.
//

#import "Selfie.h"

@implementation Selfie

-(void) handleImageStrings{
    NSMutableArray * images = [NSMutableArray new];
    [images addObject:[(NSDictionary*)[self.images objectForKey:@"thumbnail"] objectForKey:@"url"]];
    [images addObject:[(NSDictionary*)[self.images objectForKey:@"low_resolution"] objectForKey:@"url"]];
    [images addObject:[(NSDictionary*)[self.images objectForKey:@"standard_resolution"] objectForKey:@"url"]];
    self.strURLThumb = images[0];
    self.strURLLowRes = images[1];
    self.strURLStdRes = images[2];
}

@end
