//
//  ContentManager.m
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/25.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import "ContentManager.h"
#import "AppDelegate.h"

@implementation ContentManager

+ (ContentManager *)shareManager {
    
    static ContentManager *manager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[ContentManager alloc] init];
    });
    
    return manager;
}

- (NSManagedObjectContext *)getCurrentContext {
    
    AppDelegate *application = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    return  application.persistentContainer.viewContext;
}

#pragma mark - Department
- (BOOL)insertDepartmentWithName:(NSString *)name {
    
    NSManagedObjectContext *context = [self getCurrentContext];
    
    Department *department = [NSEntityDescription insertNewObjectForEntityForName:@"Department" inManagedObjectContext:context];
    
    department.departmentName = name;
    
    NSError *error = nil;
    
    if (![context save:&error]) {
        
        return  NO;
    } else {
        
        return YES;
    }
}

- (BOOL)insertDepartment:(NSString *)name departmentID:(NSString *)departmentID {
    
    NSManagedObjectContext *context = [self getCurrentContext];
    
    Department *department = [NSEntityDescription insertNewObjectForEntityForName:@"Department" inManagedObjectContext:context];
    
    department.departmentName = name;
    
    department.departmentID = departmentID;
    
    NSError *error = nil;
    
    if (![context save:&error]) {
        
        return  NO;
    } else {
        
        return YES;
    }
}

- (BOOL)deleteDepartment:(Department *)department {
    
    NSManagedObjectContext *context = [self getCurrentContext];
    
    [context deleteObject:department];
    
    NSError *error = nil;
    
    if (![context save:&error]) {
        
        return  NO;
    } else {
        
        return YES;
    }
}

- (BOOL)editDepartment:(Department *)department {
    
    if (department != nil) {
        
        NSManagedObjectContext *context = [self getCurrentContext];
        
        NSError *error = nil;
        
        if (![context save:&error]) {
            
            return  NO;
        } else {
            
            return YES;
        }
    } else {
        
        return NO;
    }
}

- (NSArray *)getAllDepartment {
    
    NSManagedObjectContext *context = [self getCurrentContext];
    
    NSFetchRequest *request = [Department fetchRequest];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"departmentID" ascending:YES];
    
    request.sortDescriptors = @[sort];
    
    NSError *error = nil;
    
    NSArray *list = [context executeFetchRequest:request error:&error];
    
    return list;
}

#pragma mark - Employee
- (BOOL)insertEmployee:(NSString *)name employeeID:(NSString *)employeeID {
    
    NSManagedObjectContext *context = [self getCurrentContext];
    
    Employee *employee = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:context];
    
    employee.employeeName = name;
    employee.employeeID = employeeID;
    
    NSError *error = nil;
    
    if (![context save:&error]) {
        
        return  NO;
    } else {
        
        return YES;
    }
}

- (BOOL)insertEmployeeWithName:(NSString *)name {
    
    NSManagedObjectContext *context = [self getCurrentContext];
    
    Employee *employee = [NSEntityDescription insertNewObjectForEntityForName:@"Employee" inManagedObjectContext:context];
    
    employee.employeeName = name;
    
    NSError *error = nil;
    
    if (![context save:&error]) {
        
        return  NO;
    } else {
        
        return YES;
    }
}

- (BOOL)deleteEmployee:(Employee *)employee {
    
    NSManagedObjectContext *context = [self getCurrentContext];
    
    [context deleteObject:employee];
    
    NSError *error = nil;
    
    if (![context save:&error]) {
        
        return  NO;
    } else {
        
        return YES;
    }
}

- (BOOL)editEmployee:(Employee *)employee {
    
    if (employee != nil) {
        
        NSManagedObjectContext *context = [self getCurrentContext];
        
        NSError *error = nil;
        
        if (![context save:&error]) {
            
            return  NO;
        } else {
            
            return YES;
        }
    } else {
        
        return NO;
    }
}

- (NSArray *)getEmployeeInDepartment:(NSArray *)departmentEmployeeList {
    
    NSManagedObjectContext *context = [self getCurrentContext];
    
    NSFetchRequest *request = [Employee fetchRequest];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"employeeID" ascending:YES];
    
    request.sortDescriptors = @[sort];
    
    NSError *error = nil;
    
    NSArray *list = [context executeFetchRequest:request error:&error];
    
    NSMutableArray *list2 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < departmentEmployeeList.count; i++) {
        
        DepartmentEmployee *departmentEmployee = [[DepartmentEmployee alloc] init];
        
        departmentEmployee = departmentEmployeeList[i];
        
        for(int j = 0; j < list.count; j++) {
            
            Employee *employee = [[Employee alloc] init];
            
            employee = list[j];
            
            if (departmentEmployee.employeeID == employee.employeeID) {
                
                [list2 addObject:employee];
                
                break;
            }
        }
    }
    return list2;
}

