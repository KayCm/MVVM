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



-(id)ConvertToModel:(id)Data
{
    
    WeatherModel *model = [[WeatherModel alloc] initWithDictionary:Data];
    
    
    return model;
}



@end
