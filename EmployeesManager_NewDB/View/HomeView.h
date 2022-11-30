//
//  HomeView.h
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/30.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import <UIKit/UIKit.h>

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

@property (nonatomic, weak) id<HomeViewDelegate> delegate;

- (void)setHomeView;

@end

NS_ASSUME_NONNULL_END
