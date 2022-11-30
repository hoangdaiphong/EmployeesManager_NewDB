//
//  EmployeeViewController.h
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/28.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Department+CoreDataClass.h"
#import "HeaderView.h"
#import "AddViewController.h"
#import "TableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EmployeeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, HeaderViewDelegate, AddViewControllerDelegate, TableViewCellDelegate> {

    //----------
    NSMutableArray *employeeListInDepartment;
    NSMutableArray *departmentEmployeeList;
    //----------
}

@property (nonatomic, weak) IBOutlet UIView *containView;
@property (nonatomic, weak) IBOutlet UITableView *tblEmployee;

//---------------
@property (nonatomic, weak) Department *inputDepartment;
//---------------
@end

NS_ASSUME_NONNULL_END
