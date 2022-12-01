//
//  JSON_Manger.m
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/12/01.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import "JSON_Manger.h"

@implementation JSON_Manger

+ (JSON_Manger *)parseJSON {
    
    static JSON_Manger *manager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[JSON_Manger alloc] init];
    });
    
    return manager;
}

#pragma parseJSON
- (void)parseJSONDepartment {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *jsonError;
    
    id allKeys = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
    
    NSArray *arrDepartmentJSON = [allKeys objectForKey:@"department"];
    
    for (int i = 0; i < arrDepartmentJSON.count; i++) {

        NSDictionary *departmentJSON = arrDepartmentJSON[i];
        
        NSString *departmentIDJSON = [departmentJSON objectForKey:@"departmentID"];

        NSString *departmentNameJSON = [departmentJSON objectForKey:@"departmentName"];
        
        if (![self checkDepartment:departmentIDJSON]) {
            
            [[ContentManager shareManager] insertDepartment:departmentNameJSON departmentID:departmentIDJSON];
        }
    }
}

- (void)parseJSONEmployee {

    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];

    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];

    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];

    NSError *jsonError;

    id allKeys = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];

    NSArray *arrDepartmentJSON = [allKeys objectForKey:@"department"];

    for (int i = 0 ; i < arrDepartmentJSON.count; i++) {

        NSDictionary *departmentJSON = arrDepartmentJSON[i];

        NSString *departmentIDJSON = [departmentJSON objectForKey:@"departmentID"];

        NSArray *arrEmployeeJSON = [departmentJSON objectForKey:@"employee"];

        for (int j = 0; j < arrEmployeeJSON.count; j++) {

            NSDictionary *employeeJSON = arrEmployeeJSON[j];

            NSString *employeeIDJSON = [employeeJSON objectForKey:@"employeeID"];

            NSString *employeeNameJSON = [employeeJSON objectForKey:@"employeeName"];
            
            if (![self checkEmployee:employeeIDJSON]) {
                
                [[ContentManager shareManager] insertEmployee:employeeNameJSON employeeID:employeeIDJSON];
                [[ContentManager shareManager] insertDepartmentEmployee:departmentIDJSON employeeID:employeeIDJSON];
            }
        }
    }
}

#pragma check exist
- (BOOL)checkDepartment:(NSString *)departmentID {
    
    NSMutableArray *listDepartmentForCheck = [[NSMutableArray alloc] init];
    
    [listDepartmentForCheck addObjectsFromArray:[[ContentManager shareManager] getAllDepartment]];
    
    for (int i = 0; i < listDepartmentForCheck.count; i++) {
        
        Department *departmentObject = listDepartmentForCheck[i];
        
        if ([departmentID isEqualToString:departmentObject.departmentID]) return YES;
    }
    return NO;
}

- (BOOL)checkEmployee:(NSString *)employeeID {
    
    NSMutableArray *listEmployeeForCheck = [[NSMutableArray alloc] init];
    
    [listEmployeeForCheck addObjectsFromArray:[[ContentManager shareManager] getAllEmployee]];
    
    for (int i = 0; i < listEmployeeForCheck.count; i++) {

        Employee *employeeObject = listEmployeeForCheck[i];

        if ([employeeID isEqualToString:employeeObject.employeeID]) return YES;
    }
    return NO;
}
@end
