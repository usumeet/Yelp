//
//  Business.m
//  Yelp
//
//  Created by Sumeet Ungratwar on 10/26/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "Business.h"

@implementation Business

- (Business *)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    // name
    self.name = dictionary[@"name"];
    // image url
    NSString *image_url = dictionary[@"image_url"];
    if (image_url) {
        self.imageURL = [[NSURL alloc] initWithString:dictionary[@"image_url"]];
    }
    // rating url
    self.ratingURL = [[NSURL alloc] initWithString:dictionary[@"rating_img_url"]];
    // #ratings
    self.numReviews  = [dictionary[@"review_count"] integerValue];
    // distance
    float milesPerMeter = 0.000621371;
    self.distance = [dictionary[@"distance"] floatValue] * milesPerMeter;
    
    // address
    NSLog(@"dictionary %@", dictionary);
    NSArray *address = [dictionary valueForKeyPath:@"location.address"];
    NSArray *neighborhoods = [dictionary valueForKeyPath:@"location.neighborhoods"];
    if (address && neighborhoods && address.count > 0 && neighborhoods.count > 0) {
        NSString *street = [dictionary valueForKeyPath:@"location.address"][0];
        NSString *neighborhood = [dictionary valueForKeyPath:@"location.neighborhoods"][0];
        self.address = [NSString stringWithFormat:@"%@, %@", street, neighborhood];
    } else {
        self.address = @"";
    }
    
    // categories
    NSArray *categories = dictionary[@"categories"];
    NSMutableArray *categoryNames = [NSMutableArray array];
    [categories enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [categoryNames addObject:obj[0]];
    }];
    self.categories = [categoryNames componentsJoinedByString:@", "];
    
    return self;
    
    
}

+ (NSArray *)businessesWithDictionaries:(NSArray *)dictionaries {
    NSMutableArray *businesses = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in dictionaries) {
        Business *business = [[Business alloc] initWithDictionary:dictionary];
        [businesses addObject:business];
    }
    return businesses;
}



@end
