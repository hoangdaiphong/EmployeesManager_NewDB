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

/*
 1. CoreData（コアデータ） 環境のセットアップ(setup): 挿入(インサート）、編集(アップデート)、削除(デリート)、選択（セレクト）
 2. ラベル 部署(Label Department)というタイトルのナビゲーション バーを含む テーブルビュー部署(Table View Department)画面を設定します
 3. ナビゲーション バーに 2 つのバックボタン(Back button)と追加ボタン(Add button)を挿入します
 4. テーブルビュー部署の追加ボタンを押すと新規部署名入力画面に遷移
 5. 部署追加画面に部署名を入力するテキストビューと追加ボタンを追加し、部署を追加してボタンを押すと、部署名の一覧を表示する画面に遷移
 6. 部署画面のセルに 2 つの編集ボタンと削除ボタンを追加し、削除ボタンをタッチするとそのセルを自動的に削除します
 7. 部署画面のセルで、編集ボタンを押すと編集画面が表示され、1 つのテキストビューと 1 つの適用ボタン(Apply Button)が表示されます。編集する部署名を入力して適用ボタン押すと、自動的に部署画面に移動し、新しい部署名が更新されます
 8. 部署画面で、各セルをタッチすると、ナビゲーション バーのある Employee（社員） テーブル ビュー画面に遷移。ナビゲーション バーでは、タイトルは 社員 で、2 つのボタン：追加と戻るがある
 9. 社員(Employee)テーブルビューで追加ボタンをタッチすると、1 つのテキストビューと 1 つの追加ボタンがある画面が表示され、テーブルビューに新規社員名を入力してボタンを押すと、社員名の一覧を表示する画面に戻って、社員名が更新されます
 10. 社員画面のセルに2つの編集ボタンと削除ボタンを追加し、部署画面の中に二つボタンと同じ機能を実行します    

 */
