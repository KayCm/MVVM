//
//  NetViewModel.h
//  MVVM
//
//  Created by M on 16/1/7.
//  Copyright © 2016年 Meng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>

@protocol NetViewModelDelegate < NSObject>


@optional

-(void)NetDelegateSuccessValue:(id)Value;
-(void)NetDelegateFailureValue:(id)Value;

@end


@interface NetViewModel : NSObject

@property(nonatomic,weak)id<NetViewModelDelegate> Delegate;

-(void)NetViewModelWithBlock:(void (^) (id returnValue)) Return SetFailure:(void(^)(id FailureVaue))Failure SetError:(void(^)(id ErrorValue)) Error SetUrl:(NSString*)url;

-(void)NetViewModelWithDelegateWith:(NSString*)url;

-(void)NetViewModelWithNotiWithUrl:(NSString*)url;

-(id)NetViewModelWithCache;

@end
