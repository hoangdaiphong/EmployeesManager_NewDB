//
//  DepartmentViewController.h
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/25.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TableViewCell.h"
#import "HeaderView.h"
#import "AddViewController.h"
#import "EmployeeViewController.h"
#import "DepartmentEmployee+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface DepartmentViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, HeaderViewDelegate, AddViewControllerDelegate, TableViewCellDelegate> {
    
    NSMutableArray *departmentList;
    //-----------
    NSMutableArray *departmentEmployeeList;
    NSMutableArray *employeeListInDepartment;
    //-----------
}

@property (nonatomic, weak) IBOutlet UIView *containView;
@property (nonatomic, weak) IBOutlet UITableView *tblDepartment;

//---------------
@property (nonatomic, weak) Department *inputDepartment;
//---------------
@end

NS_ASSUME_NONNULL_END
