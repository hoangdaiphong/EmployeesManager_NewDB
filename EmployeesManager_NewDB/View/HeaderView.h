//
//  HeaderView.h
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/25.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HeaderViewDelegate <NSObject>
@optional
- (void)headerViewPushRightAction;

@end

@interface HeaderView : UIView <UISearchBarDelegate>

@property (nonatomic, weak) IBOutlet UILabel *lblTitle;
@property (nonatomic, weak) IBOutlet UIButton *btnBack;
@property (nonatomic, weak) IBOutlet UIButton *btnAdd;

@property (nonatomic, weak) UIViewController *currentController;

@property (nonatomic, weak) id<HeaderViewDelegate> delegate;

-(void)setHeaderWithTitle:(NSString *)title hideBack:(BOOL)hideBack hideAdd:(BOOL)hideAdd inController:(UIViewController *)controller;

@end

NS_ASSUME_NONNULL_END
