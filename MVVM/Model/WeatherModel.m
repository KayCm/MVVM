//
//  WeatherModel.m
//  MVVM
//
//  Created by M on 16/1/7.
//  Copyright © 2016年 Meng. All rights reserved.
//

#import "WeatherModel.h"

@implementation WeatherModel

-(id)initWithDictionary:(NSDictionary*)dic
{
    
    NSLog(@"Dic:%@",dic);
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    
    return self;
    
}
@end
