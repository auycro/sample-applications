//
//  ViewController.m
//  ModelsApp1
//
//  Created by chandrikagole on 1/14/14.
//  Copyright (c) 2014 strongloop. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "BookDetailViewController.h"
#define prototypeName @"books"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property (strong, nonatomic) NSArray *tableData;
@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@end

@implementation ViewController {
    NSArray *books;
}


@synthesize tableView;
@synthesize myTextField;
//unwind seque 
- (IBAction)unwindToList:(UIStoryboardSegue *)segue
{
    
}


// To pass data through seque into the detailed view controller
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showBookDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        BookDetailViewController *destViewController = segue.destinationViewController;
        LBModel *model = (LBModel *)[self.tableData objectAtIndex:indexPath.row];
        destViewController.obj_id = indexPath.row;
        NSLog(@"eeeeee%d", indexPath.row);
        destViewController.titleTxt=[model objectForKeyedSubscript:@"title"];
        destViewController.authorTxt=[model objectForKeyedSubscript:@"author"];
        destViewController.progressTxt=[model objectForKeyedSubscript:@"progress"];
        destViewController.descriptionTxt=[model objectForKeyedSubscript:@"description"];
        destViewController.genreTxt=[model objectForKeyedSubscript:@"genre"];
        destViewController.totalPagesTxt=[model objectForKeyedSubscript:@"totalPages"];
        destViewController.ratingTxt=[model objectForKeyedSubscript:@"rating"];
        destViewController.reviewTxt=[model objectForKeyedSubscript:@"review"];
    }
    
    //NSLog(@"vsfwrw%@",sender);
//    if (sender != self.saveButton) {
//        NSLog(@"error");
//    }
//    else {
//        NSLog(@"correct");
//        UIAlertView *messageAlert = [[UIAlertView alloc]initWithTitle:@"Missing Book Title!" message:@"You have to enter a book title." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [messageAlert show];
//    }

    
    
}


/*
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 //1
 PhoneRecordDetailViewController* detailController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewControllerIdentifier"];
 //  3
 detailController.selectedRecord = [self.fetchedRecordsArray objectAtIndex:indexPath.row];
 //2
 [self.navigationController pushViewController:detailController animated:YES];
 }
 
 */

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    BookDetailViewController* detailController = [self.storyboard instantiateViewControllerWithIdentifier:@"BookDetailViewControllerIdentifier"];
//    
//    [self.navigationController pushViewController:detailController animated:YES];
//}




// To delete a row
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    void (^findErrorBlock)(NSError *) = ^(NSError *error)
    {
        NSLog( @"Error No model found with ID %@", error.description);
    };
    
    void (^findSuccessBlock)(LBModel *) = ^(LBModel *model){
        void (^removeErrorBlock)(NSError *) = ^(NSError *error){
            NSLog(@"Error on save %@", error.description);
        };
        void (^removeSuccessBlock)() = ^(){
            NSLog(@"Success with deletion");
            [self getBooks];
        };
        [model destroyWithSuccess:removeSuccessBlock failure:removeErrorBlock];
        
    };
    
    
    LBModelRepository *bug = [[AppDelegate adapter] repositoryWithModelName:prototypeName];
 
    [bug findById:[NSNumber numberWithInteger:indexPath.row+1] success:findSuccessBlock failure:findErrorBlock];

}




// To select a row and get an alert that you have selected the book. This isnt necessary. Just to learn how to enable alerts
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *selectedRowInfo = @"You've selected a book : ";
    if (  [ [[self.tableData objectAtIndex:indexPath.row] class] isSubclassOfClass:[LBModel class]])
    {
        LBModel *model = (LBModel *)[self.tableData objectAtIndex:indexPath.row];
        selectedRowInfo = [selectedRowInfo stringByAppendingString:[model objectForKeyedSubscript:@"title"]];
        UIAlertView *messageAlert = [[UIAlertView alloc]initWithTitle:@"Row Selected" message:selectedRowInfo delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [messageAlert show];
        // To select and leave a check mark
        UITableViewCell *cell1 = [tableView cellForRowAtIndexPath:indexPath];
        cell1.accessoryType = UITableViewCellAccessoryCheckmark;
        //
    }
}
*/

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableData count];
}

// To display data in the table.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"BookCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    if (  [ [[self.tableData objectAtIndex:indexPath.row] class] isSubclassOfClass:[LBModel class]])
    {
        LBModel *model = (LBModel *)[self.tableData objectAtIndex:indexPath.row];
        cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@ by %@",
                               [model objectForKeyedSubscript:@"title"], [model objectForKeyedSubscript:@"author"]];
//        cell.imageView.image = [UIImage imageNamed:@"button.png"];
    }
    return cell;
}
//

- (NSArray *) tableData
{
    if (!_tableData)_tableData = [[NSArray alloc] init];
    return _tableData;
}
- (void) getBooks
{
    // Error block
    void (^loadErrorBlock)(NSError *) = ^(NSError *error){
        NSLog(@"Error on load %@", error.description);
    };
    // Success block
    void (^loadSuccessblock)(NSArray *) = ^(NSArray *models){
        //NSLog(@"Success books %@", models);
        NSLog(@"Success count %d", models.count);
        self.tableData = models;
        [self.myTable reloadData];
    };
    
    LBModelRepository *allbooks = [[AppDelegate adapter] repositoryWithModelName:prototypeName]; // This line gets the Loopback model "book" through the apapter defined in AppDelegate
    [allbooks allWithSuccess:loadSuccessblock failure:loadErrorBlock]; // Logical line 1. Get allbooks. If connection to server fails load the failure block, if it passes, call the success bloack and pass allbooks to it.
};


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getBooks];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor brownColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)actionGetBooks:(id)sender {
    [self getBooks];
    
}
- (IBAction)actionRateBooks:(id)sender {
}
- (IBAction)actionAddBook:(id)sender {
}
- (IBAction)getAppInfo:(id)sender {
    UIAlertView *getAppInfo = [[UIAlertView alloc]
                                    initWithTitle:@"Books Rating App" message:@"Keep a collection of books you read and rate them on a scale of 1 to 10!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    // Display the Hello World Message
    [getAppInfo show];
}

@end
