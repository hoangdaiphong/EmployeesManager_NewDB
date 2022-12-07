//
//  HomeViewController.m
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/30.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()<HomeViewDelegate>

@end

@implementation HomeViewController
@synthesize containView;

- (void)viewWillAppear:(BOOL)animated {
    
//    NSArray<NSString *> *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
//    NSLog(@"%@", dirPaths);
    
    // Them vao database Department none
    NSMutableArray *listDepartment = [[NSMutableArray alloc] init];
    
    [listDepartment addObjectsFromArray:[[ContentManager shareManager] getAllDepartment]];
    
    BOOL check = NO;
    
    Department *department = [[Department alloc] init];
    
    for (int i = 0; i < listDepartment.count; i++) {
        
        department = listDepartment[i];
        
        NSString *departmentID = department.departmentID;
        
        if ([departmentID isEqualToString:@"Adep000"]) {
            
            check = YES;
            break;
        }
    }
    if (!check) {
        
        [[ContentManager shareManager] insertDepartment:@"NONE" departmentID:@"Adep000"];
    }
    
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupView];
    
    [[JSON_Manger parseJSON] parseJSONDepartment];
    [[JSON_Manger parseJSON] parseJSONEmployee];
}

- (void)setupView {
    
    [containView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [containView setBackgroundColor:[UIColor colorWithRed:18/255.f green:14/255.f blue:152/255.f alpha:0.1]];

    UIImageView *myImage = [[UIImageView alloc] initWithFrame:CGRectMake(-20, 122, 405, 506)];
    myImage.image = [UIImage imageNamed:@"company.jpg"];
    [containView addSubview:myImage];

    HomeView *homeView = [[HomeView alloc] init];
    [homeView setHomeView:NO hideDepartment:YES hideEmployee:YES];
    homeView.delegate = self;
    [containView addSubview:homeView];
}

#pragma HomeView delegate

- (void)homeViewPushRightActionEmployee {
    
    EmployeeViewController *employeeViewController = [[EmployeeViewController alloc] init];
    
    [self.navigationController pushViewController:employeeViewController animated:YES];
    
    employeeViewController.allEmployee = YES;
    
    employeeViewController.allEmployeeTitle = YES;
}

- (void)homeViewPushRightActionDepartment {
    
    DepartmentViewController *departmentViewController = [[DepartmentViewController alloc] init];
    
    [self.navigationController pushViewController:departmentViewController animated:YES];
}
@end
