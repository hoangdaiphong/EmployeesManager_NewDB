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

//- (void)awakeFromInsert {
//    [super awakeFromInsert];
//    
//    static int employeeID = 1;
//    
//    self.employeeID = [NSString stringWithFormat:@"emp00%d", employeeID];
//    
//    employeeID += 1;
//}

- (void)awakeFromInsert {
    
    [super awakeFromInsert];
    
    self.employeeID = [NSString stringWithFormat:@"emp00%ld", [self __getMaxID] + 1];
}

- (NSInteger)__getMaxID {
    
    if(!self.managedObjectContext)return NSNotFound;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:self.entity.name];
    
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"employeeID" ascending:NO]];
    
    NSError *error = nil;
    
    NSArray *firstData = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];

    // Tach number ra khoi string
    Employee *employee = [[Employee alloc] init];
    employee = firstData[0];
    NSString *lastEmployeeID = employee.employeeID;
    NSString *numberOfEmployeeID;
    NSScanner *scanner = [NSScanner scannerWithString:lastEmployeeID];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
    [scanner scanCharactersFromSet:numbers intoString:&numberOfEmployeeID];
    long number = [numberOfEmployeeID integerValue];
    
    return number;
}

- (NSInteger)lastInsertID {
    
    return [self __getMaxID];
}
@end

