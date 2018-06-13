//
//  LBHTTPRequest.m
//  webapp
//
//  Created by 放 on 2017/4/21.
//  Copyright © 2017年 放. All rights reserved.
//

#import "LBHTTPRequest.h"

@implementation LBHTTPRequest

#pragma mark - 登录接口
+ (void)getLoginWithParameter:(NSDictionary *)parameter resultBlock:(resultBlock)resultBlock{
//    [MBProgressHUD showMessage:@"正在登录"];
    NSString *urlString = [[LBServeConfig getLBServerAddress]stringByAppendingString:@"wechat"];
    LBLog(@"%@---%@",urlString,parameter);
    [LBNetWorkHelper GET:urlString parameters:parameter
    success:^(id responseObject) {
        resultBlock(responseObject,nil);
        LBLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        resultBlock(nil,error);
    }];
}
//http://api.bjdllt.com/goods/payapp
+(void)getWechatParamsWithOIderId:(NSDictionary *)param resultBlock:(resultBlock)resultBlock {
    NSString *urlString = [[LBServeConfig getLBServerAddress]stringByAppendingString:@"goods/payapp"];
    [LBNetWorkHelper GET:urlString parameters:param success:^(id responseObject) {
        resultBlock(responseObject,nil);
        LBLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        resultBlock(nil,error);
    }];
   
}

+(void)getPrepayIdWithParam:(NSDictionary *)param resultBlock:(resultBlock)resultBlock {
    NSString *urlString = @"https://api.mch.weixin.qq.com/pay/unifiedorder";
    [LBNetWorkHelper GET:urlString parameters:param success:^(id responseObject) {
        resultBlock(responseObject,nil);
        LBLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        resultBlock(nil,error);
    }];
}

#  pragma mark -
+(void)getLookpayIdWithParam:(NSDictionary *)param resultBlock:(resultBlock)resultBlock {
    NSString *urlString = [[LBServeConfig getLBServerAddress]stringByAppendingString:@"goods/payapps"];
    [LBNetWorkHelper GET:urlString parameters:param success:^(id responseObject) {
        resultBlock(responseObject,nil);
        LBLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        resultBlock(nil,error);
    }];
}
    
#pragma mark - 微信统窥探回调接口
+(void)getWeChatNotiWithParam:(NSDictionary *)param resultBlock:(resultBlock)resultBlock {
//    [MBProgressHUD showMessage:@"加载中..."];
    NSString *urlString = [[LBServeConfig getLBServerAddress]stringByAppendingString:@"orders/weChatNotifyApp"];
    [LBNetWorkHelper GET:urlString parameters:param success:^(id responseObject) {
        resultBlock(responseObject,nil);
        LBLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        resultBlock(nil,error);
    }];
}

#pragma mark - 窥探抢购接口
+(void)getBuyWithParam:(NSDictionary *)param resultBlock:(resultBlock)resultBlock {
    NSString *urlString = [[LBServeConfig getLBServerAddress]stringByAppendingString:@"goods/payapprush"];
    [LBNetWorkHelper GET:urlString parameters:param success:^(id responseObject) {
        resultBlock(responseObject,nil);
        LBLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        resultBlock(nil,error);
    }];
}
//    [LBNetWorkHelper POST:urlString parameters:param success:^(id responseObject) {
//        resultBlock(responseObject,nil);
//        LBLog(@"%@",responseObject);
//    } failure:^(NSError *error) {
//        resultBlock(nil,error);
//    }];
    



#pragma mark - 判断用户是否登录
+ (BOOL)isLogin{
    if (kDictIsEmpty(kUserDefaultObjectForKey(@"userInfo"))) {
        return NO;
    }else{
        return YES;
    }
}

#pragma mark - 退出登录
+ (void)exitLogin{
    kUserDefaultRemoveObjectForKey(@"userInfo");
    kUserDefaultRemoveObjectForKey(@"password");
}

#pragma mark - 获取用户ID
+ (NSString *)getUserID{
    if (!kDictIsEmpty(kUserDefaultObjectForKey(@"userInfo"))) {
        return [kUserDefaultObjectForKey(@"userInfo") objectForKey:@"wtsEmpID"];
    }else{
        return @"";
    }
}

#pragma mark - 获取用户名字
+ (NSString *)getUserName{
    if (!kDictIsEmpty(kUserDefaultObjectForKey(@"userInfo"))) {
        return [kUserDefaultObjectForKey(@"userInfo") objectForKey:@"wtsEmpName"];
    }else{
        return @"";
    }
}
#pragma mark - 获取用户所在公司ID
+ (NSString *)getUserCompanyID {
    if (!kDictIsEmpty(kUserDefaultObjectForKey(@"userInfo"))) {
        return [kUserDefaultObjectForKey(@"userInfo") objectForKey:@"wtsEmpCompany"];
    }else{
        return @"";
    }
}

#pragma mark - 获取用户所在单位
+ (NSString *)getUserModule{
    if (!kDictIsEmpty(kUserDefaultObjectForKey(@"userInfo"))) {
        return [kUserDefaultObjectForKey(@"userInfo") objectForKey:@"wtsEmpModule"];
    }else{
        return @"";
    }
}

#pragma mark - 获取用户所在部门
+ (NSString *)getUserDep{
    if (!kDictIsEmpty(kUserDefaultObjectForKey(@"userInfo"))) {
        return [kUserDefaultObjectForKey(@"userInfo") objectForKey:@"wtsEmpDep"];
    }else{
        return @"";
    }
}

#pragma mark - 获取用户工作
+ (NSString *)getUserJob{
    if (!kDictIsEmpty(kUserDefaultObjectForKey(@"userInfo"))) {
        return [kUserDefaultObjectForKey(@"userInfo") objectForKey:@"wtsEmpJob"];
    }else{
        return @"";
    }
}


@end
