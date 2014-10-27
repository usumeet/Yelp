//
//  BusinessCell.h
//  Yelp
//
//  Created by Sumeet Ungratwar on 10/26/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Business.h"

@interface BusinessCell : UITableViewCell

@property (nonatomic, strong) Business *business;

-(void)setBusiness:(Business *)business;

@end
