//
//  DepartmentViewController.m
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/25.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import "DepartmentViewController.h"

@interface DepartmentViewController () <HomeViewDelegate>

@end

@implementation DepartmentViewController

@synthesize tblDepartment;
@synthesize containView;

//-------------
@synthesize inputDepartment;
//-------------

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView {
    
    [containView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    HeaderView *header = [[HeaderView alloc] init];
    [header setHeaderWithTitle:@"部署" hideBack:YES hideAdd:NO inController:self];
    header.delegate = self;
    [containView addSubview:header];
    
    [tblDepartment setFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT - 100)];
    
    [tblDepartment registerNib:[UINib nibWithNibName:NSStringFromClass([TableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Cell"];
    
    tblDepartment.dataSource = self;
    tblDepartment.delegate = self;
    
    HomeView *homeView = [[HomeView alloc] init];
    [homeView setHomeView:YES hideDepartment:NO hideEmployee:YES];
    homeView.delegate = self;
    [containView addSubview:homeView];
    
    [self getData];
}

- (void)getData {
    
    // Lay danh sach department
    departmentList = [[NSMutableArray alloc] init];
    
    [departmentList addObjectsFromArray:[[ContentManager shareManager] getAllDepartment]];
    
    // Lay danh sach employee trong Department va Lay danh sach departmentEmployee trung DepartmentID
    [self getEmployeeListInDepartment];
    
    [tblDepartment reloadData];
}


// Lay danh sach departmentEmployee trung DepartmentID
- (void)getEmployeeDepartment {
    
    departmentEmployeeList = [[NSMutableArray alloc] init];
    
    [departmentEmployeeList addObjectsFromArray:[[ContentManager shareManager] getDepartmentEmployee:inputDepartment.departmentID]];
    
    NSLog(@"%@", inputDepartment);
}

// Lay danh sach employee trong Department
- (void)getEmployeeListInDepartment {
    
    [self getEmployeeDepartment];
    
    employeeListInDepartment = [[NSMutableArray alloc] init];
    
    [employeeListInDepartment addObjectsFromArray:[[ContentManager shareManager] getEmployeeInDepartment:departmentEmployeeList]];
}


#pragma mark - TableView's Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  [departmentList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = [self.tblDepartment dequeueReusableCellWithIdentifier:@"Cell"];
    
    [cell setCellWithDepartment:[departmentList objectAtIndex:indexPath.row] atIndex:indexPath];
    
    cell.delegate = self;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tblDepartment deselectRowAtIndexPath:indexPath animated:YES];
    
    EmployeeViewController *employeeView = [[EmployeeViewController alloc] init];
    
    employeeView.inputDepartment = [departmentList objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:employeeView animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ( indexPath.row % 2 == 0 )
        cell.backgroundColor = [UIColor colorWithRed:178/255.f green:14/255.f blue:12/255.f alpha:0.05];
    else
        cell.backgroundColor = [UIColor whiteColor];
}

#pragma mark - HeaderView's Delegate
- (void)headerViewPushRightAction {
    
    AddViewController *addView = [[AddViewController alloc] init];
    
    addView.delegate = self;
    
    [self.navigationController pushViewController:addView animated:YES];
}

#pragma mark - AddView's Delegate
- (void)addViewControllerFinishWithSuccess:(BOOL)success {
    
    if(success) {
        
        [self getData];
    }
}

#pragma mark - TableViewCell's Delegate

- (void)tableViewCellDeleteAtIndex:(NSIndexPath *)index {
    
    inputDepartment = [departmentList objectAtIndex:index.row];
    // Xoa employeesList
    [self getEmployeeListInDepartment];
    
        for (long i = employeeListInDepartment.count; i > 0; i--) {
            
            if ([[ContentManager shareManager] deleteDepartmentEmployee:employeeListInDepartment[i - 1]]) {
                
                [employeeListInDepartment removeObjectAtIndex:(i - 1)];
            }
        }
    
    // Xoa departmentEmployeeList
    [self getEmployeeDepartment];

        for (long i = departmentEmployeeList.count; i > 0; i--) {
    
            if ([[ContentManager shareManager] deleteDepartmentEmployee:departmentEmployeeList[i - 1]]) {
    
                [departmentEmployeeList removeObjectAtIndex:(i - 1)];
            }
        }

    // Xoa Department
    if ([[ContentManager shareManager] deleteDepartment:[departmentList objectAtIndex:index.row]]) {
        
        [departmentList removeObjectAtIndex:index.row];
        
        [tblDepartment beginUpdates];
        
        [tblDepartment deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationLeft];
        
        [tblDepartment endUpdates];
        
        [tblDepartment reloadData];
    }
}

- (void)tableViewCellEditAtIndex:(NSIndexPath *)index {
    
    AddViewController *addView = [[AddViewController alloc] init];
    
    addView.delegate = self;
    
    addView.editFlag = YES;
    
    addView.inputDepartment = [departmentList objectAtIndex:index.row];
    
    [self.navigationController pushViewController:addView animated:YES];
}

#pragma HomeView delegate

- (void)homeViewPushRightActionEmployee {
    
    EmployeeViewController *employeeViewController = [[EmployeeViewController alloc] init];
    
    [self.navigationController pushViewController:employeeViewController animated:YES];

    employeeViewController.allEmployee = YES;
    
    employeeViewController.allEmployeeTitle = YES;
}

- (void)homeViewPushRightActionHome {
    
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    
    NSMutableArray *vcs =  [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    
    [vcs insertObject:homeViewController atIndex:[vcs count] - 1];
    
    [self.navigationController setViewControllers:vcs animated:NO];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
