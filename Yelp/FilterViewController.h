//
//  FilterViewController.h
//  Yelp
//
//  Created by Sumeet Ungratwar on 10/26/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FilterViewController; 	

@protocol FilterViewControllerDelegate <NSObject>

- (void)filterViewController:(FilterViewController *)filterViewController didChangeFilters:(NSDictionary *)filters;

@end

@interface FilterViewController : UIViewController

@property (nonatomic, weak) id<FilterViewControllerDelegate> delegate;

@end
