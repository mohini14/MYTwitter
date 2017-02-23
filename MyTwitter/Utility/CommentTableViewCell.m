//
//  CommentTableViewCell.m
//  MyTwitter
//
//  Created by Mohini Sindhu  on 20/02/17.
//  Copyright © 2017 Mohini. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)delButtonPressed:(UIButton *)sender{
	CommentViewController *obj=[CommentViewController new];
	[obj delButtonActions:self.delButton];
}

@end
