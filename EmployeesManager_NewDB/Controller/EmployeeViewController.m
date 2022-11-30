//
//  EmployeeViewController.m
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/28.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import "EmployeeViewController.h"

@interface EmployeeViewController ()

@end

@implementation EmployeeViewController
@synthesize containView;
@synthesize tblEmployee;
@synthesize inputDepartment;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView {
    
    [containView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    HeaderView *header = [[HeaderView alloc] init];
    
    [header setHeaderWithTitle:inputDepartment.departmentName hideBack:NO hideAdd:NO inController:self];
    
    header.delegate = self;
    
    [self.view addSubview:header];
    
    [tblEmployee setFrame:CGRectMake(0, header.bounds.size.height, SCREEN_WIDTH, SCREEN_HEIGHT - header.bounds.size.height)];
    
    [tblEmployee registerNib:[UINib nibWithNibName:NSStringFromClass([TableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    tblEmployee.dataSource = self;
    tblEmployee.delegate = self;
    
    [self getData];
}

- (void)getData {
    
    [self getEmployeeListInDepartment];
    
    [tblEmployee reloadData];
}
//---------------
// Lay danh sach EmployeeDepartment co DepartmentID trung nhau
- (void)getEmployeeDepartment {
    
    departmentEmployeeList = [[NSMutableArray alloc] init];
    
    [departmentEmployeeList addObjectsFromArray:[[ContentManager shareManager] getDepartmentEmployee:inputDepartment.departmentID]];
}
// Lay danh sach Employee co Employee trong EmployeeDepartment
- (void)getEmployeeListInDepartment {
    
    [self getEmployeeDepartment];
    
    employeeListInDepartment = [[NSMutableArray alloc] init];
    
    [employeeListInDepartment addObjectsFromArray:[[ContentManager shareManager] getEmployeeInDepartment:departmentEmployeeList]];
}
//-------------
#pragma mark - HeaderView's Delegate
- (void)headerViewPushRightAction {
    
    AddViewController *addView = [[AddViewController alloc] init];
    
    addView.isEmployee = YES;
    
    addView.delegate = self;
    
    addView.inputDepartment = inputDepartment;
    
    [self.navigationController pushViewController:addView animated:YES];
}

#pragma mark - AddViewController Delegate
- (void)addViewControllerFinishWithSuccess:(BOOL)success {
    
    if(success) {
        
        [self getData];
    }
}

#pragma mark - TableView's Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [employeeListInDepartment count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = [self.tblEmployee dequeueReusableCellWithIdentifier:@"Cell"];
    //------------
    [cell setCellWithEmployee:[employeeListInDepartment objectAtIndex:indexPath.row] atIndex:indexPath];
    //------------
    cell.delegate = self;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tblEmployee deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - TableViewCell's Delegate
- (void)tableViewCellEditAtIndex:(NSIndexPath *)index {
    
    if ([[ContentManager shareManager] editEmployee:[employeeListInDepartment objectAtIndex:index.row]]) {

        AddViewController *addView = [[AddViewController alloc] init];
        
        addView.isEmployee = YES;
        
        addView.editFlag = YES;
        
        addView.delegate = self;
        
        addView.inputEmployee = [employeeListInDepartment objectAtIndex:index.row];
        
        [self.navigationController pushViewController:addView animated:YES];
    }
}

- (void)tableViewCellDeleteAtIndex:(NSIndexPath *)index {
    
    if ([[ContentManager shareManager] deleteEmployee:[employeeListInDepartment objectAtIndex:index.row]]) {
        
        [employeeListInDepartment removeObjectAtIndex:index.row];
        
        [tblEmployee beginUpdates];
        
        [tblEmployee deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationLeft];
        
        [tblEmployee endUpdates];
        
        [tblEmployee reloadData];
    }
    
    if ([[ContentManager shareManager] deleteDepartmentEmployee:[departmentEmployeeList objectAtIndex:index.row]]) {
        
        [departmentEmployeeList removeObjectAtIndex:index.row];
        
        [tblEmployee reloadData];
    }
}
@end
