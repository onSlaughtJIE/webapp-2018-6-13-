//
//  ViewController.m
//  webapp
//
//  Created by 放 on 2017/9/11.
//  Copyright © 2017年 放. All rights reserved.
//

#import "WebViewController.h"
#import "YZLocationManager.h"
#import "MapViewController.h"


@interface WebViewController () <UIWebViewDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *mainWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) YZLocationManager *manager;

@end

@implementation WebViewController
#define URL_STRING @""

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jumpToUrl:) name:@"jump" object:nil];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (void)jumpToUrl:(NSNotification *)noti {
    NSURL *url = [NSURL URLWithString:noti.object];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.mainWebView loadRequest:request];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self netCheck];
    self.mainWebView.scrollView.bounces = NO;
    self.mainWebView.backgroundColor = [UIColor clearColor];
    self.mainWebView.scrollView.showsVerticalScrollIndicator =NO;
    
    if ([self.urlString isEqualToString:@""] || self.urlString == nil) {
        self.urlString = URL_STRING;
    }
    
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.mainWebView loadRequest:request];
    //添加手势长按保存按钮
    UILongPressGestureRecognizer *longPressed = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
    longPressed.delegate = self;
    //有需要保存图片功能的打开下面代码
    //    [self.mainWebView addGestureRecognizer:longPressed];
    
    
    //    地图定位
    //    [self performSelector:@selector(startLocationService) withObject:nil afterDelay:0.5];
}


/*
- (void)startLocationService{
    
    YZLocationManager *manager = [YZLocationManager sharedLocationManager];
    manager.isBackGroundLocation = YES;
    manager.locationInterval = 10;
    
    //    @weakify(manager)
    [manager setYZBackGroundLocationHander:^(CLLocationCoordinate2D coordinate) {
        _plc(coordinate);
        YZLMLOG(@"纬度--%f,经度--%f",coordinate.latitude,coordinate.longitude);
    }];
    
    [manager setYZBackGroundGeocderAddressHander:^(NSString *address) {
        YZLMLOG(@"address:%@",address);
    }];
    [manager startLocationService];
}

*/


- (NSString *)dateString{
    
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    // 设置日期格式
    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];
    
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    return dateString;
}


    
//开始加载数据
- (void)webViewDidStartLoad:(UIWebView *)webView {
//    [self.activityIndicator setHidden:NO];
//    [self.activityIndicator startAnimating];
    [self.activityIndicator stopAnimating];
    [self.activityIndicator setHidden:YES];
}
//数据加载完
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //去除webView中的选中、复制（慎用，里面可能有复制链接的功能）
//[webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    
    JSContext *context = [self.mainWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //定义好JS要调用的方法, share就是调用的share方法名
    
    [self addPayActionWithContext:context];
    
    NSLog(@"%@",context);
}

