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

- (int)getIndexDepartmentInList:(Department *)department {
    
    NSManagedObjectContext *context = [self getCurrentContext];
    
    NSFetchRequest *request = [Department fetchRequest];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"departmentID" ascending:YES];
    
    request.sortDescriptors = @[sort];
    
    NSError *error = nil;
    
    NSArray *list = [context executeFetchRequest:request error:&error];
    
    Department *department2 = [[Department alloc] init];
    
    int i = 0;
    
    for (i = 0; i < list.count; i++) {
        
        department2 = list[i];
        
        NSString *department2ID = [[NSString alloc] init];
        
        department2ID = department2.departmentID;
        
        if (department2ID == department.departmentID) {
            
            break;
        }
    }
    return i;
}

- (Department *)getOneDepartmentForEmployee:(int)index {
    
    NSManagedObjectContext *context = [self getCurrentContext];
    
    NSFetchRequest *request = [Department fetchRequest];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"departmentID" ascending:YES];
    
    request.sortDescriptors = @[sort];
    
    NSError *error = nil;
    
    NSArray *list = [context executeFetchRequest:request error:&error];
    
    //-------------
    NSFetchRequest *request2 = [DepartmentEmployee fetchRequest];
    
    NSSortDescriptor *sort2 = [NSSortDescriptor sortDescriptorWithKey:@"employeeID" ascending:YES];
    
    request2.sortDescriptors = @[sort2];
    
    NSArray *list2 = [context executeFetchRequest:request2 error:&error];
    
    DepartmentEmployee *departmentEmployee = [[DepartmentEmployee alloc] init];
    
    departmentEmployee = list2[index];
    
    //-------------
    
    Department *department = [[Department alloc] init];
    
    for (int i = 0; i < list.count; i++) {
        
        department = list[i];
        
        NSString *departmentID = [[NSString alloc] init];
        
        departmentID = department.departmentID;
        
        if (departmentID == departmentEmployee.departmentID) {
            
            break;
        }
    }
    return department;
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

- (int)getOneDepartmentEmployee:(Employee *)employee {
    
    NSManagedObjectContext *context = [self getCurrentContext];
    
    NSFetchRequest *request = [DepartmentEmployee fetchRequest];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"employeeID" ascending:YES];
    
    request.sortDescriptors = @[sort];
    
    NSError *error = nil;
    
    NSArray *list = [context executeFetchRequest:request error:&error];
    
    DepartmentEmployee *departmentEmployee = [[DepartmentEmployee alloc] init];
    
    int i = 0;
    
    for (i = 0; i < list.count; i++) {
        
        departmentEmployee = list[i];
        
        NSString *employeeID = [[NSString alloc] init];
        
        employeeID = departmentEmployee.employeeID;
        
        if (employeeID == employee.employeeID) {

            break;
        }
    }
    return i;
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
