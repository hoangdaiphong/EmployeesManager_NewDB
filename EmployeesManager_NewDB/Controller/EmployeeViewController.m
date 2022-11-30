//
//  EmployeeViewController.m
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/28.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import "EmployeeViewController.h"

@interface EmployeeViewController () <HomeViewDelegate>

@end

@implementation EmployeeViewController
@synthesize containView;
@synthesize tblEmployee;
@synthesize inputDepartment;
@synthesize allEmployee;
@synthesize allEmployeeTitle;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView {
    
    [containView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    HeaderView *header = [[HeaderView alloc] init];
    
    if (allEmployeeTitle) {
        
        [header setHeaderWithTitle:@"全社員" hideBack:YES hideAdd:YES inController:self];
    } else {
        
        [header setHeaderWithTitle:inputDepartment.departmentName hideBack:YES hideAdd:NO inController:self];
    }
    
    header.delegate = self;
    
    [self.view addSubview:header];
    
    [tblEmployee setFrame:CGRectMake(0, header.bounds.size.height, SCREEN_WIDTH, SCREEN_HEIGHT - header.bounds.size.height)];
    
    [tblEmployee registerNib:[UINib nibWithNibName:NSStringFromClass([TableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    tblEmployee.dataSource = self;
    tblEmployee.delegate = self;
    
    HomeView *homeView = [[HomeView alloc] init];
    [homeView setHomeView];
    homeView.delegate = self;
    [containView addSubview:homeView];
    
    [self getData];
}

- (void)getData {
    
    [self getAllEmployee];
    
    [self getEmployeeListInDepartment];
    
    [tblEmployee reloadData];
}
//---------------
// Lay toan bo danh sach Employee
- (void) getAllEmployee {
    
    employeeList = [[NSMutableArray alloc] init];
    
    [employeeList addObjectsFromArray:[[ContentManager shareManager] getAllEmployee]];
}
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
    
    if(allEmployee) {
        
        return [employeeList count];
    } else {
        
        return [employeeListInDepartment count];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = [self.tblEmployee dequeueReusableCellWithIdentifier:@"Cell"];
    //------------
    if(allEmployee) {
        
        [cell setCellWithEmployee:[employeeList objectAtIndex:indexPath.row] atIndex:indexPath];
    } else {
        
        [cell setCellWithEmployee:[employeeListInDepartment objectAtIndex:indexPath.row] atIndex:indexPath];
    }
    
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

#pragma HomeView delegate
- (void)homeViewPushRightActionDepartment {
    
    DepartmentViewController *departmentViewController = [[DepartmentViewController alloc] init];
    
    NSMutableArray *vcs =  [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    
    [vcs insertObject:departmentViewController atIndex:[vcs count] - 1];
    
    [self.navigationController setViewControllers:vcs animated:NO];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)homeViewPushRightActionHome {
    
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    
    NSMutableArray *vcs =  [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    
    [vcs insertObject:homeViewController atIndex:[vcs count] - 1];
    
    [self.navigationController setViewControllers:vcs animated:NO];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
