//
//  SwitchCell.h
//  Yelp
//
//  Created by Sumeet Ungratwar on 10/26/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwitchCell;

@protocol SwitchCellDelegate <NSObject>

- (void)switchCell:(SwitchCell *)cell didUpdateValue:(BOOL)value;

@end
@interface SwitchCell : UITableViewCell

@property (nonatomic, assign) BOOL on;
@property (weak, nonatomic) IBOutlet UILabel *filterLabel;
@property (nonatomic, weak) id<SwitchCellDelegate> delegate;

@end
