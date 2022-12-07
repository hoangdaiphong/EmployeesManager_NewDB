//
//  AddViewController.m
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/25.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import "AddViewController.h"
#import "EmployeeViewController.h"

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
@synthesize txtDepartmentName;
@synthesize pickerView;
@synthesize allEmployee;
@synthesize lblEmploye;
@synthesize lblDepartment;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView {
    
    [containView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    containView.backgroundColor = [UIColor colorWithRed:178/255.f green:14/255.f blue:12/255.f alpha:0.05];
    
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
            
            txtName.placeholder = @"社員名";
        } else {
            
            [header setHeaderWithTitle:@"部署を追加" hideBack:NO hideAdd:YES inController:self];
            
            txtName.placeholder = @"部署名";
        }
    }
    header.delegate = self;
    [containView addSubview:header];
    
    [lblDepartment setHidden:YES];
    [lblEmploye setHidden:YES];
    [txtDepartmentName setHidden:YES];
    [pickerView setHidden:YES];
    
    if(allEmployee) {
        
        [txtDepartmentName setHidden: NO];
        [pickerView setHidden: NO];
        
        [lblDepartment setHidden:NO];
        [lblEmploye setHidden:NO];
        txtDepartmentName.placeholder = @"部署名";
        
        [txtDepartmentName setFrame:CGRectMake(48, 223, 278, 30)];
        [pickerView setFrame:CGRectMake(40, 246, 278, 216)];
        [btnSave setFrame:CGRectMake(156, 453, 62, 65)];
        
        pickerView.dataSource = self;
        pickerView.delegate = self;
    }
}

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
                //Neu la danh sach tat ca Employee
                if(allEmployee) {
                    // Nếu chọn Department
                    if ([[txtDepartmentName text] length] > 0) {
                        
                        success = [[ContentManager shareManager] insertEmployeeWithName:txtName.text];
                        // Them DepartmentEmployee
                        [self getData];
                        
                        Employee *employee = [[Employee alloc] init];
                        
                        employee = employeeList[employeeList.count - 1];
                        
                        success = [[ContentManager shareManager] insertDepartmentEmployee:inputDepartment.departmentID employeeID:employee.employeeID];
                    } else { // Nếu không chọn department
                        
                        success = [[ContentManager shareManager] insertEmployeeWithName:txtName.text];
                        // Them DepartmentEmployee
                        [self getData];
                        
                        Employee *employee = [[Employee alloc] init];
                        
                        employee = employeeList[employeeList.count - 1];
                        
                        success = [[ContentManager shareManager] insertDepartmentEmployee:@"dep000" employeeID:employee.employeeID];
                    }
                } else {
                    
                    // Neu la danh sach Employee trong department
                    success = [[ContentManager shareManager] insertEmployeeWithName:txtName.text];
                    // Them DepartmentEmployee
                    [self getData];
                    
                    Employee *employee = [[Employee alloc] init];
                    
                    employee = employeeList[employeeList.count - 1];
                    
                    success = [[ContentManager shareManager] insertDepartmentEmployee:inputDepartment.departmentID employeeID:employee.employeeID];
                }
                
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

#pragma mark - pickerView's delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    [self getData];
    
    return departmentList.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    Department *department = [[Department alloc] init];
    
    department = departmentList[row];
    
    return department.departmentName;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    Department *department = [[Department alloc] init];
    
    department = departmentList[row];
    
    inputDepartment = department;
    
    txtDepartmentName.text = department.departmentName;
    
    [txtDepartmentName resignFirstResponder];
}
@end
