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

#pragma mark ============实现NSCoding协议 

//归档
- (void)encodeWithCoder:(NSCoder *)Coder
{

    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd,hh:mm:ss"];
    
    NSString *str = [NSString stringWithFormat:@"Cached@:%@",[dateformatter stringFromDate:senddate]];
    
    [Coder encodeObject:_citynm forKey:@"CityName"];
    [Coder encodeObject:_weather forKey:@"Weather"];
    [Coder encodeObject:_temperature_curr forKey:@"NowTemp"];
    [Coder encodeObject:str forKey:@"days"];
    [Coder encodeObject:UIImagePNGRepresentation(_Logo) forKey:@"img"];
    
}

//解档
- (nullable instancetype)initWithCoder:(NSCoder *)Decoder // NS_DESIGNATED_INITIALIZER
{
    
    if (self = [super init]) {
        
        
        self.citynm = [Decoder decodeObjectForKey:@"CityName"];
        self.weather = [Decoder decodeObjectForKey:@"Weather"];
        self.temperature_curr = [Decoder decodeObjectForKey:@"NowTemp"];
        self.days   =   [Decoder decodeObjectForKey:@"days"];
        self.Logo = [UIImage imageWithData:[Decoder decodeObjectForKey:@"img"]];
        
        
    }
    
    
    return self;
}





@end
