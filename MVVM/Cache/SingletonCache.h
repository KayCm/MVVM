//
//  SingletonCache.h
//  MVVM
//
//  Created by M on 16/1/15.
//  Copyright © 2016年 Meng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingletonCache : NSObject

+(SingletonCache *)sharedManager;
-(id)ReadWithKey:(NSString*)Key;
-(void)LoadWithData:(id)data WithKey:(NSString*) Key;

@end
