//
//  HomeView.h
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/30.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmployeeViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol HomeViewDelegate <NSObject>

@optional
- (void)homeViewPushRightActionHome;
- (void)homeViewPushRightActionDepartment;
- (void)homeViewPushRightActionEmployee;
@end

@interface HomeView : UIView

@property (nonatomic, weak) IBOutlet UIButton *btnDepartment;
@property (nonatomic, weak) IBOutlet UIButton *btnEmployee;

@property (weak, nonatomic) IBOutlet UIImageView *imgHomeLine;
@property (weak, nonatomic) IBOutlet UIImageView *imgDepartmentLine;
@property (weak, nonatomic) IBOutlet UIImageView *imgEmployeeLine;

@property (nonatomic, weak) id<HomeViewDelegate> delegate;

- (void)setHomeView:(BOOL)hideHome hideDepartment:(BOOL)hideDepartment hideEmployee:(BOOL)hideEmployee;

@end

NS_ASSUME_NONNULL_END
