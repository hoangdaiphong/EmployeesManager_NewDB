//
//  TableViewCell.h
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/11/25.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Department+CoreDataClass.h"
#import "Employee+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TableViewCellDelegate <NSObject>

@optional
- (void)tableViewCellDeleteAtIndex:(NSIndexPath *)index;
- (void)tableViewCellEditAtIndex:(NSIndexPath *)index;
@end

@interface TableViewCell : UITableViewCell {
    
    NSIndexPath *currentCell;
}

@property (nonatomic, weak) IBOutlet UILabel *lblName;

@property (nonatomic, weak) id<TableViewCellDelegate>delegate;

- (void)setCellWithDepartment:(Department *)department atIndex:(NSIndexPath *)index;
- (void)setCellWithEmployee:(Employee *)employee atIndex:(nonnull NSIndexPath *)index;

@end

NS_ASSUME_NONNULL_END
