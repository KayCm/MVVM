//
//  KeyChainIO.h
//  MVVM
//
//  Created by M on 16/1/13.
//  Copyright © 2016年 Meng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainIO : NSObject


+(void)SaveToken:(NSString *)Token;

+(id)ReadToken;

+(void)DeleteToken;

@end
