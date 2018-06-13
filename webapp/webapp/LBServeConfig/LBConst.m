//
//  LBConst.m
//  webapp
//
//  Created by 放 on 2017/4/27.
//  Copyright © 2017年 放. All rights reserved.
//

#import "LBConst.h"

/********** Project Key ***********/

// 登录接口
NSString *const Loginkey = @"erp/baseData/EmployeeLoginServlet?";
// 获取待办菜单
NSString *const CateOrderskey = @"erp/cateCloud/clerkAssistant/RushOrderServlet?method=getList&methodChild=getCateOrders&";
// 等待确认订单
NSString *const UndoCateOrderkey = @"erp/cateCloud/clerkAssistant/RushOrderServlet?method=getBean&methodChild=getUndoCateOrder&";
// 获取点菜单
NSString *const DianMenuCateOrderskey = @"erp/cateCloud/cateOrder/CateOrderServlet?method=getList&methodChild=getCateOrders&";
// 获取客户列表
NSString *const MyShopCustomerUnitskey = @"erp/customer/CustomerUnitServlet?method=getList&methodChild=getMyShopCustomerUnits";
// 获取菜单详情
NSString *const CateOrderItemskey = @"erp/cateCloud/cateOrder/CateOrderServlet?method=getList&methodChild=getCateOrderItems&";
// 获取收银单列表
NSString *const CateSaleskey = @"erp/cateCloud/cateSale/CateSaleServlet?method=getList&methodChild=getCateSales&";
// 编辑菜单
NSString *const EditCateOrderkey = @"erp/cate/cateOrder/CateOrderServlet?method=dbDo&methodChild=editCateOrder&";
// 查找收银单
NSString *const SearchCateSalekey = @"erp/cateCloud/cateSale/CateSaleServlet?method=getList&methodChild=getSearchCateSales";



/********** 网络请求地址 ***********/

// 服务地址
//测试服务器
NSString *const kTestURLString = @"hhttp://api.bjdllt.com/";
//线上服务器
NSString *const kOnlineURLString = @"http://api.bjdllt.com/";








