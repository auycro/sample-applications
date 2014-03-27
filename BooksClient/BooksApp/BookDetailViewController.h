//
//  BookDetailViewController.h
//  BooksApp
//
//  Created by chandrikagole on 1/18/14.
//  Copyright (c) 2014 strongloop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface BookDetailViewController : UIViewController

// These are feilds connected to the details view controller
@property (nonatomic, strong) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UITextField *authorText;
@property (weak, nonatomic) IBOutlet UITextField *genreText;
@property (weak, nonatomic) IBOutlet UITextField *progressText;
@property (weak, nonatomic) IBOutlet UITextField *totalPagesText;
@property (weak, nonatomic) IBOutlet UITextField *ratingText;
@property (weak, nonatomic) IBOutlet UITextField *descriptionText;
@property (weak, nonatomic) IBOutlet UITextView *reviewText;

// These strings are used to pass data from the main view controller to the detail VC through the push segue
@property (nonatomic, weak) NSString *titleTxt;
@property (nonatomic, weak) NSString *authorTxt;
@property (nonatomic, weak) NSString *genreTxt;
@property (nonatomic, weak) NSString *progressTxt;
@property (nonatomic, weak) NSString *descriptionTxt;
@property (nonatomic, weak) NSString *totalPagesTxt;
@property (nonatomic, weak) NSString *ratingTxt;
@property (nonatomic, weak) NSString *reviewTxt;

@property (nonatomic) NSInteger obj_id;



@end

