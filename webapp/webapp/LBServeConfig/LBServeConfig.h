//
//  LBServeConfig.h
//  webapp
//
//  Created by 放 on 2017/4/27.
//  Copyright © 2017年 放. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBServeConfig : NSObject

// env: 环境参数 00: 测试环境 01: 生产环境
+ (void)setLBConfigEnv:(NSString *)value;

// 返回环境参数 00: 测试环境 01: 生产环境
+ (NSString *)LBConfigEnv;

// 获取服务器地址
+ (NSString *)getLBServerAddress;

@end
