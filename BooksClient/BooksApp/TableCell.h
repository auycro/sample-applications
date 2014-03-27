//
//  TableCell.h
//  BooksApp
//
//  Created by chandrikagole on 1/15/14.
//  Copyright (c) 2014 strongloop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *authorLabel;
@property (nonatomic, weak) IBOutlet UILabel *ratingLabel;


@end
