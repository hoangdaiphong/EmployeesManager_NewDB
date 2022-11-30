//
//  Department+CoreDataClass.m
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/25.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//
//

#import "Department+CoreDataClass.h"

@implementation Department

//--------------------
- (void)awakeFromInsert {
    
    [super awakeFromInsert];
    
    self.departmentID = [NSString stringWithFormat:@"dep00%ld",[self __getMaxID]];
}

- (NSInteger)__getMaxID {
    
    return [[ContentManager shareManager] getAllDepartment].count;
}
//--------------------

@end
