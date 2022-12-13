//
//  AddViewController.m
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/25.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import "AddViewController.h"
#import "EmployeeViewController.h"

@interface AddViewController () <TableViewCellDelegate>

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
@synthesize inputDepartmentEmployee;
@synthesize tblNONE;
@synthesize isCheck;


-(void)viewWillAppear:(BOOL)animated {

    [self setupView];
}

-(void)viewDidAppear:(BOOL)animated {
    
    if(inputEmployee != nil) {
        
        int i = [[ContentManager shareManager] getOneDepartmentEmployee:inputEmployee];
        
        Department *department = [[Department alloc] init];
        
        department = [[ContentManager shareManager] getOneDepartmentForEmployee:i];
        
        int index = [[ContentManager shareManager] getIndexDepartmentInList:department];
        
        [txtDepartmentName setText: department.departmentName];
        
        [pickerView selectRow:index inComponent:0 animated:YES];
        //vi tri bat dau trong pickerView gan cho inputDepartment 
        inputDepartment = department;
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)setupView {
    
    [containView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    containView.backgroundColor = [UIColor colorWithRed:178/255.f green:14/255.f blue:12/255.f alpha:0.05];
    
    HeaderView *header = [[HeaderView alloc] init];
    //--------
    [lblDepartment setHidden:YES];
    [lblEmploye setHidden:YES];
    [txtDepartmentName setHidden:YES];
    [pickerView setHidden:YES];

    tblNONE.layer.borderWidth = 2.0;
    tblNONE.layer.borderColor = [UIColor colorWithRed:18/255.f green:14/255.f blue:152/255.f alpha:0.1].CGColor;
    tblNONE.layer.cornerRadius = 20;
    [tblNONE registerNib:[UINib nibWithNibName:NSStringFromClass([TableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Cell"];
    tblNONE.backgroundColor = [UIColor colorWithRed:18/255.f green:14/255.f blue:152/255.f alpha:0.1];
    tblNONE.dataSource = self;
    tblNONE.delegate = self;
    tblNONE.separatorColor = [UIColor clearColor];
    //-------
    if (editFlag) {
        
        if (isEmployee) {
            
            [header setHeaderWithTitle:@"社員を編集" hideBack:NO hideAdd:YES inController:self];
            
            [txtName setText:[inputEmployee employeeName]];
        } else {
            
            [header setHeaderWithTitle:@"部署を編集" hideBack:NO hideAdd:YES inController:self];
            
            [txtName setText:[inputDepartment departmentName]];
            //--------
            [tblNONE setHidden:YES];
            [txtName setHidden:NO];
            //--------
        }
    } else {
        
        if (isEmployee) {
            
            [header setHeaderWithTitle:@"社員を追加" hideBack:NO hideAdd:YES inController:self];
            //An txtName neu trong man hinh them Employee tu NONE va hien tblNONE
            [txtName setHidden:YES];
            [tblNONE setHidden:NO];
        } else {
            
            [header setHeaderWithTitle:@"部署を追加" hideBack:NO hideAdd:YES inController:self];
            
            txtName.placeholder = @"部署名";
            // An tblNONE
            [tblNONE setHidden:YES];
        }
    }
    header.delegate = self;
    [containView addSubview:header];
    
//    [lblDepartment setHidden:YES];
//    [lblEmploye setHidden:YES];
//    [txtDepartmentName setHidden:YES];
//    [pickerView setHidden:YES];
    
    if(isEmployee && (editFlag || allEmployee)) {
        // Neu them Employee
        [txtDepartmentName setHidden: NO];
        [pickerView setHidden: NO];
        
        [lblDepartment setHidden:NO];
        [lblEmploye setHidden:NO];
        txtDepartmentName.placeholder = @"NONE";
        
        [txtDepartmentName setFrame:CGRectMake(48, 223, 278, 30)];
        [pickerView setFrame:CGRectMake(50, 246, 278, 216)];
        [btnSave setFrame:CGRectMake(170, 463, 50, 50)];
        
        // Hien txtName va an tblNONE
        [txtName setHidden:NO];
        txtName.placeholder = @"社員名";
        [tblNONE setHidden:YES];
        
        pickerView.dataSource = self;
        pickerView.delegate = self;
    }
    // Cau hinh tblNONE
//    tblNONE.layer.borderWidth = 2.0;
//    tblNONE.layer.borderColor = [UIColor colorWithRed:18/255.f green:14/255.f blue:152/255.f alpha:0.1].CGColor;
//    tblNONE.layer.cornerRadius = 20;
//    [tblNONE registerNib:[UINib nibWithNibName:NSStringFromClass([TableViewCell class]) bundle:nil] forCellReuseIdentifier:@"Cell"];
//    tblNONE.dataSource = self;
//    tblNONE.delegate = self;
//    tblNONE.separatorColor = [UIColor clearColor];
    
    [self getData];
}

- (void)getData {
    
    [self getAllDepartment];
    
    [self getEmployeeOfNONE];
    
    [self getBoolArrayforEmployeeNONE];
}

- (void)getAllDepartment {
    
    departmentList = [[NSMutableArray alloc] init];
    
    [departmentList addObjectsFromArray:[[ContentManager shareManager] getAllDepartment]];
    
    employeeList = [[NSMutableArray alloc] init];
    
    [employeeList addObjectsFromArray:[[ContentManager shareManager] getAllEmployee]];
}

- (void)getEmployeeOfNONE {
    
    Department *department = [[Department alloc] init];
    
    department = departmentList[0];
    
    NSMutableArray *departmentEmployee = [[NSMutableArray alloc] init];
    
    [departmentEmployee addObjectsFromArray:[[ContentManager shareManager] getDepartmentEmployee:department.departmentID]];
    
    employeeListOfNONE = [[NSMutableArray alloc] init];
    
    [employeeListOfNONE addObjectsFromArray:[[ContentManager shareManager] getEmployeeInDepartment:departmentEmployee]];
}
   //--------
- (void)getBoolArrayforEmployeeNONE {
    
    boolArrayforEmployeeNONE = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < employeeListOfNONE.count; i++) {
        
        [boolArrayforEmployeeNONE addObject:[NSNumber numberWithBool:NO]];
    }
}

- (IBAction)addAction:(id)sender {
    
    // Kiem tra xem da check hay chua, check roi thi update va chuyen man hinh
    for (int i = 0; i < boolArrayforEmployeeNONE.count; i++) {
        
        NSNumber *checked = [NSNumber numberWithBool:YES];
        
        if (boolArrayforEmployeeNONE[i] == checked) {
            
            isCheck = YES;
            break;
        }
    }
   
    if (isCheck) {
        
        BOOL success = false;
        
        employeeListAddFromNONE = [[NSMutableArray alloc] init];
        departmentEmployeeListAddFromNONE = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < boolArrayforEmployeeNONE.count; i++) {
            
            NSNumber *checked = [NSNumber numberWithBool:YES];
            
            if (boolArrayforEmployeeNONE[i] == checked) {
                
                [employeeListAddFromNONE addObject: employeeListOfNONE[i]];
            }
        }
        
        [departmentEmployeeListAddFromNONE addObjectsFromArray:[[ContentManager shareManager] getDepartmentEmployeeForSearch:employeeListAddFromNONE]];
        
        DepartmentEmployee *departmentEmployee = [[DepartmentEmployee alloc] init];
        
        for (int i = 0; i < departmentEmployeeListAddFromNONE.count; i++) {
            
            departmentEmployee = departmentEmployeeListAddFromNONE[i];
            
            departmentEmployee.departmentID = inputDepartment.departmentID;
            
            success = [[ContentManager shareManager] editDepartmentEmployee:departmentEmployee];
        }
        
        if (delegate != nil && [delegate respondsToSelector:@selector(addViewControllerFinishWithSuccess:)]) {
            
            [delegate addViewControllerFinishWithSuccess:success];
        }
        
        // Hieu ung
        [self addAnimation];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [NSThread sleepForTimeInterval:0.3f];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.navigationController popViewControllerAnimated:YES];
            });
        });
    }

    // Neu khong phai la man hinh update NONE sang Department khac
    if ([[txtName text] length] > 0) {
        
        BOOL success = false;
        
        if (editFlag) {
          
            if (isEmployee) {
                // Sua Employee
                inputEmployee.employeeName = [txtName text];
                
                success = [[ContentManager shareManager] editEmployee:inputEmployee];
                // Sua EmployeeDepartment
                inputDepartmentEmployee.departmentID = inputDepartment.departmentID;
                
                success = [[ContentManager shareManager] editDepartmentEmployee:inputDepartmentEmployee];
            } else {
                
                inputDepartment.departmentName = [txtName text];
                
                success = [[ContentManager shareManager] editDepartment:inputDepartment];
            }
        } else {
            
            if (isEmployee) {
            
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
                        
                        success = [[ContentManager shareManager] insertDepartmentEmployee:@"Adep000" employeeID:employee.employeeID];
                    }
                } else {
                  
//                    // Neu la danh sach Employee trong department
//                    success = [[ContentManager shareManager] insertEmployeeWithName:txtName.text];
//                    // Them DepartmentEmployee
//                    [self getData];
//
//                    Employee *employee = [[Employee alloc] init];
//
//                    employee = employeeList[employeeList.count - 1];
//
//                    success = [[ContentManager shareManager] insertDepartmentEmployee:inputDepartment.departmentID employeeID:employee.employeeID];
                }
                
            } else {
                
                success = [[ContentManager shareManager] insertDepartmentWithName:txtName.text];
            }
        }
        
        if (delegate != nil && [delegate respondsToSelector:@selector(addViewControllerFinishWithSuccess:)]) {
            
            [delegate addViewControllerFinishWithSuccess:success];
        }
       
        // Hieu ung
        [self addAnimation];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [NSThread sleepForTimeInterval:0.3f];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.navigationController popViewControllerAnimated:YES];
            });
        }); 
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

