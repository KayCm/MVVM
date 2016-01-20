//
//  NetViewModel.m
//  MVVM
//
//  Created by M on 16/1/7.
//  Copyright © 2016年 Meng. All rights reserved.
//

#import "NetViewModel.h"
#import "AFNetworking.h"
#import "WeatherModel.h"

#import "ArchiverCache.h"

@implementation NetViewModel


-(void)NetViewModelWithBlock:(void (^) (id returnValue)) Return SetFailure:(void(^)(id FailureVaue))Failure SetError:(void(^)(id ErrorValue)) Error SetUrl:(NSString*)url
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"loading");
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"Re:%d",[responseObject[@"success"] intValue]);
    
        
        if ([responseObject[@"success"] intValue] == 1) {
            
            Return([self ConvertToModel:responseObject[@"result"]]);
            
        }else{
            
            Failure(responseObject);
            
        }
        
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        Error(error);
        
    }];
    
}

-(void)NetViewModelWithDelegateWith:(NSString*)url
{
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    [session GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"loading");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([self.Delegate respondsToSelector:@selector(NetDelegateSuccessValue:)]) {
            
            [self.Delegate performSelector:@selector(NetDelegateSuccessValue:) withObject:[self ConvertToModel:responseObject[@"result"]]];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if ([self.Delegate respondsToSelector:@selector(NetDelegateFailureValue:)]) {
            
            [self.Delegate performSelector:@selector(NetDelegateFailureValue:) withObject:error];
            
        }
    }];
    
}

-(void)NetViewModelWithNotiWithUrl:(NSString*)url
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    [session GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"loading");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Noti" object:[self ConvertToModel:responseObject[@"result"]]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Noti" object:error];
    }];
    
}

-(id)NetViewModelWithCache
{
    //读取缓存...
    ArchiverCache *ar = [[ArchiverCache alloc] init];
    //需在相应的model实现 initWithCoder;
    WeatherModel *Wm = [ar UncoderDoWith];
    
    return Wm;
}



-(id)ConvertToModel:(id)Data
{
    
    WeatherModel *model = [[WeatherModel alloc] initWithDictionary:Data];
    
    ///转成模型,同时把IMG给下载了.....由于API里的ICON是GIF,为了省事,这里直接另找了一张图.(可用sdwebimage来处理gif)
    NSString *imageURLStr = @"http://pic.58pic.com/58pic/15/48/73/04f58PIC37y_1024.png";
    
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:imageURLStr]];
    
    model.Logo = [UIImage imageWithData:imageData];
    
    
    ArchiverCache *ar = [[ArchiverCache alloc] init];
    
    //需在相应的model实现 encodeWithCoder;
    [ar EncoderDoWithModel:model];
    
   
    
    return model;
}



@end
