//
//  MD5+NSString.m
//  webapp
//
//  Created by u on 2017/4/8.
//  Copyright © 2017年 wql. All rights reserved.
//

#import "MD5+NSString.h"
#import <CommonCrypto/CommonDigest.h>
@implementation MD5_NSString

+ (NSString *)MD5WithString:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(data.bytes, (CC_LONG)data.length, buffer);
    
    //如下注释代码与上述加密代码等效
    //    data = [data MD5Sum];
    //    Byte *buffer = (Byte *)data.bytes;
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        [result appendFormat:@"%02x", buffer[i]];
    }
    
    return result;
}
@end
