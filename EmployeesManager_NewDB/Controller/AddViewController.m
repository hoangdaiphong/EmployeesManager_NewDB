//
//  AddViewController.m
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/25.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController

@synthesize containView;
@synthesize delegate;
@synthesize txtName;
@synthesize editFlag;
@synthesize inputDepartment;
@synthesize btnSave;
@synthesize isEmployee;
@synthesize inputEmployee;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView {
    
    [containView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    HeaderView *header = [[HeaderView alloc] init];
    
    if (editFlag) {
        
        if (isEmployee) {
            
            [header setHeaderWithTitle:@"社員を編集" hideBack:NO hideAdd:YES inController:self];
            
            [txtName setText:[inputEmployee employeeName]];
        } else {
            
            [header setHeaderWithTitle:@"部署を編集" hideBack:NO hideAdd:YES inController:self];
            
            [txtName setText:[inputDepartment departmentName]];
        }
    } else {
        
        if (isEmployee) {
            
            [header setHeaderWithTitle:@"社員を追加" hideBack:NO hideAdd:YES inController:self];
        } else {
            
            [header setHeaderWithTitle:@"部署を追加" hideBack:NO hideAdd:YES inController:self];
        }
    }
    header.delegate = self;
    
    [containView addSubview:header];
}
//-------------------------
- (void)getData {
    
    departmentList = [[NSMutableArray alloc] init];
    
    [departmentList addObjectsFromArray:[[ContentManager shareManager] getAllDepartment]];
    
    employeeList = [[NSMutableArray alloc] init];
    
    [employeeList addObjectsFromArray:[[ContentManager shareManager] getAllEmployee]];
}

- (IBAction)addAction:(id)sender {
    
    if ([[txtName text] length] > 0) {
        
        BOOL success;
        
        if (editFlag) {
            
            if (isEmployee) {
                
                inputEmployee.employeeName = [txtName text];
                
                success = [[ContentManager shareManager] editEmployee:inputEmployee];
            } else {
                
                inputDepartment.departmentName = [txtName text];
                
                success = [[ContentManager shareManager] editDepartment:inputDepartment];
            }
        } else {
            
            if (isEmployee) {
                
                success = [[ContentManager shareManager] insertEmployeeWithName:txtName.text];
                //---------------------
                // Them DepartmentEmployee
                
                    [self getData];
                    
                    Employee *employee = [[Employee alloc] init];
                    
                    employee = employeeList[employeeList.count - 1];
                
                    success = [[ContentManager shareManager] insertDepartmentEmployee:inputDepartment.departmentID employeeID:employee.employeeID];
                //---------------------
            } else {
                
                success = [[ContentManager shareManager] insertDepartmentWithName:txtName.text];
            }
        }
        
        if (delegate != nil && [delegate respondsToSelector:@selector(addViewControllerFinishWithSuccess:)]) {
            
            [delegate addViewControllerFinishWithSuccess:success];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
