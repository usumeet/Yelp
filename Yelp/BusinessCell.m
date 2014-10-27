//
//  BusinessCell.m
//  Yelp
//
//  Created by Sumeet Ungratwar on 10/26/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "BusinessCell.h"
#import "UIImageView+AFNetworking.h"

@interface BusinessCell ()
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImageView;
@property (weak, nonatomic) IBOutlet UILabel *ratingsLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoriesLabel;
@end


@implementation BusinessCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setBusiness:(Business *)business {
    _business = business;
    
    [self.posterImageView setImageWithURL:business.imageURL];
    self.nameLabel.text = business.name;
    self.distanceLabel.text = [NSString stringWithFormat:@"%0.2f mi", business.distance];
    [self.ratingImageView setImageWithURL:business.ratingURL];
    self.ratingsLabel.text = [NSString stringWithFormat:@"%ld Reviews", business.numReviews];
    self.addressLabel.text = business.address;
    self.categoriesLabel.text = business.categories;
}


@end
