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
    
    self.employeeID = [NSString stringWithFormat:@"emp00%ld",[self __getMaxID]];
}

- (NSInteger)__getMaxID {
    
    return [[ContentManager shareManager] getAllEmployee].count;
}
//--------------------

@end