- (NSArray *)getAllEmployee {
    
    NSManagedObjectContext *context = [self getCurrentContext];
    
    NSFetchRequest *request = [Employee fetchRequest];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"employeeID" ascending:YES];
    
    request.sortDescriptors = @[sort];
    
    NSError *error = nil;
    
    NSArray *list = [context executeFetchRequest:request error:&error];
    
    return list;
}

- (NSArray *)searchEmployee:(NSString *)employeeName {
    
    NSManagedObjectContext *context = [self getCurrentContext];
    
    NSFetchRequest *request = [Employee fetchRequest];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"employeeName contains %@", employeeName];
    
    [request setPredicate:predicate];
    
    NSError *error = nil;
    
    NSArray *list = [context executeFetchRequest:request error:&error];
    
    return list;
}

#pragma mark - DepartmentEmployee
- (BOOL)insertDepartmentEmployee:(NSString *)departmentID {
    
    NSManagedObjectContext *context = [self getCurrentContext];
    
    DepartmentEmployee *departmentEmployee = [NSEntityDescription insertNewObjectForEntityForName:@"DepartmentEmployee" inManagedObjectContext:context];
    
    departmentEmployee.departmentID = departmentID;
    
    NSError *error = nil;
    
    if (![context save:&error]) {
        
        return  NO;
    } else {
        
        return YES;
    }
}

- (BOOL)insertDepartmentEmployee:(NSString *)departmentID employeeID:(NSString *)employeeID{
    
    NSManagedObjectContext *context = [self getCurrentContext];
    
    DepartmentEmployee *departmentEmployee = [NSEntityDescription insertNewObjectForEntityForName:@"DepartmentEmployee" inManagedObjectContext:context];
    
    departmentEmployee.departmentID = departmentID;
    
    departmentEmployee.employeeID = employeeID;
    
    NSError *error = nil;
    
    if (![context save:&error]) {
        
        return  NO;
    } else {
        
        return YES;
    }
}

- (BOOL)editDepartmentEmployee:(DepartmentEmployee *)departmentEmployee {
    
    if (departmentEmployee != nil) {
        
        NSManagedObjectContext *context = [self getCurrentContext];
        
        NSError *error = nil;
        
        if (![context save:&error]) {
            
            return  NO;
        } else {
            
            return YES;
        }
    } else {
        
        return NO;
    }
}

- (BOOL)deleteDepartmentEmployee:(DepartmentEmployee *)departmentEmployee {
    
    NSManagedObjectContext *context = [self getCurrentContext];
    
    [context deleteObject:departmentEmployee];
    
    NSError *error = nil;
    
    if (![context save:&error]) {
        
        return  NO;
    } else {
        
        return YES;
    }
}

- (NSArray *)getDepartmentEmployee:(NSString *)departmentID {
    
    NSManagedObjectContext *context = [self getCurrentContext];
    
    NSFetchRequest *request = [DepartmentEmployee fetchRequest];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"employeeID" ascending:YES];
    
    request.sortDescriptors = @[sort];
    
    NSError *error = nil;
    
    NSArray *list = [context executeFetchRequest:request error:&error];
    
    NSMutableArray *list2 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < list.count; i++) {
        
        DepartmentEmployee *departmentEmployee = [[DepartmentEmployee alloc] init];
        
        departmentEmployee = list[i];
        
        if (departmentEmployee.departmentID == departmentID) {
            
            [list2 addObject:departmentEmployee];
            
        }
    }
    
    return list2;
}

- (NSArray *)getDepartmentEmployeeForSearch:(NSArray *)employeeList {
    
    NSManagedObjectContext *context = [self getCurrentContext];
    
    NSFetchRequest *request = [DepartmentEmployee fetchRequest];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"employeeID" ascending:YES];
    
    request.sortDescriptors = @[sort];
    
    NSError *error = nil;
    
    NSArray *list = [context executeFetchRequest:request error:&error];
    
    NSMutableArray *list2 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < employeeList.count; i++) {
        
        Employee *employee = [[Employee alloc] init];
        
        employee = employeeList[i];
        
        NSString *employeeID = [[NSString alloc] init];
        
        employeeID = employee.employeeID;
        
        for (int j = 0; j < list.count; j++) {
            
            DepartmentEmployee *departmentEmployee = [[DepartmentEmployee alloc] init];
            
            departmentEmployee = list[j];
            
            NSString *departmentEmployeeID = [[NSString alloc] init];
            
            departmentEmployeeID = departmentEmployee.employeeID;
            
            if (departmentEmployeeID == employeeID) {
                
                [list2 addObject:departmentEmployee];
                
                break;
            }
        }
    }
    return list2;
}

- (NSArray *)getAllDepartmentEmployee {
    
    NSManagedObjectContext *context = [self getCurrentContext];
    
    NSFetchRequest *request = [DepartmentEmployee fetchRequest];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"employeeID" ascending:YES];
    
    request.sortDescriptors = @[sort];
    
    NSError *error = nil;
    
    NSArray *list = [context executeFetchRequest:request error:&error];
    
    return list;
}

@end
