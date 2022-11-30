//
//  TableViewCell.m
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/25.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

@synthesize lblName;
@synthesize delegate;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellWithDepartment:(Department *)department atIndex:(nonnull NSIndexPath *)index{
    
    [lblName setText:[department departmentName]];
    
    currentCell = index;
}

- (void)setCellWithEmployee:(Employee *)employee atIndex:(nonnull NSIndexPath *)index {
    
    [lblName setText:[employee employeeName]];
    
    currentCell = index;
}

- (IBAction)deleteCell:(id)sender {
    
    if (delegate != nil && [delegate respondsToSelector:@selector(tableViewCellDeleteAtIndex:)]) {
        
        [delegate tableViewCellDeleteAtIndex:currentCell];
    }
}

- (IBAction)editCell:(id)sender {
    
    if (delegate != nil && [delegate respondsToSelector:@selector(tableViewCellEditAtIndex:)]) {
        
        [delegate tableViewCellEditAtIndex:currentCell];
    }
}
@end
