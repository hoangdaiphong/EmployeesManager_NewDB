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
    
    static int departmentID = 1;
    
    self.departmentID = [NSString stringWithFormat:@"dep00%d", departmentID];
    
    departmentID += 1;
    
}
//
//- (NSInteger)__getMaxID {
//
//    return [[ContentManager shareManager] getAllDepartment].count;
//}
//--------------------

@end
