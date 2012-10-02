//
//  OwerTableViewCell.m
//  PayUp
//
//  Created by Edward Kim on 10/1/12.
//  Copyright (c) 2012 Edward Kim. All rights reserved.
//

#import "Ower.h"
#import "OwerTableViewCell.h"

@interface OwerTableViewCell ()
@property (strong) UILabel *nameLabel;
@property (strong) UILabel *numberLabel;
@property (strong) UILabel *requesterLabel;
@property (strong) UILabel *amountLabel;
@end

@implementation OwerTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryNone;
        
        [self.contentView setFrame:CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.contentView.frame.size.width, 100.0)];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        CGRect nameLabelFrame = CGRectMake(6.0, 6.0, 190.0, 42.0);
        CGRect numberLabelFrame = CGRectMake(20.0, 42.0, 176.0, 17.0);
        CGRect requesterLabelFrame = CGRectMake(20.0, 59.0, 176.0, 17.0);
        CGRect amountLabelFrame = CGRectMake(206.0, 6.0, 108.0, 88.0);
        
        self.nameLabel = [[UILabel alloc] initWithFrame:nameLabelFrame];
        self.numberLabel = [[UILabel alloc] initWithFrame:numberLabelFrame];
        self.requesterLabel = [[UILabel alloc] initWithFrame:requesterLabelFrame];
        self.amountLabel = [[UILabel alloc] initWithFrame:amountLabelFrame];
        
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.numberLabel.backgroundColor = [UIColor clearColor];
        self.requesterLabel.backgroundColor = [UIColor clearColor];
        self.amountLabel.backgroundColor = [UIColor clearColor];
        
        self.nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24.0];
        self.nameLabel.textColor = [UIColor brownColor];
        self.numberLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17.0];
        self.numberLabel.textColor = [UIColor brownColor];
        self.numberLabel.numberOfLines = 1;
        self.requesterLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17.0];
        self.requesterLabel.textColor = [UIColor brownColor];
        self.amountLabel.textColor = [UIColor brownColor];
        
        
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.numberLabel];
        [self.contentView addSubview:self.requesterLabel];
        [self.contentView addSubview:self.amountLabel];
    }
    return self;
}

- (id)init {
    return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OwerCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setOwer:(Ower *)ower {
    _ower = ower;
    self.nameLabel.text = ower.name;
    self.numberLabel.text = ower.number;
    self.requesterLabel.text = ower.requester;
    self.amountLabel.text =  [NSString stringWithFormat:@"%d",ower.amount];
}

@end
