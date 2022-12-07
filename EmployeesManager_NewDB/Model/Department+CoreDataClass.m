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

- (void)awakeFromInsert {
    
    [super awakeFromInsert];
    
    self.departmentID = [NSString stringWithFormat:@"dep00%ld", [self __getMaxID] + 1];
}

- (NSInteger)__getMaxID {
    
    if(!self.managedObjectContext)return NSNotFound;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:self.entity.name];
    
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"departmentID" ascending:NO]];
    
    NSError *error = nil;
    
    NSArray *firstData = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    // Tach number ra khoi string
    Department *department = [[Department alloc] init];
    department = firstData[0];
    NSString *lastDepartmentID = department.departmentID;
    NSString *numberOfDepartmentID;
    NSScanner *scanner = [NSScanner scannerWithString:lastDepartmentID];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
    [scanner scanCharactersFromSet:numbers intoString:&numberOfDepartmentID];
    long number = [numberOfDepartmentID integerValue];
    
    return number;
}

- (NSInteger)lastInsertID {
    
    return [self __getMaxID];
}
@end
