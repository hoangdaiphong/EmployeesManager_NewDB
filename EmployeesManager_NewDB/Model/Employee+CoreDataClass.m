//
//  Employee+CoreDataClass.m
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/25.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//
//

#import "Employee+CoreDataClass.h"

@implementation Employee

//--------------------
- (void)awakeFromInsert {
    [super awakeFromInsert];
    
    static int employeeID = 1;
    
    self.employeeID = [NSString stringWithFormat:@"emp00%d", employeeID];
    
    employeeID += 1;
}
//--------------------
@end

