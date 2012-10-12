//
//  Project1Cell.m
//  cs4356projects
//
//  Created by Johnathan Stansbury on 10/12/12.
//  Copyright (c) 2012 LSU. All rights reserved.
//

#import "Project1Cell.h"

@implementation Project1Cell
@synthesize project1CellLabel = _project1CellLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