#pragma mark - TableView's Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return employeeListOfNONE.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = [self.tblNONE dequeueReusableCellWithIdentifier:@"Cell"];
    
    [cell setCellWithEmployee:[employeeListOfNONE objectAtIndex:indexPath.row] atIndex:indexPath];
    
    [cell setHiddenButtonInCell:YES deleteButton:YES checkButton:NO];
    
    cell.delegate = self;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self.tblNONE deselectRowAtIndexPath:indexPath animated:YES];
}

// Ham lay chuoi array da duoc check
- (void)tableViewCellCheckAtIndex:(NSIndexPath *)index isCheck:(BOOL)isCheck {

    Employee *employee = [[Employee alloc] init];
    
    employee = [employeeListOfNONE objectAtIndex:index.row];

    [boolArrayforEmployeeNONE replaceObjectAtIndex:index.row withObject:[NSNumber numberWithBool:isCheck]];

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row % 2 == 0)
        
        cell.backgroundColor = [UIColor colorWithRed:18/255.f green:14/255.f blue:152/255.f alpha:0.05];
    else
        
        cell.backgroundColor = [UIColor colorWithRed:178/255.f green:14/255.f blue:12/255.f alpha:0.05];
}

- (void)addAnimation {
    
    UIImageView* animatedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        
        animatedImageView.animationImages = [NSArray arrayWithObjects:
                                             [UIImage imageNamed:@"a1.png"],
                                             [UIImage imageNamed:@"a2.png"],
                                             [UIImage imageNamed:@"a3.png"],
                                             [UIImage imageNamed:@"a4.png"],
                                             [UIImage imageNamed:@"a5.png"],
                                             [UIImage imageNamed:@"a5.png"],
                                             [UIImage imageNamed:@"a7.png"],nil];
        
        animatedImageView.animationDuration = 0.1f;
        animatedImageView.animationRepeatCount = 1;
        [animatedImageView startAnimating];
        [animatedImageView setImage:[UIImage imageNamed:@"a7.png"]];

        [self.btnSave addSubview: animatedImageView];
}

@end
