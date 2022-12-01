//
//  HeaderView.m
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/25.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

@synthesize lblTitle;
@synthesize btnAdd;
@synthesize btnBack;
@synthesize delegate;
@synthesize currentController;

- (instancetype)init {
    
    self = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:self options:nil] objectAtIndex:0];
    
    return self;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    [self setBackgroundColor:[UIColor colorWithRed:18/255.f green:14/255.f blue:152/255.f alpha:0.1]];
}

- (void)setHeaderWithTitle:(NSString *)title hideBack:(BOOL)hideBack hideAdd:(BOOL)hideAdd inController:(nonnull UIViewController *)controller {
    
    [lblTitle setText:title];
    
    [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.bounds.size.height)];
    
    [btnAdd setHidden:hideAdd];
    [btnBack setHidden:hideBack];
    
    currentController = controller;
}

- (IBAction)addAction:(id)sender {
    
    if (delegate != nil && [delegate respondsToSelector:@selector(headerViewPushRightAction)]) {
        
        [delegate headerViewPushRightAction];
    }
}

- (IBAction)backAction:(id)sender {
    
    [currentController.navigationController popViewControllerAnimated:YES];
}

@end
