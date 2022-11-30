//
//  DepartmentEmployee+CoreDataProperties.m
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/25.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//
//

#import "DepartmentEmployee+CoreDataProperties.h"

@implementation DepartmentEmployee (CoreDataProperties)

+ (NSFetchRequest<DepartmentEmployee *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"DepartmentEmployee"];
}

@dynamic departmentID;
@dynamic employeeID;

@end