//- (void)jump {
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    MapViewController *mapVC = [sb instantiateViewControllerWithIdentifier:@"MapViewController"];
//    [self.navigationController pushViewController:mapVC animated:YES];
//}
- (void)addPayActionWithContext:(JSContext *)context
{
//        LBWeakSelf(self);
        //将context对象与js方法建立桥接联系  weixin_app_pay：表示我们js里面的方法名 和后台约定好
        context[@"weixin_app_pay"] = ^() {
            //通过Block成功的在JavaScript调用方法回到了Objective-C，而且依然遵循JavaScript方法的各种特点，比如方法参数不固定。也因为这样，JSContext提供了类方法来获取参数列表
            NSArray *args = [JSContext currentArguments];
            NSString *orderString = @"";
            for (id obj in args) {
                NSString *string = [NSString stringWithFormat:@"%@",obj];
                orderString = string;
            }
            [[NSUserDefaults standardUserDefaults] setObject:@[@"dalibao"] forKey:@"dalibao"];
            LBLog(@"%@---",orderString);
            [LBHTTPRequest getWechatParamsWithOIderId:@{@"orderid":orderString} resultBlock:^(NSDictionary *resultDic, NSError *error) {
                    NSLog(@"%@",resultDic);
                    NSMutableDictionary *dataDic = resultDic[@"data"];
                    NSMutableDictionary *modelDic = [NSMutableDictionary dictionary];
                    modelDic[@"appId"] = dataDic[@"appid"];
                    modelDic[@"mch_id"] = dataDic[@"partnerid"];
                    modelDic[@"prepayId"] = dataDic[@"prepayid"];
                    modelDic[@"nonceStr"] = dataDic[@"noncestr"];
                    modelDic[@"timeStamp"] = dataDic[@"timestamp"];
                    modelDic[@"paySign"] = dataDic[@"package"];
                    [MXWechatPayHandler jumpToWxPayWithDic:modelDic];
            }];
        };

}
#pragma mark - 检测网络状态
-(void)netCheck{
    AFNetworkReachabilityManager *netManager = [AFNetworkReachabilityManager sharedManager];
    [netManager startMonitoring];  //开始监听
    [netManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        
        if (status == AFNetworkReachabilityStatusNotReachable ||status ==AFNetworkReachabilityStatusUnknown)
        {
            LBLog(@"检测网络状态(未知或无网)==%ld",status);
            //返回主线程执行修改UI
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIAlertController *alerViewC = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前网络不可用,是否重新加载" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *sureAc = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    //无网络一直循环弹窗
                    [self netCheck];
                    //                    重新加载页面
                    self.mainWebView.scrollView.bounces = NO;
                    self.mainWebView.backgroundColor = [UIColor clearColor];
                    self.mainWebView.scrollView.showsVerticalScrollIndicator =NO;
                    
                    if ([self.urlString isEqualToString:@""] || self.urlString == nil) {
                        self.urlString = URL_STRING;
                    }
                    
                    NSURL *url = [NSURL URLWithString:self.urlString];
                    NSURLRequest *request = [NSURLRequest requestWithURL:url];
                    [self.mainWebView loadRequest:request];
                }];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alerViewC addAction:cancelAction];
                [alerViewC addAction:sureAc];
                [self presentViewController:alerViewC animated:YES completion:nil];
            });
            
            
            
        }else{
            
            LBLog(@"手机或者wifi==%ld",status);
        }
        
    }];
    
}
#pragma mark - 长按保存事件
-(void)longPressed:(UILongPressGestureRecognizer *)recognizer{
    if (recognizer.state != UIGestureRecognizerStateBegan) {
        return;
    }
    CGPoint touchPoint = [recognizer locationInView:self.mainWebView];
    
    NSString *imagURL = [NSString stringWithFormat:@"document.elementFromPoint(%f,%f).src",touchPoint.x,touchPoint.y];
    NSString *urlToSave = [self.mainWebView stringByEvaluatingJavaScriptFromString:imagURL];
    if (urlToSave.length == 0) {
        return;
    }
    [self showImageOptionsWithUrl:urlToSave];
    
}
-(void)showImageOptionsWithUrl:(NSString *)imageUrl{
    UIAlertController *alerCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"您要保存图片吗?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self saveImageToDiskWithUrl:imageUrl];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [MBProgressHUD showError:@"保存图片失败"];
    }];
    [alerCon addAction:saveAction];
    [alerCon addAction:cancelAction];
    
    [self presentViewController:alerCon animated:YES completion:nil];
    
}

-(void)saveImageToDiskWithUrl:(NSString *)iamgeUrl{
    NSURL *imgUrl = [NSURL URLWithString:iamgeUrl];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue new]];
    NSURLRequest *imgRequest = [NSURLRequest requestWithURL:imgUrl cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30.0];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:imgRequest completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            LBLog(@"%@",error);
            return ;
        }
        NSData *imageData = [NSData dataWithContentsOfURL:location];
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:imageData];
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
            
        });
    }];
    
    [task resume];
}

-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        [MBProgressHUD showError:@"保存图片失败"];
    }else{
        [MBProgressHUD showSuccess:@"保存图片成功"];
    }
    
}
//由于UIWebView内部是有一个ScrollView，默认情况下不支持多个手势的，因此需要实现UIGestureRecognizerDelegatede 的下面的方法
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(nonnull UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

