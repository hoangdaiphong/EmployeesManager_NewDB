//
//  AddViewController.h
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/25.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HeaderView.h"
#import "Department+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@protocol AddViewControllerDelegate <NSObject>

@optional
- (void)addViewControllerFinishWithSuccess:(BOOL)success;

@end

@interface AddViewController : UIViewController <HeaderViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate> {

    NSMutableArray *departmentList;
    NSMutableArray *employeeList;
    NSMutableArray *employeeListOfNONE;
    NSMutableArray *employeeListAddFromNONE;
    NSMutableArray *boolArrayforEmployeeNONE;
    NSMutableArray *departmentEmployeeListAddFromNONE;
}

@property (nonatomic, weak) IBOutlet UIView *containView;
@property (nonatomic, weak) IBOutlet UITextField *txtName;
@property (nonatomic, weak) IBOutlet UITextField *txtDepartmentName;

@property (nonatomic, weak) IBOutlet UILabel *lblEmploye;
@property (nonatomic, weak) IBOutlet UILabel *lblDepartment;

@property (nonatomic, weak) IBOutlet UIPickerView *pickerView;
@property (nonatomic, weak) IBOutlet UIButton *btnSave;

//---------
@property (weak, nonatomic) IBOutlet UITableView *tblNONE;

@property (nonatomic, assign) BOOL editFlag;
@property (nonatomic, assign) BOOL isEmployee;
@property (nonatomic, assign) BOOL allEmployee;
//---------
@property (nonatomic, assign) BOOL isCheck;

@property (nonatomic, weak) Department *inputDepartment;
@property (nonatomic, weak) Employee *inputEmployee;

// sua employee thi cung sua departmentemployee tu employeeViewController truyen vao
@property (nonatomic, weak) DepartmentEmployee *inputDepartmentEmployee;

@property (nonatomic, weak) id<AddViewControllerDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
