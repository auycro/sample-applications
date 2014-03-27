//
//  AddNewBook.m
//  BooksApp
//
//  Created by chandrikagole on 1/17/14.
//  Copyright (c) 2014 strongloop. All rights reserved.
//

#import "AddNewBook.h"
#import "ViewController.h"
#define prototypeName @"books"


@interface AddNewBook ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *authorField;
@property (weak, nonatomic) IBOutlet UITextField *genreField;
@property (weak, nonatomic) IBOutlet UITextField *noOfPagesField;
@property (weak, nonatomic) IBOutlet UITextField *progressField;
@property (weak, nonatomic) IBOutlet UITextField *ratingField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionField;
@end

@implementation AddNewBook

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    void (^saveNewErrorBlock)(NSError *) = ^(NSError *error){
        NSLog(@"Error on save %@", error.description);
    };
    
    void (^saveNewSuccessBlock)() = ^(){
        UIAlertView *messageAlert = [[UIAlertView alloc]initWithTitle:@"Successfull!" message:@"You have add a new book" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [messageAlert show];
    };

    if (sender != self.doneButton) return;
    if (self.titleField.text.length > 0) {
        NSLog(@"%@",self.titleField.text);
        LBModelRepository *newBook = [[AppDelegate adapter] repositoryWithModelName:prototypeName];
        //create new LBModel of type
        LBModel *model = [newBook modelWithDictionary:@{
                        @"title"        : self.titleField.text,
                        @"author"       : self.authorField.text,
                        @"genre"        : self.genreField.text,
                        @"totalPages"   : self.noOfPagesField.text,
                        @"progress"     : self.progressField.text,
                        @"description"  : self.descriptionField.text,
                        @"rating"       : self.ratingField.text
                        }];
        [model saveWithSuccess:saveNewSuccessBlock failure:saveNewErrorBlock];

        
    }
    else {
        UIAlertView *messageAlert = [[UIAlertView alloc]initWithTitle:@"Missing Book Title!" message:@"You have to enter a book title." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
    //Other setup
    self.view.backgroundColor = [UIColor brownColor];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
