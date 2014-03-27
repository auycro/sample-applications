//
//  BookDetailViewController.m
//  BooksApp
//
//  Created by chandrikagole on 1/18/14.
//  Copyright (c) 2014 strongloop. All rights reserved.
//

#import "BookDetailViewController.h"
#import <UIKit/UIKit.h>
#define prototypeName @"books"

@interface BookDetailViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@end



@implementation BookDetailViewController

@synthesize titleText;
@synthesize authorText;
@synthesize genreText;
@synthesize progressText;
@synthesize totalPagesText;
@synthesize ratingText;
@synthesize descriptionText;
@synthesize reviewText;

// These strings are used to pass data from the main view controller to the detail VC through the segue
@synthesize titleTxt;
@synthesize authorTxt;
@synthesize genreTxt;
@synthesize progressTxt;
@synthesize totalPagesTxt;
@synthesize ratingTxt;
@synthesize descriptionTxt;
@synthesize reviewTxt;

@synthesize  obj_id;

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{    void (^findErrorBlock)(NSError *) = ^(NSError *error) {
    NSLog( @"Error No model found with ID %@", error.description);
};
    
 
    
    if (sender != self.saveButton) return;
    if (self.titleText.text.length > 0) {
        // Define your success functional block
        void (^findSuccessBlock)(LBModel *) = ^(LBModel *model) {
            //dynamically add an 'inventory' variable to this model type before saving it to the server
            model[@"title"] = self.titleText.text;
            model[@"author"] = self.authorText.text;
            model[@"genre"] = self.genreText.text;
            model[@"totalPages"] = self.totalPagesText.text;
            model[@"description"] = self.descriptionText.text;
            model[@"rating"] = self.ratingText.text;
            model[@"progress"] = self.progressText.text;
            model[@"review"] = self.reviewText.text;
            
            //Define the save error block
            void (^saveErrorBlock)(NSError *) = ^(NSError *error) {
                NSLog( @"Error on Save %@", error.description);
            };
            void (^saveSuccessBlock)() = ^() {
                NSLog( @"Success on updateExistingModel ");
                // call a 'local' refresh to update the tableView
                UIAlertView *messageAlert = [[UIAlertView alloc]initWithTitle:@"Successfully updated!" message:@"You review has been saved." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [messageAlert show];
            };
            [model saveWithSuccess:saveSuccessBlock failure:saveErrorBlock];
        };
    
        
        
        LBModelRepository *prototype = [[AppDelegate adapter] repositoryWithModelName:prototypeName];
        
        //Get the instance of the model with ID = 2
        // Equivalent http JSON endpoint request : http://localhost:3000/api/products/2
         ;
        
        [prototype findById:[NSNumber numberWithInt:self.obj_id+1] success:findSuccessBlock failure:findErrorBlock ];
    }
    else {
        UIAlertView *messageAlert = [[UIAlertView alloc]initWithTitle:@"Missing Book Title!" message:@"Cannot save a book without a title" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [messageAlert show];
    }

}







- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleText.text = titleTxt;
    self.authorText.text = authorTxt;
    self.genreText.text = genreTxt;
    self.progressText.text = progressTxt;
    self.descriptionText.text = descriptionTxt;
    self.totalPagesText.text = totalPagesTxt;
    self.ratingText.text = ratingTxt;
    self.reviewText.text = reviewTxt;
    //Other setup
    self.view.backgroundColor = [UIColor brownColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

@end
