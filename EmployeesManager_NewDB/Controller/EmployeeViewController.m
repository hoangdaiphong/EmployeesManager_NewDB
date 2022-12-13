//
//  EmployeeViewController.m
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/28.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import "EmployeeViewController.h"
#import <QuartzCore/QuartzCore.h>

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
@synthesize imgNoneEmployee;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView {
    
    [containView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    HeaderView *header = [[HeaderView alloc] init];
    
    isFiltered = NO;
    searchBar.delegate = self;
    [searchBar setFrame:CGRectMake(0, header.bounds.size.height, searchBar.bounds.size.width, searchBar.bounds.size.height)];
    [searchBar setHidden:YES];
    if (allEmployee) {
        
        [searchBar setHidden:NO];
        [header setHeaderWithTitle:@"全社員" hideBack:YES hideAdd:NO inController:self];
    } else {
        
        [header setHeaderWithTitle:inputDepartment.departmentName hideBack:NO hideAdd:NO inController:self];
    }
    header.delegate = self;
    [self.view addSubview:header];
    
    HomeView *homeView = [[HomeView alloc] init];
    [homeView setHomeView:YES hideDepartment:YES hideEmployee:NO];
    homeView.delegate = self;
    [containView addSubview:homeView];
    
    if (allEmployee) {
        
        [tblEmployee setFrame:CGRectMake(0, header.bounds.size.height + searchBar.bounds.size.height, SCREEN_WIDTH, SCREEN_HEIGHT - header.bounds.size.height - searchBar.bounds.size.height - homeView.bounds.size.height)];
    } else {
        
        [tblEmployee setFrame:CGRectMake(0, header.bounds.size.height, SCREEN_WIDTH, SCREEN_HEIGHT - header.bounds.size.height - homeView.bounds.size.height)];
    }
    
    [tblEmployee registerNib:[UINib nibWithNibName:NSStringFromClass([TableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Cell"];
    tblEmployee.backgroundColor = [UIColor colorWithRed:18/255.f green:14/255.f blue:152/255.f alpha:0.1];
    tblEmployee.dataSource = self;
    tblEmployee.delegate = self;
    tblEmployee.separatorColor = [UIColor clearColor];
    
    //set Image neu khong co Employee
    [imgNoneEmployee setImage:[UIImage imageNamed:@"noData.png"]];
    [imgNoneEmployee setHidden:YES];
    
    [self getData];
}

- (void)getData {
    
    [self getAllEmployee];
    
    [self getAllDepartment];
    
    [self getEmployeeListInDepartment];
    
    [tblEmployee reloadData];
}

// Lay toan bo danh sach Employee
- (void) getAllEmployee {
    
    employeeList = [[NSMutableArray alloc] init];
    
    [employeeList addObjectsFromArray:[[ContentManager shareManager] getAllEmployee]];
}

- (void)getAllDepartment {
    
    departmentList = [[NSMutableArray alloc] init];
    
    [departmentList addObjectsFromArray:[[ContentManager shareManager] getAllDepartment]];
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

#pragma mark - HeaderView's Delegate
- (void)headerViewPushRightAction {
    
    AddViewController *addView = [[AddViewController alloc] init];
    
    addView.isEmployee = YES;
    
    addView.delegate = self;
    
    addView.inputDepartment = inputDepartment;
    
    if(allEmployee){
 
        addView.allEmployee = YES;
    }
    
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
        
//        Neu khong co employee thi se hien ra man hinh thong bao khong co gi
        if(employeeListInDepartment.count == 0){
            
            // Animation cho UIImageView
            [imgNoneEmployee setHidden:NO];
            CGPoint origin = self.imgNoneEmployee.center;
            CGPoint target = CGPointMake(self.imgNoneEmployee.center.x, self.imgNoneEmployee.center.y+50);
            CABasicAnimation *bounce = [CABasicAnimation animationWithKeyPath:@"position.y"];
            bounce.duration = 0.5;
            bounce.fromValue = [NSNumber numberWithInt:origin.y];
            bounce.toValue = [NSNumber numberWithInt:target.y];
            bounce.repeatCount = 2;
            bounce.autoreverses = YES;
            [self.imgNoneEmployee.layer addAnimation:bounce forKey:@"position"];
            CGAffineTransform transform = CGAffineTransformMakeScale(1.3, 1.3);
            imgNoneEmployee.transform = transform;

            [tblEmployee setHidden: YES];
            
        } else {
            [imgNoneEmployee setHidden:YES];
            
            [tblEmployee setHidden: NO];
        }
        return [employeeListInDepartment count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = [self.tblEmployee dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(allEmployee) {
        // Neu la man hinh AllEmployee thi se hien Label Department
        [cell setHiddenDepartment:NO];
        
        if(isFiltered) {
            
            [cell setCellWithEmployee:[filteredEmployees objectAtIndex:indexPath.row] atIndex:indexPath];
            // Do ten Department vao LblDepartment
            [cell setCellWithDepartmentForAllEmployee:[filteredEmployees objectAtIndex:indexPath.row]];
            
        } else {
            
            [cell setCellWithEmployee:[employeeList objectAtIndex:indexPath.row] atIndex:indexPath];
            // Do ten Department vao LblDepartment
            [cell setCellWithDepartmentForAllEmployee:[employeeList objectAtIndex:indexPath.row]];
            
        }
    } else {
      
        [cell setCellWithEmployee:[employeeListInDepartment objectAtIndex:indexPath.row] atIndex:indexPath];
    }
    
    cell.delegate = self;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row % 2 == 0)
        
        cell.backgroundColor = [UIColor colorWithRed:18/255.f green:14/255.f blue:152/255.f alpha:0.1];
    else
        
        cell.backgroundColor = [UIColor colorWithRed:178/255.f green:14/255.f blue:12/255.f alpha:0.05];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tblEmployee deselectRowAtIndexPath:indexPath animated:YES];
}

// Neu la man hinh allEmployee thi kich thuoc cell tang len
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (allEmployee) {
        
        return 80;
    }
    return 50;
}

#pragma mark - TableViewCell's Delegate
- (void)tableViewCellEditAtIndex:(NSIndexPath *)index {
    
    [self getAllDepartmentEmployee];
    
    if (allEmployee) {
        if (isFiltered) {
            // Sua Employee trong man hinh all Search Employee
            if ([[ContentManager shareManager] editEmployee:[filteredEmployees objectAtIndex:index.row]]) {
                
                AddViewController *addView = [[AddViewController alloc] init];
                
                addView.isEmployee = YES;
                addView.editFlag = YES;
                addView.delegate = self;
                
                addView.inputEmployee = [filteredEmployees objectAtIndex:index.row];
                
                // tim departmentEmployee tuong ung voi employee de thay doi trong AddviewController
                addView.inputDepartmentEmployee = [allDepartmentEmployeeList objectAtIndex:[[ContentManager shareManager] getOneDepartmentEmployee:addView.inputEmployee]];
                
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
              
                // tim departmentEmployee tuong ung voi employee de thay doi trong AddviewController
                addView.inputDepartmentEmployee = [allDepartmentEmployeeList objectAtIndex:[[ContentManager shareManager] getOneDepartmentEmployee:addView.inputEmployee]];
                
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
            
            // tim departmentEmployee tuong ung voi employee de thay doi trong AddviewController
            addView.inputDepartmentEmployee = [allDepartmentEmployeeList objectAtIndex:[[ContentManager shareManager] getOneDepartmentEmployee:addView.inputEmployee]];
            
            [self.navigationController pushViewController:addView animated:YES];
        }
    }
}

- (void)tableViewCellDeleteAtIndex:(NSIndexPath *)index {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"削除の確認" message:@"本当に削除してもいいですか？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionDelete = [UIAlertAction actionWithTitle:@"はい" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self getAllEmployee];
        [self getAllDepartmentEmployee];

        if(self->allEmployee) {
            
            if(self->isFiltered){
                // Xoa Employee
                if ([[ContentManager shareManager] deleteEmployee:[self->filteredEmployees objectAtIndex:index.row]]) {
                    
                    [self->filteredEmployees removeObjectAtIndex:index.row];
                    
                    [self->tblEmployee beginUpdates];
                    
                    [self->tblEmployee deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationLeft];
                    
                    [self->tblEmployee endUpdates];
                    
                    [self->tblEmployee reloadData];
                }
                // Xoa DepartmentEmployee
                if ([[ContentManager shareManager] deleteDepartmentEmployee:[self->departmentEmployeeForSearch objectAtIndex:index.row]]) {
                    
                    [self->departmentEmployeeForSearch removeObjectAtIndex:index.row];
                    
                    [self->tblEmployee reloadData];
                }
            } else {
                // Xoa Employee
                if ([[ContentManager shareManager] deleteEmployee:[self->employeeList objectAtIndex:index.row]]) {
                    
                    [self->employeeList removeObjectAtIndex:index.row];
                    
                    [self->tblEmployee beginUpdates];
                    
                    [self->tblEmployee deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationLeft];
                    
                    [self->tblEmployee endUpdates];
                    
                    [self->tblEmployee reloadData];
                }
                // Xoa DepartmentEmployee
                if ([[ContentManager shareManager] deleteDepartmentEmployee:[self->allDepartmentEmployeeList objectAtIndex:index.row]]) {
                    
                    [self->allDepartmentEmployeeList removeObjectAtIndex:index.row];
                    
                    [self->tblEmployee reloadData];
                }
            }
            
        } else {
            // Xoa Employee
            if ([[ContentManager shareManager] deleteEmployee:[self->employeeListInDepartment objectAtIndex:index.row]]) {
                
                [self->employeeListInDepartment removeObjectAtIndex:index.row];
                
                [self->tblEmployee beginUpdates];
                
                [self->tblEmployee deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationLeft];
                
                [self->tblEmployee endUpdates];
                
                [self->tblEmployee reloadData];
            }
            // Xoa DepartmentEmployee
            if ([[ContentManager shareManager] deleteDepartmentEmployee:[self->departmentEmployeeList objectAtIndex:index.row]]) {
                
                [self->departmentEmployeeList removeObjectAtIndex:index.row];
                
                [self->tblEmployee reloadData];
            }
        }
    }];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"いいえ" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    [actionCancel setValue:[UIColor redColor] forKey:@"titleTextColor"];
    
    [alert addAction:actionDelete];
    [alert addAction:actionCancel];
    [self presentViewController:alert animated:YES completion:nil];
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
