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
//- (void)awakeFromInsert {
//
//    [super awakeFromInsert];
//
//    self.employeeID = [NSString stringWithFormat:@"emp00%ld",[self __getMaxID]];
//}
//
//- (NSInteger)__getMaxID {
//
//    return [[ContentManager shareManager] getAllEmployee].count;
//}
- (void)awakeFromInsert {
    [super awakeFromInsert];
    
    self.employeeID = [NSString stringWithFormat:@"emp00%ld",[self __getMaxID]+1];
}

- (NSString *)__getMaxID {
    if(!self.managedObjectContext)return NSNotFound;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:self.entity.name];
    
    fetchRequest.fetchLimit = 1;
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"employeeID" ascending:NO]];
    
    NSError *error = nil;
    
    Employee *employee = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error].firstObject;
    
    return employee.employeeName;
}

- (NSInteger)lastInsertID {
    return [self __getMaxID];
}
//--------------------

@end

