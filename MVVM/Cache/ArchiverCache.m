//
//  ArchiverCache.m
//  MVVM
//
//  Created by M on 16/1/11.
//  Copyright © 2016年 Meng. All rights reserved.
//

#import "ArchiverCache.h"

@implementation ArchiverCache


//archiver 
-(void)EncoderDoWithModel:(id)model
{
    NSMutableData *data = [[NSMutableData alloc] init];
    
    //创建归档辅助类
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    //编码
    [archiver encodeObject:model forKey:@"weather"];
    //结束编码
    [archiver finishEncoding];
    //写入
    
    if ([data writeToFile:[self GetFilePath] atomically:YES]) {
        
        NSLog(@"Cache Set Success");
        
    }else{
        
        NSLog(@"Cache Set Fail");
        
    }
    
}


//Unarchiver
-(id)UncoderDoWith
{
    ///////////////////////解档
    NSData *_data = [[NSData alloc] initWithContentsOfFile:[self GetFilePath]];
    //解档辅助
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:_data];

    //解码并解档出model
    id Wm = [unarchiver decodeObjectForKey:@"weather"];
    //关闭解档
    [unarchiver finishDecoding];
    
    return Wm;
}


-(NSString *)GetFilePath
{
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    //虽然该方法返回的是一个数组，但是由于一个目标文件夹只有一个目录，所以数组中只有一个元素。
    NSString *cachePath = [arr lastObject];
    
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"Model"];
//    NSLog(@"%@",filePath);
    
    return filePath;
}
@end
