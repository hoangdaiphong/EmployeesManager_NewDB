//
//  TableViewCell.h
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/25.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Department+CoreDataClass.h"
#import "Employee+CoreDataClass.h"
#import "AddViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TableViewCellDelegate <NSObject>

@optional
- (void)tableViewCellDeleteAtIndex:(NSIndexPath *)index;
- (void)tableViewCellEditAtIndex:(NSIndexPath *)index;
//Check employee trong list NONE
- (void)tableViewCellCheckAtIndex:(NSIndexPath *)index isCheck:(BOOL)isCheck;
@end

@interface TableViewCell : UITableViewCell {
    
    NSIndexPath *currentCell;
}

@property (nonatomic, weak) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblDeparment;
//Hien thi cac button hay khong
@property (nonatomic, weak) IBOutlet UIButton *btnEdit;
@property (nonatomic, weak) IBOutlet UIButton *btnDelete;
@property (nonatomic, weak) IBOutlet UIButton *btnCheck;

//Them bien check YES NO hien thi button check
@property (nonatomic, assign) BOOL isCheck;

@property (nonatomic, weak) id<TableViewCellDelegate>delegate;

- (void)setHiddenDepartment:(BOOL)isHidden;
- (void)setCellWithDepartment:(Department *)department atIndex:(NSIndexPath *)index;
- (void)setCellWithDepartmentForAllEmployee:(Employee *)employee;
- (void)setCellWithEmployee:(Employee *)employee atIndex:(nonnull NSIndexPath *)index;

//--------
-(void)setHiddenButtonInCell:(BOOL)hideEdit deleteButton:(BOOL)hideDelete checkButton:(BOOL)checkButton;

@end

NS_ASSUME_NONNULL_END
