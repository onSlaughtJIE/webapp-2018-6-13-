//
//  Macro.h
//  webapp
//
//  Created by 放 on 2017/5/2.
//  Copyright © 2017年 ZCH. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

/** 导航栏高度 */
#define NAVIGATION_BAR_HEIGHT 44
//距离左边边距为10
#define LeftDistance 10
/** 状态栏高度 */
#define STATUS_BAR_HEIGHT 20
/** 标签栏高度 */
#define TABBAR_HEIGHT 49
/** 工具栏高度 */
#define TOOLBAR_HEIGHT 49
/** 黄金比例值 0.382+0.618=1   0.382/0.618=0.618   0.618/1=0.618 */
#define GOLD_SCALE_LONG(x)  (x * 0.618)
#define GOLD_SCALE_SHORT(x) (x * 0.382)

#define LBAppDelegate (AppDelegate *)[UIApplication sharedApplication].delegate
#define LBKeyWindow [UIApplication sharedApplication].keyWindow

/** 懒加载 */
#define LB_LAZY(object, assignment) (object = object ?: assignment)

/** 屏幕宽度 */
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
/** 屏幕高度 */
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
/** 比例 */
#define kScale   [[UIScreen mainScreen] bounds].size.width/320
/** 定义自己的log */
#ifdef DEBUG
#define LBLog(...) NSLog(@"%s 第%d行\n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define LBLog(...)
#endif

/** 弱引用/强引用 */
#define LBWeakSelf(type) __weak typeof(type) weak##type = type;
#define LBStrongSelf(type) __strong typeof(type) type = weak##type;
/** 设置view圆角和边框 */
#define LBViewBorderRadius(View,Radius,Width,Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

/** 安全释放宏 */
#define Release_Safe(_control) [_control release], _control = nil;

/*
*   传入RGBA四个参数，得到颜色
*   美工和设计通过PS给出的色值是0~255
*   苹果的RGB参数给出的是0~1
*   那我们就让美工给出的 参数/255 得到一个0-1之间的数
*/
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
/** 传入RGB三个参数，得到颜色 */
#define RGB(r,g,b) RGBA(r,g,b,1.f)
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//navigationbar
#define kBGCOLOR RGB(3, 152, 255)
//#define kBGCOLOR RGB(255, 255, 255)
//首页背景
//#define kHomePageViewBGCOLOR RGB(245,246,248)
#define kHomePageViewBGCOLOR RGB(240,240,240)
//待抢菜单cell
#define kHomePageMenuBGCOLOR RGB(32,171,255)
//客户完善度  类似green
#define kCustomCicleBGCOLOR RGB(127,214,177)
/** 取得随机颜色 */
#define RandomColor RGB(arc4random()%256,arc4random()%256,arc4random()%256)

//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO)
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || [array count] < 1 ? YES : NO)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || [dic allKeys].count < 1 ? YES : NO)
//对象是否为空
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))


/**
 *  the saving objects      存储对象
 *
 *  @param __VALUE__ V
 *  @param __KEY__   K
 *
 *  @return
 */
#define kUserDefaultSetObjectForKey(__VALUE__,__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] setObject:__VALUE__ forKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

/**
 *  get the saved objects       获得存储的对象
 */
#define kUserDefaultObjectForKey(__KEY__)  [[NSUserDefaults standardUserDefaults] objectForKey:__KEY__]

/**
 *  delete objects      删除对象
 */
#define kUserDefaultRemoveObjectForKey(__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] removeObjectForKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

/** 子线程 */
#define kDisPatch_Global(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
/** 主线程 */
#define kDisPatch_Main(block) dispatch_async(dispatch_get_main_queue(),block)

/** 获取通知中心 */
#define kNotificationCenter [NSNotificationCenter defaultCenter]


//设备型号
#define IS_IPAD     [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
#define IS_IPHONE   [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )480) < DBL_EPSILON )
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )568) < DBL_EPSILON )
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )667) < DBL_EPSILON )
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )736) < DBL_EPSILON )


//系统版本
#define IS_IOS_VERSION  floorf([[UIDevice currentDevice].systemVersion floatValue]
#define IS_IOS_5   floorf([[UIDevice currentDevice].systemVersion floatValue]) ==5.0 ? 1 : 0
#define IS_IOS_6   floorf([[UIDevice currentDevice].systemVersion floatValue]) ==6.0 ? 1 : 0
#define IS_IOS_7   floorf([[UIDevice currentDevice].systemVersion floatValue]) ==7.0 ? 1 : 0
#define IS_IOS_8   floorf([[UIDevice currentDevice].systemVersion floatValue]) ==8.0 ? 1 : 0
#define IS_IOS_9   floorf([[UIDevice currentDevice].systemVersion floatValue]) ==9.0 ? 1 : 0
#define IS_IOS_10   floorf([[UIDevice currentDevice].systemVersion floatValue]) ==10.0 ? 1 : 0
















#endif /* Macro_h */
