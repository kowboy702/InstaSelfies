//
//  ViewController.h
//  insta_selfies
//
//  Created by Mac on 7/17/15.
//  Copyright (c) 2015 Jenson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Selfie.h"
#import "apiJSON.h"
#import "apiWEB.h"

@interface ViewController : UIViewController <apiJSON_Delegate, apiWEB_Delegate,UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>


@end

