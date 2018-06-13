//
//  AlipayTool.h
//  AllPayDemo
//
//  Created by JGPeng on 16/10/24.
//  Copyright © 2016年 彭金光. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>

#pragma mark - 支付宝支付的配置信息，也是主要修改的地方

/*====================================================================*/
/*=======================需要商户app申请的境内===========================*/
/*====================================================================*/

#define PARTENER @"2088721464787697";

#define SELLER @"2088721464787697";
//APPID
#define APPID @"2017072007820014"
//私钥
#define RSA_ALIPAY_PRIVATE @"MIICXAIBAAKBgQDdNPc9HC940smq3iiip1GwHUukFirspq5Ir4ajdDxdMPWQGNgiLpBsVZHdSWms10V4d/zRC117qegIgVT/J0zlmGk7VumI8R0V/I5BJQR5S+KZ38wJEVysyyLzwaHVmf32S9e94JznifAv1cDOXNFpMFFlCVlN3ZTc5Za/5z1PPQIDAQABAoGAPVlzOH+YqunLBJiYrIO7JBz73YZIYVnY/E+yB6M1GqN5d31sdA51/5W73qN9q3II0mB0vYVpZ+K3d6Rm7lz39jE9keIv3UU3pIiIn6L1bVR+SCWWYCUGqpuaPEVh7yUhWnmweEr5Dg3rkYJT81PBqihDHpz6dafWNawYhxhJhAECQQD119BlWH+/mbk626BtZsZ/st8lLBqPw1TEC0laOivXDUDsIspgx4E5IX7s9sqKOVMd7iqsplA7i4MNBihXkITLAkEA5liVw5Hx6RscwQ/O+gYISqu4a8W1yEN9Z3mVOei54yiZ82I4EhFxCMjXBgIMRwfj52I6z7nwh7qDRzzxA7kDFwJBAIswSjPm/EUNktrpGBZ4tu/75O0V4F/+1pI8VaZ5AvM59MT9GZnbuqUO+t7NB3Vk6VMr0gt4Cjr8TRFlqBeToisCQBZtd5+EHUayEhmmHWPwpGwIzjsIFAv8rkAd8W6i/z5j3KF65bS0qAnP7Ee0eVeNKB6GTO2e0BGXEmMkRt8y618CQFXKuHCTVwneBnw7JNNBGz1xiIjvNcpTuqaynG5GpEB4O22wCmJTsC2/uNlucd0ogw2OLKN15gRgZgdoCH8xqUE="
//公钥
#define RSA_ALIPAY_PUBLIC @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDI6d306Q8fIfCOaTXyiUeJHkrIvYISRcc73s3vF1ZT7XN8RNPwJxo8pWaJMmvyTn9N4HQ632qJBVHf8sxHi/fEsraprwCtzvzQETrNRwVxLO5jVmRGi60j8Ue1efIlzPXV9je9mkjzOmdssymZkh2QhUrCmZYI/FCEa3/cNMW0QIDAQAB"
//支付结果回调页面
#define NOTIFY_URL        @"http://youlianjingxuan.com/home/alipays/payNotify"
//支付宝的appScheme
#define AppScheme         @"aliPay"

/*====================================================================*/
/*=======================需要商户app申请的国际===========================*/
/*====================================================================*/

//商户ID
#define PARTNER_International    @"208125254"
//账号ID
#define SELLER_International     @"99bl@ily.com"
//私钥
#define RSA_ALIPAY_PRIVATE_International @"MIICXAIBAAKBgQDdNPc9HC940smq3iiip1GwHUukFirspq5Ir4ajdDxdMPWQGNgiLpBsVZHdSWms10V4d/zRC117qegIgVT/J0zlmGk7VumI8R0V/I5BJQR5S+KZ38wJEVysyyLzwaHVmf32S9e94JznifAv1cDOXNFpMFFlCVlN3ZTc5Za/5z1PPQIDAQABAoGAPVlzOH+YqunLBJiYrIO7JBz73YZIYVnY/E+yB6M1GqN5d31sdA51/5W73qN9q3II0mB0vYVpZ+K3d6Rm7lz39jE9keIv3UU3pIiIn6L1bVR+SCWWYCUGqpuaPEVh7yUhWnmweEr5Dg3rkYJT81PBqihDHpz6dafWNawYhxhJhAECQQD119BlWH+/mbk626BtZsZ/st8lLBqPw1TEC0laOivXDUDsIspgx4E5IX7s9sqKOVMd7iqsplA7i4MNBihXkITLAkEA5liVw5Hx6RscwQ/O+gYISqu4a8W1yEN9Z3mVOei54yiZ82I4EhFxCMjXBgIMRwfj52I6z7nwh7qDRzzxA7kDFwJBAIswSjPm/EUNktrpGBZ4tu/75O0V4F/+1pI8VaZ5AvM59MT9GZnbuqUO+t7NB3Vk6VMr0gt4Cjr8TRFlqBeToisCQBZtd5+EHUayEhmmHWPwpGwIzjsIFAv8rkAd8W6i/z5j3KF65bS0qAnP7Ee0eVeNKB6GTO2e0BGXEmMkRt8y618CQFXKuHCTVwneBnw7JNNBGz1xiIjvNcpTuqaynG5GpEB4O22wCmJTsC2/uNlucd0ogw2OLKN15gRgZgdoCH8xqUE="
//公钥
#define RSA_ALIPAY_PUBLIC_International @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDj6wl1VQC0/H1eUbScTON9xQYSkMW62713cOw4bMuqYgNJ3GXs8G1dzdZbvoaVWuofmqj3igpfVhJoszrZppCAttgpfG5DA8bHuFoJqPvGy+uQLyXPpSfXeNST9tx1ILSjPiTB6Rr3r+CsilQm4BBkbHixTuTP9dTfTvbCG2a26wIDAQAB"

/**
 *  支付宝支付成功回调
 */
typedef void (^AliPaySuccess)();

/**
 *  支付宝支付失败回调
 *
 *  @param desc 失败描述
 */
typedef void (^AliPayFailed)(NSString * desc);

@interface AlipayTool : NSObject

/**************************** 支付宝支付  ******************************/

/**
 *  掉起支付宝支付
 *
 *  @param orderSn          订单号
 *  @param orderName        订单名称
 *  @param orderDescription 订单描述
 *  @param OrderPrice       订单价格 //于微信不同的是 0.01是1分
 *  @param success          成功回调
 *  @param Failed           失败回调
 */
+ (void)sendAlipayWithOrderSn:(NSString *)orderSn
                    orderName:(NSString *)orderName
             orderDescription:(NSString *)orderDescription
                   orderPrice:(NSString *)OrderPrice
                 SuccessBlock:(AliPaySuccess)success
                  FailedBlock:(AliPayFailed)Failed;

/**************************** 国际化支付  ******************************/

/**
 *  掉起支付宝支付
 *
 *  @param orderSn          订单号
 *  @param orderName        订单名称
 *  @param orderDescription 订单描述
 *  @param OrderPrice       订单价格 //于微信不同的是 0.01是1分
 *  @param success          成功回调
 *  @param Failed           失败回调
 */
+ (void)OutsideAlipayWithOrderSn:(NSString *)orderSn
                       orderName:(NSString *)orderName
                orderDescription:(NSString *)orderDescription
                      orderPrice:(NSString *)OrderPrice
                    SuccessBlock:(AliPaySuccess)success
                     FailedBlock:(AliPayFailed)Failed;


@end
