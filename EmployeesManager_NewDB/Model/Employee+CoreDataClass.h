//
//  Employee+CoreDataClass.h
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/25.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Employee : NSManagedObject

- (NSInteger)lastInsertID;

@end

NS_ASSUME_NONNULL_END

#import "Employee+CoreDataProperties.h"
