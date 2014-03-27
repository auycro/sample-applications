//
//  SimpleTableCell.h
//  BooksApp
//
//  Created by chandrikagole on 1/15/14.
//  Copyright (c) 2014 strongloop. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleTableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *prepTimeLabel;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;


@end
