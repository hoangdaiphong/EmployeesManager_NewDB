//
//  AppDelegate.h
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/25.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

/*
 
 1. Thiết lập môi trường CoreData: Thêm sửa xoá get
 
 2. Thiết lập màn hình Table View Department và truyền dữ liệu database vào cell hiển thị lên label ở cell
 
 3. Thêm 2 button back và add trên Navigation Bar
 
 4. Chuyển màn hình nhập tên Department khi ấn nút thêm
 
 5. Thêm textview nhập tên Department và nút add trên màn hình thêm Department, nhập tên Department và nhấn nút add thì chuyển sang màn hình hiển thị danh sách tên Department
 
 6. Thêm 2 button edit và delete trên cell ở màn hình Department, nhấn vào button delete thì tự động xoá cell đó
 
 7. Ở màn hình Department, khi ấn vào nút Edit trong cell hiện ra màn hình Edit có 1 textview và 1 button apply, nhập tên department cần sửa và ấn apply thì tự động chuyển đến màn hình Department và cập nhật tên Department mới
 
 8. Ở màn hình Department, khi ấn vào từng cell chuyển sang màn hình tableView Employee có thanh Navigation. Trên thanh Navigation có tiêu đề là Employee và 2 button là add và back
 
 9. Ở tableView Employee khi ấn vào button add sẽ hiện ra màn hình thêm có 1 text view và 1 button Add, nhập tên Employee sau khi ấn vào Add tự động sẽ chuyển sang TableView Employee và cập nhật tên Employee
 
 10. Thêm 2 button edit và delete trên cell ở màn hình Employee và thực hiện chức năng tương tự
 
 */
