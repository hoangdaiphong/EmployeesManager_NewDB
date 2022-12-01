//
//  HomeView.m
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/30.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import "HomeView.h"

@implementation HomeView
@synthesize btnDepartment;
@synthesize btnEmployee;
@synthesize delegate;
@synthesize imgHomeLine;
@synthesize imgDepartmentLine;
@synthesize imgEmployeeLine;

- (instancetype)init {
    
    self = [[[NSBundle mainBundle] loadNibNamed:@"HomeView" owner:self options:nil] objectAtIndex:0];
    
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self setBackgroundColor:[UIColor whiteColor]];
}

- (void)setHomeView:(BOOL)hideHome hideDepartment:(BOOL)hideDepartment hideEmployee:(BOOL)hideEmployee {
    
    [self setFrame:CGRectMake(0, SCREEN_HEIGHT - self.bounds.size.height, SCREEN_WIDTH, self.bounds.size.height)];
    
    self.imgHomeLine.hidden = hideHome;
    self.imgDepartmentLine.hidden = hideDepartment;
    self.imgEmployeeLine.hidden = hideEmployee;
}

-(IBAction)homeAction:(id)sender {
  
    if (delegate != nil && [delegate respondsToSelector:@selector(homeViewPushRightActionHome)]) {
        
        [delegate homeViewPushRightActionHome];
    }
}

-(IBAction)employeeListAction:(id)sender {
    
    if (delegate != nil && [delegate respondsToSelector:@selector(homeViewPushRightActionEmployee)]) {
        
        [delegate homeViewPushRightActionEmployee];
    }
}

-(IBAction)departmentListAction:(id)sender {
    
    if (delegate != nil && [delegate respondsToSelector:@selector(homeViewPushRightActionDepartment)]) {
        
        [delegate homeViewPushRightActionDepartment];
    }
}
@end
