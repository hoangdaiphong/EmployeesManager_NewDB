//
//  DepartmentEmployee+CoreDataProperties.h
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/25.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//
//

#import "DepartmentEmployee+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DepartmentEmployee (CoreDataProperties)

+ (NSFetchRequest<DepartmentEmployee *> *)fetchRequest;

@property (nonatomic) NSString* departmentID;
@property (nonatomic) NSString* employeeID;

@end

NS_ASSUME_NONNULL_END
