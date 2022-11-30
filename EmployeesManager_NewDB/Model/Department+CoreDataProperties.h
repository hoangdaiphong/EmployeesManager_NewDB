//
//  Department+CoreDataProperties.h
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/25.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//
//

#import "Department+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Department (CoreDataProperties)

+ (NSFetchRequest<Department *> *)fetchRequest;

@property (nonatomic) NSString *departmentID;
@property (nullable, nonatomic, copy) NSString *departmentName;

@end

NS_ASSUME_NONNULL_END
