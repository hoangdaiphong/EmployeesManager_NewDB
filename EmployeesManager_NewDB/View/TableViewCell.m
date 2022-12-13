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
@synthesize lblDeparment;
@synthesize delegate;
@synthesize btnEdit;
@synthesize btnDelete;
@synthesize btnCheck;
@synthesize isCheck;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    // Set nut check
//    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//    [imageView setImage:[UIImage imageNamed:@"0.jpg"]];
//    [self.btnCheck addSubview: imageView];
    [btnCheck setHidden:YES];
    
    [lblDeparment setHidden:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// Neu la man hinh danh sach NONE Department cua Employee
-(void)setHiddenButtonInCell:(BOOL)hideEdit deleteButton:(BOOL)hideDelete checkButton:(BOOL)checkButton {
    
    [btnDelete setHidden: hideEdit];
    
    [btnEdit setHidden:hideDelete];
    
    [btnCheck setHidden:checkButton];
}

// Neu la man hinh AllEmployee thi se xuat hien lblDepartment
- (void)setHiddenDepartment:(BOOL)isHidden {
    
    [lblDeparment setHidden:isHidden];
}

- (void)setCellWithDepartment:(Department *)department atIndex:(nonnull NSIndexPath *)index{
    
    [lblName setText:[department departmentName]];
    
    currentCell = index;
}
// Neu la man hinh AllEmployee do du lieu vao lblDepartment
- (void)setCellWithDepartmentForAllEmployee:(Employee *)employee {
    
    int index = [[ContentManager shareManager] getOneDepartmentEmployee:employee];
    
    Department *department = [[Department alloc] init];
    
    department = [[ContentManager shareManager] getOneDepartmentForEmployee:index];
    
    [lblDeparment setText:[department departmentName]];
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

- (IBAction)checkCell:(id)sender {
    
    UIImageView* animatedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    if (!isCheck) {
        
        animatedImageView.animationImages = [NSArray arrayWithObjects:
                                             [UIImage imageNamed:@"1.png"],
                                             [UIImage imageNamed:@"2.png"],
                                             [UIImage imageNamed:@"3.png"],
                                             [UIImage imageNamed:@"4.png"],
                                             [UIImage imageNamed:@"5.png"],
                                             [UIImage imageNamed:@"6.png"],nil];
        animatedImageView.animationDuration = 0.2f;
        animatedImageView.animationRepeatCount = 1;
        [animatedImageView startAnimating];
        [animatedImageView setImage:[UIImage imageNamed:@"6.png"]];
        isCheck = YES;
    } else {
        
        animatedImageView.animationImages = [NSArray arrayWithObjects:
                                             [UIImage imageNamed:@"5.png"],
                                             [UIImage imageNamed:@"4.png"],
                                             [UIImage imageNamed:@"3.png"],
                                             [UIImage imageNamed:@"2.png"],
                                             [UIImage imageNamed:@"1.png"],
                                             [UIImage imageNamed:@"0.png"],nil];
        animatedImageView.animationDuration = 0.2f;
        animatedImageView.animationRepeatCount = 1;
        [animatedImageView startAnimating];
        [animatedImageView setImage:[UIImage imageNamed:@"0.png"]];
        isCheck = NO;
    }
    
    if (delegate != nil && [delegate respondsToSelector:@selector(tableViewCellCheckAtIndex: isCheck:)]) {
        
        [delegate tableViewCellCheckAtIndex:currentCell isCheck:isCheck];
    }
    
    [self.btnCheck addSubview: animatedImageView];
}

@end
