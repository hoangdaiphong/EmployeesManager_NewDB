//
//  ContentManager.h
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/25.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Employee+CoreDataClass.h"
#import "Department+CoreDataClass.h"
#import "DepartmentEmployee+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface ContentManager : NSObject

+ (ContentManager *)shareManager;

#pragma mark - Department
- (NSManagedObjectContext *)getCurrentContext;

- (BOOL)insertDepartmentWithName:(NSString *)name;

- (BOOL)insertDepartment:(NSString *)name departmentID:(NSString *)departmentID;

- (BOOL)deleteDepartment:(Department *)department;

- (BOOL)editDepartment:(Department *)department;

- (NSArray *)getAllDepartment;

#pragma mark - Employee
- (NSArray *)getAllEmployee;

- (BOOL)insertEmployeeWithName:(NSString *)name;

- (BOOL)insertEmployee:(NSString *)name employeeID:(NSString *)employeeID;

- (BOOL)deleteEmployee:(Employee *)employee;

- (BOOL)editEmployee:(Employee *)employee;

- (NSArray *)getEmployeeInDepartment:(NSArray *)departmentEmployeeList;

- (NSArray *)searchEmployee:(NSString *)employeeName;

#pragma mark - DepartmentEmployee
- (BOOL)insertDepartmentEmployee:(NSString *)departmentID;

- (BOOL)insertDepartmentEmployee:(NSString *)departmentID employeeID:(NSString *)employeeID;

- (BOOL)editDepartmentEmployee:(DepartmentEmployee *)departmentEmployee;

- (BOOL)deleteDepartmentEmployee:(DepartmentEmployee *)departmentEmployee;

- (NSArray *)getDepartmentEmployee:(NSString *)departmentID;

- (NSArray *)getAllDepartmentEmployee;

@end

NS_ASSUME_NONNULL_END
