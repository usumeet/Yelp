//
//  Business.h
//  Yelp
//
//  Created by Sumeet Ungratwar on 10/26/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Business : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) NSURL *ratingURL;
@property (nonatomic, assign) NSInteger numReviews;
@property (nonatomic, assign) float distance;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *categories;

+ (NSArray *)businessesWithDictionaries:(NSArray *)dictionaries;

@end
