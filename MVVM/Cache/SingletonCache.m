//
//  SingletonCache.m
//  MVVM
//
//  Created by M on 16/1/15.
//  Copyright © 2016年 Meng. All rights reserved.
//

#import "SingletonCache.h"

@interface SingletonCache ()

@property(nonatomic,strong)NSCache *cache;

@end

@implementation SingletonCache


+(SingletonCache *)sharedManager
{
    static SingletonCache *SingletonCacheInstance = nil;
    static dispatch_once_t predicate;
    
    
    dispatch_once(&predicate, ^{
        SingletonCacheInstance = [[self alloc] init];
        
        
    });
    return SingletonCacheInstance;
}

-(id)init
{
    if (self = [super init]) {
        
        _cache = [[NSCache alloc] init];
        
    }
    
    return self;
}


-(id)ReadWithKey:(NSString*)Key
{
    return [_cache objectForKey:Key];
}

-(void)LoadWithData:(id)data WithKey:(NSString*) Key
{
    [_cache setObject:data forKey:Key];
}


+(instancetype)alloc{
    NSAssert(0, @"单例对象,+(SingletonCache *)sharedManager");
    return nil;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    return [self alloc];
}
-(id)copy{
    NSLog(@"单例对象,别copy");
    return self;
}
+(instancetype)new{
    return  [self alloc];
}


@end
