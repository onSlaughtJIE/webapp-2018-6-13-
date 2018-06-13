//
//  LBServeConfig.m
//  webapp
//
//  Created by 放 on 2017/4/27.
//  Copyright © 2017年 放. All rights reserved.
//

#import "LBServeConfig.h"

static NSString *LBConfigEnv;  //环境参数 00: 测试环境,01: 生产环境

@implementation LBServeConfig

+(void)setLBConfigEnv:(NSString *)value
{
    LBConfigEnv = value;
}

+(NSString *)LBConfigEnv
{
    return LBConfigEnv;
}
//获取服务器地址
+ (NSString *)getLBServerAddress{
    if ([LBConfigEnv isEqualToString:@"00"]) {
        return kTestURLString;
    }else{
        return kOnlineURLString;
    }
}
@end
