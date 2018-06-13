
//微信支付的回调管理类
#import "WXApiManager.h"

@implementation WXApiManager

#pragma mark - 单粒

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WXApiManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXApiManager alloc] init];
    });
    return instance;
}

#pragma mark - WXApiDelegate

- (void)onResp:(BaseResp *)resp
{
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *strMsg;
        switch (resp.errCode) {
            case WXSuccess:{
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                NSArray *arr = [[NSUserDefaults standardUserDefaults]objectForKey:@"goodsid"];
                NSArray *dalibao = [[NSUserDefaults standardUserDefaults]objectForKey:@"dalibao"];
                NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"orderId"];
                NSArray *currentprice = [[NSUserDefaults standardUserDefaults]objectForKey:@"currentPrice"];
                [[DMCAlertCenter defaultCenter] postAlertWithMessage:@"支付成功"];
#pragma mark -  大礼包
                if ([dalibao count] > 0) {
                    [[NSUserDefaults standardUserDefaults]setObject:@[] forKey:@"dalibao"];
                    NSString *urlString = @"http://www.bjdllt.com/wy_paySuccess3.html?money=3986.00000";
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"jump" object:urlString];
                }
#pragma mark -  窥探
                if ([arr count] > 0) {
                    [[NSUserDefaults standardUserDefaults]setObject:@[] forKey:@"orderId"];
                    [[NSUserDefaults standardUserDefaults]setObject:@[] forKey:@"goodsid"];
                    [LBHTTPRequest getWeChatNotiWithParam:@{@"orderid":dic[@"orderId"]} resultBlock:^(NSDictionary *resultDic, NSError *error) {
                        NSLog(@"%@",resultDic);
//                        [MBProgressHUD hideHUD];
                        NSString *urlString = [NSString stringWithFormat:@"http://www.bjdllt.com/jyt_spxqkth.html?goodsid=%@",arr[0]];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"jump" object:urlString];
                    }];
                }
#pragma mark -  抢购
                if([currentprice count] > 0){
                    [[NSUserDefaults standardUserDefaults]setObject:@[] forKey:@"currentPrice"];
                    NSString *urlString = [NSString stringWithFormat:@"http://www.bjdllt.com/wy_paySuccess2.html?money=%@&current_price=%@",currentprice[1],currentprice[0]];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"jump" object:urlString];
                }
                break;
        }
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                [[DMCAlertCenter defaultCenter] postAlertWithMessage:@"支付失败"];
                break;
        }
    }
}


@end
