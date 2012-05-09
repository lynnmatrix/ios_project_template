//
//  TTTableViewCell+CellMargin.m
//  Discovery
//
//  Created by Yiming Lin on 2/20/12.
//  Copyright (c) 2012 . All rights reserved.
//

#import "TTTableViewCell+CellMargin.h"
#import "DefaultCSSStyleSheet.h"

@implementation TTTableViewCell (CellMargin)
-(id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = STYLEVAR(tableCellBackgroundColor);
    }
    return self;
}

-(void) layoutSubviews{
    [super layoutSubviews];
    self.backgroundView.left = 3;
    self.backgroundView.width= self.width - 2*3;
    
    self.contentView.left = 3;
    self.contentView.width = self.width -6;
}
@end
