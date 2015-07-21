//
//  Selfie.h
//  insta_selfies
//
//  Created by Mac on 7/17/15.
//  Copyright (c) 2015 Jenson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//
//  This object represents an instance of an item returned by
//  the instagram API. Named selfie here based on use.
//  The names are carefully crafted to match that of the properties
//  returned from the API.
//  Thus, that wiill enable a one-to-one relationship with the dictionary
//  to properties function
//

@interface Selfie : NSObject

@property (strong, nonatomic) NSString *strURLThumb;
@property (strong, nonatomic) NSString *strURLLowRes;
@property (strong, nonatomic) NSString *strURLStdRes;
@property (strong, nonatomic) UIImage *imgThumb;
@property (strong, nonatomic) UIImage *imgLowRes;
@property (strong, nonatomic) UIImage *imgStdRes;

@property (strong, nonatomic) NSString *attribution;
@property (strong, nonatomic) NSArray *tags;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSDictionary *comments;
@property (strong, nonatomic) NSString *filter;
@property (strong, nonatomic) NSString *created_time;
@property (strong, nonatomic) NSString *link;
@property (strong, nonatomic) NSDictionary *likes;
@property (strong, nonatomic) NSDictionary *images;
@property (strong, nonatomic) NSDictionary *videos;
@property (strong, nonatomic) NSArray *users_in_photo;
@property (strong, nonatomic) NSDictionary *caption;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSDictionary *user;

-(void) handleImageStrings;

@end
