//
//  MBProgressHUD+LB.h
//  CommonMethod
//
//  Created by 放 on 2016/11/25.
//  Copyright © 2016年 放. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (LB)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;
+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;
@end
