//
//  EmployeeViewController.m
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/28.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import "EmployeeViewController.h"

@interface EmployeeViewController () <HomeViewDelegate, UISearchBarDelegate>

@end

@implementation EmployeeViewController
@synthesize containView;
@synthesize tblEmployee;
@synthesize inputDepartment;
@synthesize allEmployee;
@synthesize allEmployeeTitle;
@synthesize searchBar;
@synthesize isFiltered;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView {
    
    [containView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    HeaderView *header = [[HeaderView alloc] init];
    
    isFiltered = NO;
    searchBar.delegate = self;
    [searchBar setHidden:YES];
    
    if (allEmployee) {
        
        [searchBar setHidden:NO];
        [header setHeaderWithTitle:@"全社員" hideBack:YES hideAdd:YES inController:self];
    } else {
        
        [header setHeaderWithTitle:inputDepartment.departmentName hideBack:YES hideAdd:NO inController:self];
    }
    
    header.delegate = self;
    
    [self.view addSubview:header];
    
    if (allEmployee) {
        
        [tblEmployee setFrame:CGRectMake(0, header.bounds.size.height + searchBar.bounds.size.height, SCREEN_WIDTH, SCREEN_HEIGHT - header.bounds.size.height - searchBar.bounds.size.height)];
    } else {
        
        [tblEmployee setFrame:CGRectMake(0, header.bounds.size.height, SCREEN_WIDTH, SCREEN_HEIGHT - header.bounds.size.height)];
    }
    
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
//Lay danh sach toan bo EmployeeDepartment
- (void)getAllDepartmentEmployee {
    
    allDepartmentEmployeeList = [[NSMutableArray alloc] init];
    
    [allDepartmentEmployeeList addObjectsFromArray:[[ContentManager shareManager] getAllDepartmentEmployee]];
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
        if(isFiltered) {
            
            return filteredEmployees.count;
        } else {
            
             return [employeeList count];
        }
       
    } else {
        
        return [employeeListInDepartment count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = [self.tblEmployee dequeueReusableCellWithIdentifier:@"Cell"];
    
    //------------
    if(allEmployee) {
        
        
        if(isFiltered) {
            
            [cell setCellWithEmployee:[filteredEmployees objectAtIndex:indexPath.row] atIndex:indexPath];
        } else {
            
            [cell setCellWithEmployee:[employeeList objectAtIndex:indexPath.row] atIndex:indexPath];
        }
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
    
    if (allEmployee) {
        if (isFiltered) {
            
            // Sua Employee trong man hinh all Search Employee
            if ([[ContentManager shareManager] editEmployee:[filteredEmployees objectAtIndex:index.row]]) {
                
                AddViewController *addView = [[AddViewController alloc] init];
                
                addView.isEmployee = YES;
                
                addView.editFlag = YES;
                
                addView.delegate = self;
                
                addView.inputEmployee = [filteredEmployees objectAtIndex:index.row];
                
                [self.navigationController pushViewController:addView animated:YES];
            }
        } else {
            
            // Sua Employee trong man hinh all Employee
            if ([[ContentManager shareManager] editEmployee:[employeeList objectAtIndex:index.row]]) {
                
                AddViewController *addView = [[AddViewController alloc] init];
                
                addView.isEmployee = YES;
                
                addView.editFlag = YES;
                
                addView.delegate = self;
                
                addView.inputEmployee = [employeeList objectAtIndex:index.row];
                
                [self.navigationController pushViewController:addView animated:YES];
            }
        }
    } else {
        // Sua Employee trong Department
        if ([[ContentManager shareManager] editEmployee:[employeeListInDepartment objectAtIndex:index.row]]) {
            
            AddViewController *addView = [[AddViewController alloc] init];
            
            addView.isEmployee = YES;
            
            addView.editFlag = YES;
            
            addView.delegate = self;
            
            addView.inputEmployee = [employeeListInDepartment objectAtIndex:index.row];
            
            [self.navigationController pushViewController:addView animated:YES];
        }
    }
}

- (void)tableViewCellDeleteAtIndex:(NSIndexPath *)index {
    
    if(allEmployee) {
        if(isFiltered){
            if ([[ContentManager shareManager] deleteEmployee:[filteredEmployees objectAtIndex:index.row]]) {
                
                [filteredEmployees removeObjectAtIndex:index.row];
                
                [tblEmployee beginUpdates];
                
                [tblEmployee deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationLeft];
                
                [tblEmployee endUpdates];
                
                [tblEmployee reloadData];
            }
            if ([[ContentManager shareManager] deleteDepartmentEmployee:[departmentEmployeeForSearch objectAtIndex:index.row]]) {

                [departmentEmployeeForSearch removeObjectAtIndex:index.row];

                [tblEmployee reloadData];
            }
        } else {
            // Xoa Employee
            if ([[ContentManager shareManager] deleteEmployee:[employeeList objectAtIndex:index.row]]) {
                
                [employeeList removeObjectAtIndex:index.row];
                
                [tblEmployee beginUpdates];
                
                [tblEmployee deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationLeft];
                
                [tblEmployee endUpdates];
                
                [tblEmployee reloadData];
            }
            // Xoa DepartmentEmployee
            [self getAllDepartmentEmployee];
            if ([[ContentManager shareManager] deleteDepartmentEmployee:[allDepartmentEmployeeList objectAtIndex:index.row]]) {
                
                [allDepartmentEmployeeList removeObjectAtIndex:index.row];
                
                [tblEmployee reloadData];
            }
        }
        
    } else {
        // Xoa Employee
        if ([[ContentManager shareManager] deleteEmployee:[employeeListInDepartment objectAtIndex:index.row]]) {
            
            [employeeListInDepartment removeObjectAtIndex:index.row];
            
            [tblEmployee beginUpdates];
            
            [tblEmployee deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationLeft];
            
            [tblEmployee endUpdates];
            
            [tblEmployee reloadData];
        }
         // Xoa DepartmentEmployee
        if ([[ContentManager shareManager] deleteDepartmentEmployee:[departmentEmployeeList objectAtIndex:index.row]]) {

            [departmentEmployeeList removeObjectAtIndex:index.row];

            [tblEmployee reloadData];
        }
    }
}

#pragma mark - HomeView's delegate
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

- (void)homeViewPushRightActionEmployee {
    
    if (!allEmployee) {
        
        EmployeeViewController *employeeViewController = [[EmployeeViewController alloc] init];
        
        [self.navigationController pushViewController:employeeViewController animated:YES];
        
        employeeViewController.allEmployee = YES;
        
        employeeViewController.allEmployeeTitle = YES;
    }
}

#pragma mark - Search's delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    [self getAllEmployee];
    
    if (searchText.length == 0) {
        
        isFiltered = false;
    } else {
        isFiltered = true;
    
        filteredEmployees = [[NSMutableArray alloc] init];
        
        Employee *employee = [[Employee alloc] init];
        
        for (employee in employeeList) {
            
            NSString *employeeName = [[NSString alloc] init];
            
            employeeName = employee.employeeName;
            
            NSRange nameRange = [employeeName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (nameRange.location != NSNotFound) {
                
                [filteredEmployees addObject:employee];
            }
        }
    }
    [self getDepartmentEmployeeForSearch];
    [self.tblEmployee reloadData];
}

- (void)getDepartmentEmployeeForSearch{

    departmentEmployeeForSearch = [[NSMutableArray alloc] init];

    [departmentEmployeeForSearch addObjectsFromArray:[[ContentManager shareManager] getDepartmentEmployeeForSearch:filteredEmployees]];
}

@end
