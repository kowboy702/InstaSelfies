//
//  ViewController.m
//  insta_selfies
//
//  Created by Mac on 7/17/15.
//  Copyright (c) 2015 Jenson. All rights reserved.
//

#import "ViewController.h"

NSString * instaAPI = @"https://api.instagram.com/v1/tags/selfie/media/recent?client_id=73cc15dd595d4cf3b11f27bb628cd14e";

@interface ViewController ()

@property (strong, nonatomic) NSArray *selfieCollection;
@property (strong, nonatomic) apiWEB *webService;
@property (strong, nonatomic) apiJSON *jsonParser;
@property (strong, nonatomic) NSURL *currentURL;
@property (strong, nonatomic) dispatch_queue_t queue;
@property (weak, nonatomic) IBOutlet UICollectionView *mainCollectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  Create service objects
    
    self.webService = [apiWEB new];
    self.jsonParser = [apiJSON new];
    self.selfieCollection = [NSArray new];
    self.currentURL = [NSURL URLWithString:instaAPI];
    
    self.queue = dispatch_queue_create("images loader", nil);
    
    //  Init service items
    
    [self.webService setWebDelegate:self];
    [self.jsonParser setParserDelegate:self];
    
    [self.webService performRequestWithURL:self.currentURL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.selfieCollection count];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //  Sizes of selfies occur in three's. The first takes the entire width of the display
    //  the next 2 each take half of the width, thus completing a full row.
    //  Each selfie should also be a square, thus having the same height and width
    
    float width = 0;
    if (indexPath.row % 3 == 0){
        width = self.view.frame.size.width;
    }
    else {
        width = (self.view.frame.size.width / 2.0) -10; // there is 10 pixels between small images
    }
    
    return CGSizeMake(width, width);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseID = @"selfieCell";
    
    //  Allow for thread access to the cell, as well as the selfie object
    __block UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    
    __weak Selfie *currentSelfie = [self.selfieCollection objectAtIndex:indexPath.row];
    
    //
    //  Here we will load the image dynamically
    //  If the image object is populated, we will use it, if it is not we will
    //  use the stored low res url to retrieve the image
    //  Image is loaded asynchronously to allow for smooth loading
    //
    
    if (currentSelfie.imgLowRes) {
        
        //  Load the saved (cached) image
        
        UIImageView *imgVw = [[UIImageView alloc] initWithImage:currentSelfie.imgLowRes];
        [cell setBackgroundView:imgVw];
    }
    else {
        cell.alpha = 0.0f;
        
        //  Download and fade the desired image
        
        dispatch_after(0, self.queue, ^{
            [currentSelfie setImgLowRes:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:currentSelfie.strURLLowRes]]]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [cell setBackgroundView:[[UIImageView alloc]initWithImage:currentSelfie.imgLowRes]];
                [UIView animateWithDuration:0.4 animations:^{
                    cell.alpha = 1.0f;
                }];
            });
        });
    }
    
    //
    //  If we loaded the last image in the list, this means we are at the last image in the list
    //  Hence, we will go to the provided stride URL and retrieve a new set of images to add to the
    //  current collection of selfish. This creates an infinite scroll effect
    //
    
    if (indexPath.row == self.selfieCollection.count-1){
        [self.webService performRequestWithURL:self.currentURL];
    }
    
    return cell;
}

//  Handle the data returned by the web call
-(void) webCompletedWithData:(NSData *)data {
    [self.jsonParser parseDataWith:data];
}

//  simply nslog an error for debugging purposes
-(void) webCompletedWithError:(NSError *) error{
    NSLog(@"%@", error);
}

//  Handle successful parsing of selfies from json
-(void) objectProcessComplete:(NSMutableArray *)processedObjects withNextURL:(NSURL *)nextURL {
    self.currentURL = nextURL;

    self.selfieCollection = [self.selfieCollection arrayByAddingObjectsFromArray:[processedObjects copy]];
    
    [self.mainCollectionView reloadData];
}

//  simply nslog an error for debugging purposes
-(void) objectProcessFailed:(NSError *)processingError{
    NSLog(@"%@", processingError);
}

@end
