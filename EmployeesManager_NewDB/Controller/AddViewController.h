//
//  AddViewController.h
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/25.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HeaderView.h"
#import "Department+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@protocol AddViewControllerDelegate <NSObject>

@optional
- (void)addViewControllerFinishWithSuccess:(BOOL)success;

@end

@interface AddViewController : UIViewController <HeaderViewDelegate> {

    NSMutableArray *departmentList;
    NSMutableArray *employeeList;
}

@property (nonatomic, weak) IBOutlet UIView *containView;
@property (nonatomic, weak) IBOutlet UITextField *txtName;
@property (nonatomic, weak) IBOutlet UIButton *btnSave;

@property (nonatomic, assign) BOOL editFlag;
@property (nonatomic, assign) BOOL isEmployee;

@property (nonatomic, weak) Department *inputDepartment;
@property (nonatomic, weak) Employee *inputEmployee;

@property (nonatomic, weak) id<AddViewControllerDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
