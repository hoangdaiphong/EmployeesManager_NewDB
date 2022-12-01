//
//  JSON_Manger.h
//  EmployeesManager_NewDB
//
//  Created by Hoang  Dai Phong on 2022/12/01.
//  Copyright © 2022 HoangDaiPhong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSON_Manger : NSObject

+ (JSON_Manger *)parseJSON;

- (void)parseJSONDepartment;

- (void)parseJSONEmployee;

@end

NS_ASSUME_NONNULL_END
