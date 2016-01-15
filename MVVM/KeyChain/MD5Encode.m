//
//  MD5Encode.m
//  MVVM
//
//  Created by M on 16/1/13.
//  Copyright © 2016年 Meng. All rights reserved.
//

#import "MD5Encode.h"
#import <CommonCrypto/CommonDigest.h>

@implementation MD5Encode

//需要向服务器验证token的时候调用
+(NSString *)MD5EncryptWith:(NSString*)code
{
    
    NSString *SaltCode = [NSString stringWithFormat:@"%@%@",code,[self daySalt]];
    
    const char *cStr = [SaltCode UTF8String];
    
    unsigned char result[16];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    
    NSMutableString *hash = [NSMutableString string];
    
    for (int i = 0; i < 16; i++){
        
        [hash appendFormat:@"%02X", result[i]];
        
    }
    
    return [hash lowercaseString];
}


+(NSString *)daySalt
{
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    //精确到小时,如果通过局域网抓包获得token,能保证一小时后失效,当然也可以精确到分,秒.(需要服务器配合)
    [dateformatter setDateFormat:@"YYYYMMddhh"];
    
    return [dateformatter stringFromDate:senddate];
}

@end
