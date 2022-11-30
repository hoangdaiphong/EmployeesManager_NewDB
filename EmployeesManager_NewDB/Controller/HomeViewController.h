//
//  HomeViewController.h
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/30.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DepartmentViewController.h"
#import "EmployeeViewController.h"
#import "HomeView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView *img;

@property (nonatomic, weak) IBOutlet UIView *containView;

@end

NS_ASSUME_NONNULL_END
